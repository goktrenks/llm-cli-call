#!/bin/bash

# The conversation file
CONVERSATION_FILE="conversation.txt"

# Check if the API key is set
if [[ -z "$API_KEY" ]]; then
  echo "Error: OpenAI API key not found!"
  echo "Please set the API key by adding it to the script or exporting it as an environment variable:"
  echo "  export API_KEY=<your_api_key_here>"
  exit 1
fi

# Check if the conversation file exists
if [[ ! -f "$CONVERSATION_FILE" ]]; then
  echo "Error: Conversation file '$CONVERSATION_FILE' not found!"
  exit 1
fi

# Extract the full conversation history into the OpenAI API format
CONVERSATION_HISTORY=""
while IFS= read -r line; do
  if [[ $line =~ \<user\>(.*)\<\/user\> ]]; then
    CONVERSATION_HISTORY+='{"role": "user", "content": "'"${BASH_REMATCH[1]}"'"},'
  elif [[ $line =~ \<chatgpt\>(.*)\<\/chatgpt\> ]]; then
    CONVERSATION_HISTORY+='{"role": "assistant", "content": "'"${BASH_REMATCH[1]}"'"},'
  fi

done < "$CONVERSATION_FILE"

# Remove the trailing comma from the JSON array
CONVERSATION_HISTORY=${CONVERSATION_HISTORY%,}

# Ensure there's at least some conversation context
if [[ -z "$CONVERSATION_HISTORY" ]]; then
  echo "Error: No conversation context found in '$CONVERSATION_FILE'."
  exit 1
fi

# Wrap the conversation history in a JSON array
CONVERSATION_JSON="[$CONVERSATION_HISTORY]"

# Send the full conversation history to OpenAI's API
RESPONSE=$(curl -s https://api.openai.com/v1/chat/completions \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-4o-mini",
    "messages": '"$CONVERSATION_JSON"',
    "max_tokens": 1000
  }' | jq -r '.choices[0].message.content')

# Check if the response is empty
if [[ -z "$RESPONSE" ]]; then
  echo "Error: No response from OpenAI API."
  exit 1
fi

echo "Response received:"
echo "$RESPONSE"

# Append the new user query and LLM response to the conversation file
echo "<chatgpt> $RESPONSE </chatgpt>" >> "$CONVERSATION_FILE"

echo "Response appended to '$CONVERSATION_FILE'."

