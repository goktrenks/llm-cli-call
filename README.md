# Chat with OpenAI's API using a .txt file

This script allows you to interact with OpenAI's API using a simple text file (`conversation.txt`) to manage and track your conversation history, with minimal dependencies.

## Features

- Talk to an LLM from the command line.
- Sends your conversation history to OpenAI's API and appends the AI's response to the conversation file.
- Can use different OpenAI models.
- Supports Unix-Based Systems (Linux/macOS) with Bash and Powershell for Windows.
  
## Requirements

### Unix-Based Systems (Linux/macOS)
1. **Bash**: Compatible with Unix-based systems (Linux/macOS).
2. **`jq`**: A command-line JSON processor.

   Install `jq` using:

   ```bash
   # Ubuntu/Debian
   sudo apt-get install jq

   # macOS (with Homebrew)
   brew install jq
   ```

### Windows Systems
1. **PowerShell**

---

## Getting Started

### 1. Clone the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/goktrenks/llm-cli-call.git
cd llm-cli-call
```

---

### 2. Set Up Your OpenAI API Key

#### Unix-Based Systems (Linux/macOS)
Export the API key as an environment variable:

```bash
export API_KEY=<your_api_key_here>
```

#### Windows Systems
Set the API key as an environment variable:

1. Open PowerShell.
2. Run the following command:

   ```powershell
   $Env:API_KEY = "<your_api_key_here>"
   ```

   Alternatively, you can set it permanently using the Windows environment variable settings.

---

### 3. Create a `conversation.txt` File

Create a `conversation.txt` file in the same directory as the script. Use the following structure to begin your conversation:

```txt
<user>Hello, who are you?</user>
<chatgpt>I am ChatGPT, a language model created by OpenAI.</chatgpt>
```

- **`<user>`**: Contains your input.
- **`<chatgpt>`**: Contains the AI's responses.

---

### 4. Run the Script

#### Unix-Based Systems
Run the script with:

```bash
bash script.sh
```

#### Windows Systems
Run the PowerShell script with:

```powershell
.\script.ps1
```

- The script reads the conversation history, sends it to OpenAI's API, and appends the response to `conversation.txt`.
- If the file is missing or empty, the script will notify you and exit.

---

## Example Workflow

1. Start with a `conversation.txt` file:

   ```txt
   <user>What is the capital of France?</user>
   ```

2. Run the script:

   - For Unix-based systems:

     ```bash
     bash script.sh
     ```

   - For Windows systems:

     ```powershell
     .\script.ps1
     ```

3. The script sends your query to OpenAI's API and appends the response:

   ```txt
   <user>What is the capital of France?</user>
   <chatgpt>The capital of France is Paris.</chatgpt>
   ```

4. Add more queries as `<user>` entries and rerun the script to continue the conversation.

---

## Changing the Model

By default, the script uses the `gpt-4o-mini` model. You can change the model in the script:

### Unix-Based Systems
Modify this line in `script.sh`:

```bash
"model": "gpt-4o-mini",
```

### Windows Systems
Modify this line in `script.ps1`:

```powershell
"model" = "gpt-4o-mini"
```

Alternatively, specify the model dynamically using an environment variable:

#### Unix-Based Systems
1. Export the model name:

   ```bash
   export OPENAI_MODEL=gpt-3.5-turbo
   ```

2. Update the script to use `$OPENAI_MODEL`.

#### Windows Systems
1. Set the model name:

   ```powershell
   $Env:OPENAI_MODEL = "gpt-3.5-turbo"
   ```

2. Update the script to use `$Env:OPENAI_MODEL`.

---

## License

This project is licensed under the MIT License. Feel free to modify, enhance, and share it!

---

This update includes a dedicated section for Windows users, detailing how to install and run the PowerShell script. Let me know if you need further refinements!
