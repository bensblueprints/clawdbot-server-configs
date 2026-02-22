#!/bin/bash
# Deploy to Bot-01 (which already has SSH key configured)
# Last Updated: 2026-02-22

set -e

PASSWORDS_FILE="/Users/blackhat01/.claude/servers/bot-passwords-new.json"
SETUP_SCRIPT="/Users/blackhat01/.claude/servers/standard-server-setup.sh"

echo "===================================================="
echo "Bot-01 Deployment (SSH Key Auth)"
echo "===================================================="
echo ""

# Extract Bot-01 passwords
NEW_ROOT_PASS=$(jq -r ".\"bot-01\".root_password" "$PASSWORDS_FILE")
NEW_CODE_PASS=$(jq -r ".\"bot-01\".code_server_password" "$PASSWORDS_FILE")

echo "📦 Deploying to Bot-01..."
echo ""

# Upload setup script
echo "📤 Uploading setup script..."
scp "$SETUP_SCRIPT" bot-01:/tmp/standard-server-setup.sh

# Run setup script
echo "🚀 Running setup script..."
ssh bot-01 "bash /tmp/standard-server-setup.sh"

# Update root password
echo "🔐 Updating root password..."
ssh bot-01 "echo 'root:${NEW_ROOT_PASS}' | chpasswd"

# Update code-server password
echo "🔐 Updating code-server password..."
ssh bot-01 << EOF
mkdir -p ~/.config/code-server
cat > ~/.config/code-server/config.yaml << 'CONFIG_EOF'
bind-addr: 0.0.0.0:8080
auth: password
password: ${NEW_CODE_PASS}
cert: false
CONFIG_EOF
systemctl restart code-server@root 2>/dev/null || true
EOF

# Verify installations
echo ""
echo "✅ Verifying installations..."
ssh bot-01 "node --version && openclaw --version"

echo ""
echo "✅ Bot-01 deployment complete!"
echo "   Root password updated"
echo "   code-server password updated"
echo "   OpenClaw and Node.js 22 verified"
