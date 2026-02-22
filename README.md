# ClawdBotArmy Server Configurations

> **Official server configuration repository for ClawdBotArmy VPS hosting infrastructure**

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Node.js](https://img.shields.io/badge/node-%3E%3D22.12.0-brightgreen.svg)](https://nodejs.org/)
[![OpenClaw](https://img.shields.io/badge/openclaw-2026.2.21--2-orange.svg)](https://npm.im/openclaw)

## 📋 Overview

This repository contains standardized server configurations, setup scripts, and documentation for managing ClawdBotArmy infrastructure. It provides:

- **Automated server setup scripts** for consistent deployments
- **Server configuration templates** for all infrastructure types
- **Installation standards** for required software
- **SSH configuration examples** for secure access
- **Complete documentation** of installed software and versions

## 🚀 Quick Start

### Automated Server Setup

Deploy a new bot server with one command:

```bash
# Copy setup script to new server
scp standard-server-setup.sh root@NEW_SERVER:/tmp/

# Run automated installation
ssh root@NEW_SERVER "bash /tmp/standard-server-setup.sh"
```

This installs:
- Node.js 22.x
- Python 3.10+
- Git
- **OpenClaw CLI** (Multi-channel AI gateway)
- Claude Code CLI
- code-server (VS Code in browser)

### Manual Installation

For existing servers, see [SERVER_STANDARD.md](SERVER_STANDARD.md) for step-by-step manual installation instructions.

## 📁 Repository Structure

```
clawdbot-server-configs/
├── README.md                    # This file
├── SERVER_INDEX.md              # Quick reference of all servers
├── SERVER_STANDARD.md           # Standard installation specs
├── INSTALLATION_LOG.md          # Installation history and logs
├── standard-server-setup.sh     # Automated setup script
├── bot-01-config.md             # Example bot configuration
├── configs/                     # Individual server configs
│   └── README.md
├── scripts/                     # Utility scripts
│   └── README.md
└── docs/                        # Additional documentation
    └── README.md
```

## 🖥️ Infrastructure Overview

### ClawdBotArmy Servers

**Main Infrastructure:**
- **OVH Dedicated Server** (51.161.172.76) - Proxmox host
- **Proxmox Web UI:** https://51.161.172.76:8006

**Bot Servers:**
- **Bot-01** (VMID 201) - Active production bot

### Bot Templates

| Template | RAM | CPU | Disk | VMID |
|----------|-----|-----|------|------|
| Solo Bot | 2GB | 2 | 40GB | 101 |
| Team Bot | 4GB | 4 | 80GB | 102 |
| Army Bot | 8GB | 8 | 160GB | 103 |

## 🛠️ Required Software

All servers run the following standard stack:

| Software | Version | Purpose |
|----------|---------|---------|
| Node.js | ≥ 22.12.0 | JavaScript runtime |
| npm | Latest | Package manager |
| Python | 3.10+ | Scripting |
| Git | Latest | Version control |
| **OpenClaw** | Latest | Multi-channel AI gateway |
| Claude Code | Latest | AI development assistant |
| code-server | Latest | Browser-based VS Code |

### Current Verified Versions
- Node.js: v22.22.0
- npm: 10.9.4
- Python: 3.10.12
- Git: 2.34.1
- OpenClaw: 2026.2.21-2
- code-server: 4.109.2

## 🔐 SSH Access

### Quick Connect

```bash
# Bot-01
ssh -p 2201 root@51.161.172.76

# With SSH config alias
ssh bot-01
```

### SSH Configuration Template

Add to `~/.ssh/config`:

```
Host bot-01
    HostName 51.161.172.76
    Port 2201
    User root
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
    StrictHostKeyChecking accept-new
```

## 📊 Server Standards

### Port Allocation
- **SSH:** 2200-2299 (Bot-01: 2201, Bot-02: 2202, etc.)
- **code-server:** 8080-8099 (Bot-01: 8081, Bot-02: 8082, etc.)
- **Custom apps:** 3000-3999
- **Admin tools:** 9000-9099

### Hostname Convention
- Templates: `{type}-bot-template`
- Customer bots: `bot-{vmid}`
- Infrastructure: `{service}-{purpose}`

## 🔧 Utility Scripts

### Verify Installation

```bash
# Check all installed software
ssh bot-01 "node --version && npm --version && python3 --version && git --version && openclaw --version && claude --version && code-server --version"
```

### System Status

```bash
# Get server status
ssh bot-01 "uptime && free -h && df -h /"
```

## 📝 Documentation

- **[SERVER_INDEX.md](SERVER_INDEX.md)** - Quick reference of all configured servers
- **[SERVER_STANDARD.md](SERVER_STANDARD.md)** - Detailed installation and configuration standards
- **[INSTALLATION_LOG.md](INSTALLATION_LOG.md)** - History of installations and upgrades
- **[bot-01-config.md](bot-01-config.md)** - Example server configuration

## 🚨 Important Notes

### Default Credentials
- **Initial root password:** `ClawdBot2026!`
- **code-server password:** `ClawdBot2026!`
- ⚠️ **Customers MUST change passwords on first login**

### Security
- SSH key authentication is mandatory
- Password authentication is fallback only
- All servers use UFW or iptables firewalls
- Fail2ban is configured for SSH protection

## 🔄 Updates and Maintenance

### Updating This Repository

1. Make changes to configuration files
2. Update version numbers in documentation
3. Test on staging server first
4. Commit and push changes
5. Deploy to production servers

### Automated Setup Script Updates

When updating `standard-server-setup.sh`:
1. Test on a template server
2. Verify all software versions
3. Update version numbers in README
4. Commit changes
5. Deploy gradually to production

## 🤝 Contributing

This repository is maintained for ClawdBotArmy infrastructure. For changes or suggestions, contact:

**Benjamin Tate**
Advanced Marketing Limited
Email: Ben@JustFeatured.com

## 📄 License

MIT License - See [LICENSE](LICENSE) for details

## 🔗 Related Projects

- **OpenClaw:** https://npm.im/openclaw
- **Claude Code:** https://claude.ai
- **code-server:** https://code-server.dev

---

**Last Updated:** 2026-02-22
**Maintained by:** Claude Code CLI & Benjamin Tate
**Repository:** https://github.com/bensblueprints/clawdbot-server-configs
