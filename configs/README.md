# Server Configurations

This directory contains individual server configuration files.

## Files

- **bot-01-config.md** - Bot-01 server configuration (VMID 201)

## Configuration Template

Each server configuration should include:

1. **Server Details** - Hostname, VMID, IP addresses, OS
2. **SSH Access** - Connection details, ports, authentication
3. **Web Access** - code-server and other web interfaces
4. **System Resources** - RAM, CPU, storage specs
5. **Installed Software** - Complete software inventory with versions
6. **Network Configuration** - Internal/external IPs, port forwarding
7. **Quick Commands** - Common operations for this server
8. **Maintenance Log** - Creation date, updates, last verified

## Adding New Servers

When deploying a new server:

1. Copy `bot-01-config.md` as a template
2. Update all details for the new server
3. Add to `SERVER_INDEX.md` in the root directory
4. Commit and push to repository

## Naming Convention

- Bot servers: `bot-{vmid}-config.md` (e.g., `bot-300-config.md`)
- Infrastructure: `{service}-config.md` (e.g., `whmcs-config.md`)
