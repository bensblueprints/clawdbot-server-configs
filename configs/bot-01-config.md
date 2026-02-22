# Bot-01 Server Configuration
**Last Updated:** 2026-02-22
**Status:** Active

## Server Details
- **Hostname:** bot-01
- **Server ID:** VMID 201 (Proxmox LXC Container)
- **Parent Server:** OVH Dedicated Server (51.161.172.76)
- **Internal IP:** 10.10.10.101
- **OS:** Ubuntu 22.04 LTS
- **Kernel:** Linux 6.8.12-18-pve

## SSH Access Configuration

### Quick Connect
```bash
ssh bot-01
```

### SSH Config Entry
Located in `~/.ssh/config`:
```
Host bot-01
    HostName 51.161.172.76
    Port 2201
    User root
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
    StrictHostKeyChecking accept-new
```

### Direct SSH Command
```bash
ssh -p 2201 root@51.161.172.76
```

### Authentication
- **Method:** SSH Key Authentication (id_ed25519)
- **Fallback Password:** ClawdBot2026! (if key fails)

## Web Access

### VS Code in Browser (code-server)
- **URL:** http://51.161.172.76:8081
- **Password:** ClawdBot2026!
- **Version:** 4.109.2

### VS Code / Cursor Remote SSH
- **Host:** 51.161.172.76
- **Port:** 2201
- **Username:** root
- **Auth:** SSH Key (~/.ssh/id_ed25519)

## System Resources
- **RAM:** 4 GB (3.7 GB available)
- **CPU Cores:** 2 Cores
- **Storage:** 20 GB SSD (17 GB available, 14% used)
- **Swap:** 1 GB

## Installed Software
- **Node.js:** v22.22.0 (upgraded from v20.20.0)
- **npm:** 10.9.4
- **Python:** 3.10.12
- **Git:** 2.34.1
- **OpenClaw CLI:** 2026.2.21-2 ✅ NEWLY INSTALLED
- **code-server:** 4.109.2
- **Claude Code:** CLI (installed)

## Network Configuration
- **Internal Network:** 10.10.10.0/24
- **Gateway:** Via Proxmox host
- **Public Access:** Port forwarding through 51.161.172.76
  - Port 2201 → SSH
  - Port 8081 → code-server

## Purpose
ClawdBotArmy hosting bot - part of the VPS hosting business running on OVH dedicated server infrastructure.

## Related Infrastructure
- **Main Proxmox Server:** ovh-dedicated (51.161.172.76)
- **Proxmox Web UI:** https://51.161.172.76:8006 or https://admin.clawdbot.army:8006
- **Template Source:** solo-bot-template (VMID 101)

## Quick Commands
```bash
# Connect to bot
ssh bot-01

# Check system status
ssh bot-01 "uptime && free -h && df -h /"

# View running processes
ssh bot-01 "ps aux | head -20"

# Check network connectivity
ssh bot-01 "ping -c 3 google.com"

# Start Claude Code
ssh bot-01 "claude"

# Access code-server
open http://51.161.172.76:8081
```

## Security Notes
- SSH key authentication is configured and working
- Password authentication is enabled as fallback
- Host key is verified and stored in ~/.ssh/known_hosts
- code-server is password-protected

## OpenClaw Usage
OpenClaw is a multi-channel AI gateway with extensible messaging integrations.

```bash
# Check version
ssh bot-01 "openclaw --version"

# Get help
ssh bot-01 "openclaw --help"

# Run OpenClaw
ssh bot-01 "openclaw"
```

## Maintenance
- **Created:** 2026-02-21
- **SSH Key Added:** 2026-02-22
- **Node.js Upgraded:** 2026-02-22 (v20.20.0 → v22.22.0)
- **OpenClaw Installed:** 2026-02-22 (v2026.2.21-2)
- **Last Verified:** 2026-02-22

---
**Owner:** Benjamin Tate — Advanced Marketing Limited
**Business:** ClawdBotArmy VPS Hosting
