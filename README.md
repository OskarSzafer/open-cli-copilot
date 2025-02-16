# open-cli-copilot

_Copilot-like autosuggestions generation for zsh._

Extends the [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) plugin by adding an LLM-based autosuggestion strategy and natural language command generation within the terminal.

https://github.com/user-attachments/assets/807711b1-5980-4e39-9902-27d7792fe2e2

## Installation


1. Clone the project repository to a location of your choice:

    ```sh
    git clone https://github.com/OskarSzafer/open-cli-copilot.git
    ```

2. Inside the project repository, create a Python ```venv``` and install requirements:

    ```sh
    python -m venv venv && ./venv/bin/pip install -r requirements.txt
    ```

3. Source the main script and export your API-key by adding the following lines to ```~/.zshrc```:

    ```sh
    export GOOGLE_API_KEY=<your_token>
    source ~/path/to/open-cli-copilot/copilot.zsh
    ```

    *You can obtain your API key from: [Google AI Studio](https://aistudio.google.com/app/apikey)*

4. Start a new terminal session.


## Requirements

- Zsh>=4.3.11
- Zsh-autosuggestions>=0.7.0
- Python>=3.9


## Roadmap

- [x] Improve handling of special characters in buffer
- [ ] Resolve conflicts with the zsh history widget
- [ ] Integrate with open-source LLMs using Hugging Face Transformers


## Acknowledgements

Thanks to all contributors for their help in making open-cli-copilot better!

Your contributions are greatly appreciated! 🙌


## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.