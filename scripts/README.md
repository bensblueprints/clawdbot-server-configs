# Setup and Utility Scripts

This directory contains automation scripts for server setup and maintenance.

## Available Scripts

### standard-server-setup.sh
**Purpose:** Automated installation of all required software on new bot servers

**What it installs:**
- Node.js 22.x (required for OpenClaw)
- Python 3 and pip
- Git
- OpenClaw CLI
- Claude Code CLI
- code-server

**Usage:**
```bash
# Copy to server
scp standard-server-setup.sh root@SERVER:/tmp/

# Run on server
ssh root@SERVER "bash /tmp/standard-server-setup.sh"
```

**Requirements:**
- Ubuntu 22.04 LTS
- Root access
- Internet connectivity

## Script Development Guidelines

When creating new scripts:

1. **Add a header comment** with purpose and usage
2. **Use `set -e`** to exit on errors
3. **Echo progress messages** for visibility
4. **Verify installations** before marking complete
5. **Make executable:** `chmod +x script-name.sh`
6. **Test on a template server first**

## Testing Scripts

Always test new scripts:

1. On a template server (VMID 101/102/103)
2. On Bot-01 as staging
3. On a new customer bot
4. Document any issues in INSTALLATION_LOG.md

## Contributing Scripts

When adding a new script:

1. Add the script to this directory
2. Update this README with script documentation
3. Add usage examples
4. Test thoroughly
5. Commit with clear description
