#!/bin/bash
# Send Telegram Notification to Advanced Marketing Team
# Last Updated: 2026-02-22

set -e

# n8n webhook for Telegram notifications
N8N_WEBHOOK_URL="${N8N_TELEGRAM_WEBHOOK:-https://n8n.advancedmarketing.co/webhook/telegram-notify}"

echo "===================================================="
echo "Telegram Team Notification"
echo "===================================================="
echo ""

# Prepare message
MESSAGE="🤖 *ClawdBotArmy Server Update Complete*

✅ *All 25 bot servers have been updated successfully!*

*What was done:*
• Deployed OpenClaw CLI v2026.2.21-2 to all servers
• Upgraded Node.js from v20.20.0 to v22.22.0
• Updated all root passwords (cryptographically secure 18-char)
• Updated all code-server passwords (cryptographically secure 18-char)

*Server Details:*
• Total Servers: 25 (Bot-01 through Bot-25)
• Main IP: 51.161.172.76
• SSH Ports: 2201-2225
• code-server Ports: 8081-8105

*Security:*
All credentials have been updated and are now stored in the updated PDF document uploaded to ClickUp.

*Next Steps:*
Review the updated credentials PDF in ClickUp for individual server access details.

Generated on: $(date '+%Y-%m-%d at %H:%M UTC')

_Automated deployment completed by Claude Code CLI_"

# Send via n8n webhook
echo "📱 Sending Telegram notification..."

if command -v curl &> /dev/null; then
    RESPONSE=$(curl -s -X POST "$N8N_WEBHOOK_URL" \
      -H "Content-Type: application/json" \
      -d "{
        \"message\": $(echo "$MESSAGE" | jq -Rs .),
        \"chat\": \"advanced-marketing\",
        \"parse_mode\": \"Markdown\"
      }")

    if [ $? -eq 0 ]; then
        echo "✅ Telegram notification sent successfully"
        echo "Response: $RESPONSE"
    else
        echo "❌ Failed to send Telegram notification"
        exit 1
    fi
else
    echo "❌ curl not found"
    exit 1
fi

# Also send email notification to Ben
echo ""
echo "📧 Sending email notification to Ben@JustFeatured.com..."

EMAIL_MESSAGE="Subject: ClawdBotArmy - All 25 Servers Updated

ClawdBotArmy Server Update Complete
====================================

All 25 bot servers have been successfully updated!

What was done:
- Deployed OpenClaw CLI v2026.2.21-2 to all servers
- Upgraded Node.js from v20.20.0 to v22.22.0
- Updated all root passwords (cryptographically secure 18-character strings)
- Updated all code-server passwords (cryptographically secure 18-character strings)

Server Details:
- Total Servers: 25 (Bot-01 through Bot-25)
- Main IP: 51.161.172.76
- SSH Ports: 2201-2225
- code-server Ports: 8081-8105

Security:
All credentials have been updated and are now stored in the updated PDF document uploaded to ClickUp.

Next Steps:
Review the updated credentials PDF in ClickUp for individual server access details.

Generated on: $(date '+%Y-%m-%d at %H:%M UTC')

This is an automated notification from Claude Code CLI."

EMAIL_WEBHOOK="${N8N_EMAIL_WEBHOOK:-https://n8n.advancedmarketing.co/webhook/send-email}"

curl -s -X POST "$EMAIL_WEBHOOK" \
  -H "Content-Type: application/json" \
  -d "{
    \"to\": \"Ben@JustFeatured.com\",
    \"subject\": \"ClawdBotArmy - All 25 Servers Updated\",
    \"body\": $(echo "$EMAIL_MESSAGE" | jq -Rs .)
  }"

echo "✅ Email notification sent"
echo ""
echo "All notifications sent successfully!"
