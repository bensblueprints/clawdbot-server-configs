#!/bin/bash
# Mass Deployment Script - All 25 ClawdBotArmy Servers
# Deploys OpenClaw, Node.js 22, and updates all passwords
# Last Updated: 2026-02-22

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
MAIN_SERVER="51.161.172.76"
CURRENT_PASSWORD="ClawdBot2026!"
PASSWORDS_FILE="/Users/blackhat01/.claude/servers/bot-passwords-new.json"
SETUP_SCRIPT="/Users/blackhat01/.claude/servers/standard-server-setup.sh"
LOG_FILE="/Users/blackhat01/.claude/servers/deployment-log-$(date +%Y%m%d-%H%M%S).log"

echo "====================================================" | tee -a "$LOG_FILE"
echo "ClawdBotArmy Mass Deployment Script" | tee -a "$LOG_FILE"
echo "====================================================" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"
echo "Starting deployment to all 25 bot servers..." | tee -a "$LOG_FILE"
echo "Log file: $LOG_FILE" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo -e "${YELLOW}⚠️  jq not found, installing...${NC}"
    brew install jq
fi

# Function to deploy to a single server
deploy_to_server() {
    local BOT_NUM=$1
    local BOT_ID=$(printf "%02d" $BOT_NUM)
    local PORT=$((2200 + BOT_NUM))
    local CODE_SERVER_PORT=$((8080 + BOT_NUM))
    local HOSTNAME="bot-${BOT_ID}"

    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" | tee -a "$LOG_FILE"
    echo -e "${BLUE}📦 Deploying to Bot-${BOT_ID} (Port: ${PORT})${NC}" | tee -a "$LOG_FILE"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" | tee -a "$LOG_FILE"

    # Extract passwords from JSON
    local NEW_ROOT_PASS=$(jq -r ".\"bot-${BOT_ID}\".root_password" "$PASSWORDS_FILE")
    local NEW_CODE_PASS=$(jq -r ".\"bot-${BOT_ID}\".code_server_password" "$PASSWORDS_FILE")

    # Create expect script for this server
    local EXPECT_SCRIPT="/tmp/deploy-bot-${BOT_ID}.exp"

    cat > "$EXPECT_SCRIPT" << 'EOF_EXPECT'
#!/usr/bin/expect -f
set timeout 120
set hostname [lindex $argv 0]
set port [lindex $argv 1]
set current_pass [lindex $argv 2]
set new_root_pass [lindex $argv 3]
set new_code_pass [lindex $argv 4]
set setup_script [lindex $argv 5]

# Connect to server
spawn ssh -p $port -o StrictHostKeyChecking=no root@$hostname
expect {
    "password:" {
        send "$current_pass\r"
    }
    timeout {
        puts "Connection timeout"
        exit 1
    }
}

# Wait for shell prompt
expect "#"

# Step 1: Upload setup script
puts "\n=== Uploading setup script ===\n"
send "cat > /tmp/standard-server-setup.sh << 'EOF_SETUP'\r"
expect "#"

# Read and send setup script content
set fp [open $setup_script r]
set script_content [read $fp]
close $fp
send "$script_content\r"
send "EOF_SETUP\r"
expect "#"

send "chmod +x /tmp/standard-server-setup.sh\r"
expect "#"

# Step 2: Run setup script
puts "\n=== Running setup script ===\n"
send "/tmp/standard-server-setup.sh\r"
expect {
    "#" { }
    timeout {
        puts "Setup script timeout"
    }
}

# Step 3: Update root password
puts "\n=== Updating root password ===\n"
send "echo 'root:$new_root_pass' | chpasswd\r"
expect "#"

# Step 4: Update code-server password
puts "\n=== Updating code-server password ===\n"
send "mkdir -p ~/.config/code-server\r"
expect "#"
send "cat > ~/.config/code-server/config.yaml << 'EOF_CONFIG'\r"
send "bind-addr: 0.0.0.0:8080\r"
send "auth: password\r"
send "password: $new_code_pass\r"
send "cert: false\r"
send "EOF_CONFIG\r"
expect "#"

# Restart code-server if it's running
send "systemctl restart code-server@root 2>/dev/null || true\r"
expect "#"

# Step 5: Verify installations
puts "\n=== Verifying installations ===\n"
send "node --version\r"
expect "#"
send "openclaw --version\r"
expect "#"

puts "\n=== Deployment complete ===\n"
send "exit\r"
expect eof
EOF_EXPECT

    chmod +x "$EXPECT_SCRIPT"

    # Run deployment
    echo -e "${YELLOW}🚀 Starting deployment...${NC}" | tee -a "$LOG_FILE"

    if "$EXPECT_SCRIPT" "$MAIN_SERVER" "$PORT" "$CURRENT_PASSWORD" "$NEW_ROOT_PASS" "$NEW_CODE_PASS" "$SETUP_SCRIPT" >> "$LOG_FILE" 2>&1; then
        echo -e "${GREEN}✅ Bot-${BOT_ID} deployment successful${NC}" | tee -a "$LOG_FILE"
        echo "   Root password updated" | tee -a "$LOG_FILE"
        echo "   code-server password updated" | tee -a "$LOG_FILE"
        echo "   OpenClaw and Node.js 22 installed" | tee -a "$LOG_FILE"
        return 0
    else
        echo -e "${RED}❌ Bot-${BOT_ID} deployment failed${NC}" | tee -a "$LOG_FILE"
        return 1
    fi

    # Cleanup
    rm -f "$EXPECT_SCRIPT"
    echo "" | tee -a "$LOG_FILE"
}

# Main deployment loop
SUCCESSFUL=0
FAILED=0

for BOT_NUM in {1..25}; do
    if deploy_to_server $BOT_NUM; then
        ((SUCCESSFUL++))
    else
        ((FAILED++))
    fi

    # Small delay between deployments
    sleep 2
done

# Summary
echo -e "${BLUE}====================================================${NC}" | tee -a "$LOG_FILE"
echo -e "${BLUE}Deployment Summary${NC}" | tee -a "$LOG_FILE"
echo -e "${BLUE}====================================================${NC}" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"
echo -e "${GREEN}✅ Successful: $SUCCESSFUL${NC}" | tee -a "$LOG_FILE"
if [ $FAILED -gt 0 ]; then
    echo -e "${RED}❌ Failed: $FAILED${NC}" | tee -a "$LOG_FILE"
fi
echo "" | tee -a "$LOG_FILE"
echo "Full log: $LOG_FILE" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 All servers deployed successfully!${NC}" | tee -a "$LOG_FILE"
    exit 0
else
    echo -e "${YELLOW}⚠️  Some servers failed. Check log for details.${NC}" | tee -a "$LOG_FILE"
    exit 1
fi
