# Server Index - All Configured Servers
**Last Updated:** 2026-02-22

## Quick Reference

| Server | SSH Alias | IP/Host | Port | Purpose |
|--------|-----------|---------|------|---------|
| **ClawdBotArmy Bot-01** | `bot-01` | 51.161.172.76 | 2201 | VPS hosting bot |
| **OVH Dedicated** | `ovh-dedicated` | 51.161.172.76 | 22 | Proxmox host server |
| **Synology NAS (Local)** | `nas-local` | 192.168.1.84 | 22 | Local network access |
| **Synology NAS (Tailscale)** | `nas-tailscale` | 100.122.165.61 | 22 | Remote access |
| **Hetzner Server 1** | `hetzner-1` | 89.167.50.94 | 22 | General purpose VPS |
| **Hetzner Server 2** | `hetzner-2` | 46.62.157.83 | 22 | General purpose VPS |
| **Hetzner Proxmox** | `hetzner-proxmox` | 178.156.242.63 | 22 | Proxmox cluster |

## Server Categories

### ClawdBotArmy Infrastructure
- **bot-01** - Active hosting bot (VMID 201)
- **ovh-dedicated** - Main Proxmox server

### NAS Storage
- **nas-local** / **nas-tailscale** - Synology NAS (user: root)
- **nas-ben-local** / **nas-ben-tailscale** - Synology NAS (user: Ben)
- **nas-clawdbot** / **nas-clawdbot-local** - NAS with clawdbot credentials

### Hetzner Infrastructure
- **hetzner-1** - VPS 1
- **hetzner-2** - VPS 2
- **hetzner-proxmox** - Proxmox virtualization server

## Connection Examples

```bash
# ClawdBotArmy Bot
ssh bot-01

# OVH Proxmox Server
ssh ovh-dedicated

# Synology NAS (local network)
ssh nas-local

# Hetzner servers
ssh hetzner-1
ssh hetzner-proxmox
```

## Configuration Files
- SSH Config: `~/.ssh/config`
- Server Details: `~/.claude/servers/[server-name]-config.md`

## Authentication Methods
- **SSH Keys:** Primary method for all servers
- **Passwords:** Available as fallback (see individual server configs)

## Web Interfaces

| Service | URL | Credentials |
|---------|-----|-------------|
| Bot-01 code-server | http://51.161.172.76:8081 | Password: ClawdBot2026! |
| OVH Proxmox | https://51.161.172.76:8006 | Password: ZfSofdW1vq1BtuHP |
| Proxmox Alt | https://admin.clawdbot.army:8006 | Same as above |
| Synology NAS | http://QuickConnect.to/advancedmarketing | User: Ben, Pass: SErver777$$! |
| Synology Local | http://192.168.1.84:5001 | Same as above |

---
**Maintained by:** Claude Code CLI
**Auto-generated:** This file is updated automatically when server configurations change
