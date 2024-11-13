# open-cli-copilot (Ollama support)

_Copilot-like autosuggestions generation for zsh._

Extends the [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) plugin by adding an LLM-based autosuggestion strategy and natural language command generation within the terminal.

https://github.com/user-attachments/assets/807711b1-5980-4e39-9902-27d7792fe2e2

## Installation


1. Clone project repository to the location of choice:

    ```sh
    git clone https://github.com/lbltavares/open-cli-copilot-ollama.git
    ```

2. Inside the project repository create python ```venv``` and install requirements:

    ```sh
    python -m venv venv && ./venv/bin/pip install -r requirements.txt
    ```

3. Source main script by adding to ```~/.zshrc``` the following line:

    ```sh
    source ~/path/to/open-cli-copilot/copilot.zsh
    ```

4. Start a new terminal session.

Note: Export `LLAMA_MODEL` environment variable to set desired ollama model (default is llama3.1).

## Requirements

- Zsh>=4.3.11
- Zsh-autosuggestions>=0.7.0
- Python>=3.9


## Roadmap

- Improve handling of special characters in buffer
- Resolve conflicts with the zsh history widget
- Integrate with open-source LLMs using Hugging Face Transformers
