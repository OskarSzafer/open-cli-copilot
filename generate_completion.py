import os
import sys
import time
from pathlib import Path
from datetime import datetime

import google.generativeai as genai


SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))

# Directory to store temporary files, used to communicate with the terminal
TMP_FILES_DIR = os.path.join(SCRIPT_DIR, ".tmp")
tmp_files_dir_path = Path(TMP_FILES_DIR)

MIN_IDLE_TIME = 0.3
CHECK_INTERVAL = 0.1

genai.configure(api_key=os.getenv("GOOGLE_API_KEY"))
model = genai.GenerativeModel("gemini-1.5-flash")

prompt_template = """
You are command line copilot.
Use this command line history to better understand the user's expectations:
{command_history}
Use this output of the 'ls' commnad to better fit generated completion:
{ls_output}
Current working directory: {current_directory}
Current command line prompt: {current_prompt}
Propose how current prompt should be completed,
return completed command line prompt aleone with no explanation.
"""


def parse_file(file_path):
    with open(file_path, "r") as file:
        lines = file.readlines()

    current_prompt = lines[0].strip()
    current_directory = lines[1].strip()
    command_history = "".join(lines[3:18])
    ls_output = "".join(lines[18:])

    return prompt_template.format(
        command_history=command_history,
        ls_output=ls_output,
        current_directory=current_directory,
        current_prompt=current_prompt,
    )


def serve_terminal_session(context_file_path, option_file_path):
    context_modification_time = os.path.getmtime(context_file_path)
    options_modification_time = os.path.getmtime(option_file_path)

    if (
        context_modification_time >= options_modification_time
        and (time.time() - context_modification_time) > MIN_IDLE_TIME
    ):
        prompt = parse_file(context_file_path)

        if not prompt:
            return

        chat = model.start_chat(history=[])
        response = chat.send_message(prompt)
        completion = response.text.strip()

        with open(option_file_path, "w") as file:
            file.write(completion)


def handle_tmp_files(directory):
    for f in tmp_files_dir_path.glob("*.context*"):
        context_file_path = os.path.join(directory, f.name)

        for option_f in tmp_files_dir_path.glob(
            f.name.replace(".context", ".options")[:-6] + "*"
        ):
            option_file_path = os.path.join(directory, option_f)

        try:
            serve_terminal_session(context_file_path, option_file_path)
        except Exception as e:
            timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            sys.stderr.write(f"{timestamp} \t ERROR: {str(e)}\n")


def watch_files():
    while True:
        handle_tmp_files(TMP_FILES_DIR)

        # Limit frequency of checking for chenges
        time.sleep(CHECK_INTERVAL)


if __name__ == "__main__":
    watch_files()
