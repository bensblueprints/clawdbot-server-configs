#!/bin/bash
# Standard Server Setup Script for ClawdBotArmy Infrastructure
# Last Updated: 2026-02-22
# Purpose: Install all required software on new bot servers

set -e  # Exit on error

echo "===================================================="
echo "ClawdBotArmy - Standard Server Setup"
echo "===================================================="
echo ""

# Update system packages
echo "📦 Updating system packages..."
apt update && apt upgrade -y

# Install essential packages
echo "📦 Installing essential packages..."
apt install -y \
    curl \
    wget \
    git \
    build-essential \
    ca-certificates \
    gnupg \
    apt-transport-https \
    software-properties-common

# Install Node.js 22.x (required for OpenClaw)
echo "📦 Installing Node.js 22.x..."
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt install -y nodejs

# Verify Node.js installation
NODE_VERSION=$(node --version)
NPM_VERSION=$(npm --version)
echo "✅ Node.js installed: $NODE_VERSION"
echo "✅ npm installed: $NPM_VERSION"

# Install Python and pip
echo "📦 Installing Python..."
apt install -y python3 python3-pip

# Install OpenClaw CLI
echo "📦 Installing OpenClaw CLI..."
npm install -g openclaw@latest

# Verify OpenClaw installation
OPENCLAW_VERSION=$(openclaw --version 2>&1 | head -1)
echo "✅ OpenClaw installed: $OPENCLAW_VERSION"

# Install Claude Code CLI (if not already installed)
echo "📦 Checking for Claude Code CLI..."
if ! command -v claude &> /dev/null; then
    echo "Installing Claude Code CLI..."
    curl -fsSL https://claude.ai/install.sh | bash
else
    echo "✅ Claude Code CLI already installed"
fi

# Install code-server (VS Code in browser)
echo "📦 Installing code-server..."
if ! command -v code-server &> /dev/null; then
    curl -fsSL https://code-server.dev/install.sh | sh
else
    echo "✅ code-server already installed"
fi

# Clean up
echo "🧹 Cleaning up..."
apt autoremove -y
apt clean

# Display installed versions
echo ""
echo "===================================================="
echo "✅ Installation Complete!"
echo "===================================================="
echo ""
echo "Installed Software:"
echo "  - Node.js: $(node --version)"
echo "  - npm: $(npm --version)"
echo "  - Python: $(python3 --version | cut -d' ' -f2)"
echo "  - Git: $(git --version | cut -d' ' -f3)"
echo "  - OpenClaw: $(openclaw --version)"
echo "  - Claude Code: $(claude --version 2>&1 | head -1 || echo 'Not found')"
echo "  - code-server: $(code-server --version | head -1)"
echo ""
echo "System Information:"
echo "  - Hostname: $(hostname)"
echo "  - OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
echo "  - Kernel: $(uname -r)"
echo "  - CPU Cores: $(nproc)"
echo "  - RAM: $(free -h | grep Mem | awk '{print $2}')"
echo "  - Disk: $(df -h / | tail -1 | awk '{print $2}')"
echo ""
echo "===================================================="
