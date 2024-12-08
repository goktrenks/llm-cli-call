# Chat with OpenAI's API using a .txt file

This script allows you to interact with OpenAI's API using a simple text file (`conversation.txt`) to manage and track your conversation history, with minimal dependencies.

## Features

- Talk to an LLM from the command line.
- Sends your conversation history to OpenAI's API and appends the AI's response to the conversation file.
- Fully customizable for different OpenAI models.


## Requirements

1. **Bash**: Compatible with Unix-based systems (Linux/macOS). For Windows, consider using WSL.
2. **`jq`**: A command-line JSON processor.

   Install `jq` using:

   ```bash
   # Ubuntu/Debian
   sudo apt-get install jq

   # macOS (with Homebrew)
   brew install jq
   ```


## Getting Started

### 1. Clone the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/goktrenks/llm-cli-call.git
cd llm-cli-call
```

### 2. Set Up Your OpenAI API Key

Export the API key as an environment variable for better security:

```bash
export API_KEY=<your_api_key_here>
```


### 3. Create a `conversation.txt` File

Create a `conversation.txt` file in the same directory as the script. Use the following structure to begin your conversation:

```txt
<user>Hello, who are you?</user>
<chatgpt>I am ChatGPT, a language model created by OpenAI.</chatgpt>
```

- **`<user>`**: Contains your input.
- **`<chatgpt>`**: Contains the AI's responses.


### 4. Run the Script

Run the script with:

```bash
bash script.sh
```

- The script reads the conversation history, sends it to OpenAI's API, and appends the response to `conversation.txt`.
- If the file is missing or empty, the script will notify you and exit.


## Example Workflow

1. Start with a `conversation.txt` file:

   ```txt
   <user>What is the capital of France?</user>
   ```

2. Run the script:

   ```bash
   bash script.sh
   ```

3. The script sends your query to OpenAI's API and appends the response:

   ```txt
   <user>What is the capital of France?</user>
   <chatgpt>The capital of France is Paris.</chatgpt>
   ```

4. Add more queries as `<user>` entries and rerun the script to continue the conversation.


## Changing the Model

By default, the script uses the `gpt-4o-mini` model. You can change the model in the script by modifying this line:

```bash
"model": "gpt-4o-mini",
```

For example:
- To use GPT-4: `"model": "gpt-4",`
- To use GPT-3.5-turbo: `"model": "gpt-3.5-turbo",`

Alternatively, you can dynamically specify the model using an environment variable:

1. Export the model name:

   ```bash
   export OPENAI_MODEL=gpt-3.5-turbo
   ```

2. Update the script to use `$OPENAI_MODEL`:

   ```bash
   "model": "'"$OPENAI_MODEL"'",
   ```

3. Now, you can change the model by updating the `OPENAI_MODEL` environment variable before running the script:

   ```bash
   export OPENAI_MODEL=gpt-4
   bash script.sh
   ```

## Notes

- **Error Handling**: If no conversation context is found, or if the API does not return a response, the script exits with an error.
- **Customizable**: Modify the script to meet your specific requirements, such as adding more API parameters or tweaking conversation formatting.

## License

This project is licensed under the MIT License. Feel free to modify, enhance, and share it!


