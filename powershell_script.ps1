# The conversation file
$ConversationFile = "conversation.txt"

# Check if the API key is set
if (-not $Env:API_KEY) {
    Write-Error "Error: OpenAI API key not found!"
    Write-Host "Please set the API key by adding it to the script or exporting it as an environment variable:"
    Write-Host "  $Env:API_KEY=<your_api_key_here>"
    exit 1
}

# Check if the conversation file exists
if (-not (Test-Path -Path $ConversationFile)) {
    Write-Error "Error: Conversation file '$ConversationFile' not found!"
    exit 1
}

# Extract the full conversation history into the OpenAI API format
$ConversationHistory = @()

Get-Content -Path $ConversationFile | ForEach-Object {
    if ($_ -match '<user>(.*)</user>') {
        $ConversationHistory += @{
            role    = "user"
            content = $Matches[1]
        }
    } elseif ($_ -match '<chatgpt>(.*)</chatgpt>') {
        $ConversationHistory += @{
            role    = "assistant"
            content = $Matches[1]
        }
    }
}

# Ensure there's at least some conversation context
if ($ConversationHistory.Count -eq 0) {
    Write-Error "Error: No conversation context found in '$ConversationFile'."
    exit 1
}

# Convert the conversation history to JSON
$ConversationJson = $ConversationHistory | ConvertTo-Json -Depth 10 -Compress

# Send the full conversation history to OpenAI's API
$Response = Invoke-RestMethod -Uri "https://api.openai.com/v1/chat/completions" `
    -Headers @{
        "Authorization" = "Bearer $Env:API_KEY"
        "Content-Type"  = "application/json"
    } `
    -Method Post `
    -Body (@{
        model      = "gpt-4o-mini"
        messages   = $ConversationHistory
        max_tokens = 1000
    } | ConvertTo-Json -Depth 10 -Compress)

# Check if the response is empty
if (-not $Response.choices[0].message.content) {
    Write-Error "Error: No response from OpenAI API."
    exit 1
}

# Get the response content
$ResponseContent = $Response.choices[0].message.content
Write-Host "Response received:"
Write-Host $ResponseContent

# Append the new user query and LLM response to the conversation file
Add-Content -Path $ConversationFile -Value "<chatgpt> $ResponseContent </chatgpt>"

Write-Host "Response appended to '$ConversationFile'."
