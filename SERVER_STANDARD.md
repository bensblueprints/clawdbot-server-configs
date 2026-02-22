# Server Standard Configuration
**Last Updated:** 2026-02-22
**Applies To:** All ClawdBotArmy bot servers and infrastructure

## Standard Software Stack

### Core Requirements
All bot servers MUST have the following installed:

| Software | Version | Purpose |
|----------|---------|---------|
| **Node.js** | ≥ 22.12.0 | JavaScript runtime (required for OpenClaw) |
| **npm** | Latest | Package manager |
| **Python** | 3.10+ | Scripting and automation |
| **Git** | Latest | Version control |
| **OpenClaw CLI** | Latest | Multi-channel AI gateway |
| **Claude Code CLI** | Latest | AI-powered development assistant |
| **code-server** | Latest | VS Code in browser |

### Current Versions (as of 2026-02-22)
- Node.js: v22.22.0
- npm: v10.9.4
- Python: 3.10.12
- Git: 2.34.1
- OpenClaw: 2026.2.21-2
- code-server: 4.109.2

## Installation Process

### Automated Setup
Use the standard setup script:
```bash
# Copy script to server
scp ~/.claude/servers/standard-server-setup.sh root@SERVER:/tmp/

# Run on server
ssh root@SERVER "bash /tmp/standard-server-setup.sh"
```

### Manual Installation Commands
If automated script fails, install manually:

```bash
# Update system
apt update && apt upgrade -y

# Install Node.js 22.x
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt install -y nodejs

# Install Python
apt install -y python3 python3-pip

# Install Git
apt install -y git

# Install OpenClaw CLI
npm install -g openclaw@latest

# Install code-server
curl -fsSL https://code-server.dev/install.sh | sh

# Install Claude Code CLI
curl -fsSL https://claude.ai/install.sh | bash
```

## Server Configuration Standards

### Port Allocation
| Service | Port Range | Notes |
|---------|-----------|-------|
| SSH | 2200-2299 | Bot-01: 2201, Bot-02: 2202, etc. |
| code-server | 8080-8099 | Bot-01: 8081, Bot-02: 8082, etc. |
| Custom apps | 3000-3999 | Application-specific ports |
| Admin tools | 9000-9099 | Monitoring, management |

### Hostname Convention
- Template servers: `{type}-bot-template` (e.g., `solo-bot-template`)
- Customer bots: `bot-{vmid}` (e.g., `bot-300`, `bot-301`)
- Infrastructure: `{service}-{purpose}` (e.g., `nginx-proxy`, `whmcs`)

### Default Passwords
**IMPORTANT:** All servers use `ClawdBot2026!` as the initial root password.
Customers MUST change this on first login.

### SSH Access
- All servers MUST accept SSH key authentication
- Password authentication is enabled as fallback
- Public keys are stored in `~/.ssh/authorized_keys`
- Default SSH port for main server: 22
- Bot containers use custom ports (2201+)

## Network Configuration

### Internal Network
- Subnet: `10.10.10.0/24`
- Gateway: Proxmox host
- DNS: Proxmox host provides DNS

### External Access
All external access is port-forwarded through the main OVH server (51.161.172.76):
- Bot-01 SSH: 51.161.172.76:2201 → 10.10.10.101:22
- Bot-01 code-server: 51.161.172.76:8081 → 10.10.10.101:8080

## Resource Allocations

### Bot Templates
| Template | RAM | CPU | Disk | VMID |
|----------|-----|-----|------|------|
| Solo Bot | 2GB | 2 | 40GB | 101 |
| Team Bot | 4GB | 4 | 80GB | 102 |
| Army Bot | 8GB | 8 | 160GB | 103 |

### Infrastructure Containers
| Container | RAM | CPU | Disk | VMID |
|-----------|-----|-----|------|------|
| WHMCS | 4GB | 2 | 40GB | 200 |
| Nginx Proxy | 2GB | 2 | 20GB | 201 |
| Landing Page | 2GB | 1 | 20GB | 400 |

## Security Standards

### Required Security Measures
1. **Firewall:** UFW or iptables configured
2. **SSH Keys:** All admins have key-based access
3. **Fail2ban:** Installed and configured for SSH protection
4. **Updates:** Automatic security updates enabled
5. **Passwords:** Strong passwords (12+ chars, mixed case, numbers, symbols)

### Monitoring
- System logs: `/var/log/`
- Service monitoring: systemd status
- Resource monitoring: htop, iotop
- Network monitoring: netstat, ss

## Backup Strategy
- **Configuration:** Daily backups of `/etc/`
- **Data:** Weekly full backups
- **Database:** Daily SQL dumps (if applicable)
- **Retention:** 30 days for daily, 90 days for weekly

## Verification Checklist

After setup, verify all components:
```bash
# System info
hostnamectl
uname -a

# Installed software
node --version
npm --version
python3 --version
git --version
openclaw --version
claude --version
code-server --version

# Network
ip addr show
ping -c 3 google.com

# Disk space
df -h

# Memory
free -h

# Services
systemctl status ssh
systemctl status code-server (if configured as service)
```

## Troubleshooting

### OpenClaw requires Node >=22.12.0
```bash
# Upgrade Node.js
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt install -y nodejs
```

### code-server not accessible
```bash
# Check if running
systemctl status code-server

# Check port
netstat -tuln | grep 8080

# Verify firewall
ufw status
```

### SSH connection refused
```bash
# Verify SSH service
systemctl status ssh

# Check port forwarding (from Proxmox host)
iptables -t nat -L -n | grep 2201
```

## Update Procedure

When updating the standard:
1. Test changes on a template server first
2. Update this document with new versions
3. Update the setup script
4. Deploy to Bot-01 as staging test
5. Roll out to customer bots gradually

---
**Maintained by:** Claude Code CLI & Benjamin Tate
**Contact:** Ben@JustFeatured.com
**Repository:** ~/.claude/servers/
