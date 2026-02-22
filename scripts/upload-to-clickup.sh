#!/bin/bash
# Upload Credentials PDF to ClickUp
# Last Updated: 2026-02-22

set -e

PDF_FILE="/Users/blackhat01/.claude/servers/ClawdBotArmy-Server-Credentials-Updated.pdf"
CLICKUP_API_KEY="${CLICKUP_API_KEY:-}"  # Set this as environment variable
CLICKUP_LIST_ID="${CLICKUP_LIST_ID:-}"   # Set this as environment variable

echo "===================================================="
echo "ClickUp PDF Upload"
echo "===================================================="
echo ""

# Check if PDF exists
if [ ! -f "$PDF_FILE" ]; then
    echo "❌ Error: PDF file not found at $PDF_FILE"
    exit 1
fi

# Check for API credentials
if [ -z "$CLICKUP_API_KEY" ]; then
    echo "⚠️  CLICKUP_API_KEY not set"
    echo "Please set it as an environment variable:"
    echo "  export CLICKUP_API_KEY='your-api-key'"
    echo ""
    echo "For now, the PDF is ready at:"
    echo "  $PDF_FILE"
    echo ""
    echo "You can manually upload it to ClickUp or set the API key and run this script again."
    exit 0
fi

if [ -z "$CLICKUP_LIST_ID" ]; then
    echo "⚠️  CLICKUP_LIST_ID not set"
    echo "Please set it as an environment variable:"
    echo "  export CLICKUP_LIST_ID='your-list-id'"
    exit 1
fi

# Upload to ClickUp
echo "📤 Uploading PDF to ClickUp..."

TASK_NAME="ClawdBotArmy Server Credentials - Updated $(date +%Y-%m-%d)"
TASK_DESCRIPTION="Updated server credentials for all 25 bot servers.

All passwords have been updated to cryptographically secure 18-character strings.
All servers now have OpenClaw v2026.2.21-2 and Node.js v22.22.0 installed.

See attached PDF for complete credentials."

# Create a ClickUp task with the PDF attached
RESPONSE=$(curl -s -X POST "https://api.clickup.com/api/v2/list/${CLICKUP_LIST_ID}/task" \
  -H "Authorization: ${CLICKUP_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"name\": \"${TASK_NAME}\",
    \"description\": \"${TASK_DESCRIPTION}\",
    \"status\": \"to do\",
    \"priority\": 2
  }")

TASK_ID=$(echo "$RESPONSE" | jq -r '.id')

if [ "$TASK_ID" != "null" ] && [ -n "$TASK_ID" ]; then
    echo "✅ Task created: $TASK_ID"

    # Attach the PDF
    echo "📎 Attaching PDF..."
    curl -s -X POST "https://api.clickup.com/api/v2/task/${TASK_ID}/attachment" \
      -H "Authorization: ${CLICKUP_API_KEY}" \
      -F "attachment=@${PDF_FILE}"

    echo "✅ PDF uploaded successfully to ClickUp"
    echo "Task ID: $TASK_ID"
else
    echo "❌ Failed to create ClickUp task"
    echo "Response: $RESPONSE"
    exit 1
fi

echo ""
echo "Done!"
