# Server Installation Log
**Maintained by:** Claude Code CLI
**Auto-updated:** This file tracks all software installations across servers

## Installation History

### Bot-01 (VMID 201) - 2026-02-22

#### Initial State
- **Node.js:** v20.20.0
- **npm:** 10.8.2
- **Python:** 3.10.12
- **Git:** 2.34.1
- **code-server:** 4.109.2
- **Claude Code:** 2.1.50

#### Upgrades Performed

**1. Node.js Upgrade (v20.20.0 → v22.22.0)**
- **Reason:** OpenClaw requires Node.js ≥ 22.12.0
- **Method:** NodeSource APT repository
- **Commands:**
  ```bash
  curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
  apt install -y nodejs
  ```
- **Result:** ✅ Success
- **New Version:** v22.22.0
- **npm Version:** 10.9.4 (also upgraded)

**2. OpenClaw CLI Installation**
- **Package:** openclaw@2026.2.21-2
- **Method:** npm global install
- **Commands:**
  ```bash
  npm uninstall -g openclaw  # Removed placeholder v0.0.1
  npm install -g openclaw@latest
  ```
- **Dependencies:** 700 packages installed
- **Result:** ✅ Success
- **Verification:** `openclaw --version` returns `2026.2.21-2`

#### Final Software Inventory
```
Node.js:      v22.22.0     ✅ UPGRADED
npm:          10.9.4       ✅ UPGRADED
Python:       3.10.12      ✅ STABLE
Git:          2.34.1       ✅ STABLE
OpenClaw:     2026.2.21-2  ✅ NEW
Claude Code:  2.1.50       ✅ STABLE
code-server:  4.109.2      ✅ STABLE
```

#### Warnings Encountered
- **EBADENGINE warnings:** Acknowledged but non-blocking
- **Deprecated package warnings:** Noted but didn't affect functionality
- npm deprecated packages: inflight, node-domexception, gauge, npmlog, tar, glob, rimraf

#### Post-Installation Verification
```bash
✅ openclaw --version        # Works
✅ node --version           # v22.22.0
✅ npm --version            # 10.9.4
✅ SSH access               # Functional with keys
✅ code-server              # Running on port 8081
✅ System resources         # 3.7GB RAM available, 17GB disk
```

---

## Standard Installation Template

### For New Bot Servers
Use the automated setup script:
```bash
# From Mac
scp ~/.claude/servers/standard-server-setup.sh root@NEW_SERVER:/tmp/
ssh root@NEW_SERVER "bash /tmp/standard-server-setup.sh"
```

### For Existing Servers (OpenClaw Only)
```bash
# Upgrade Node.js first
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt install -y nodejs

# Install OpenClaw
npm install -g openclaw@latest

# Verify
openclaw --version
```

---

## Configuration Files Updated
- `/Users/blackhat01/.ssh/config` - Added bot-01 SSH config
- `/Users/blackhat01/.claude/servers/bot-01-config.md` - Updated with new software
- `/Users/blackhat01/.claude/servers/SERVER_INDEX.md` - Server inventory
- `/Users/blackhat01/.claude/servers/SERVER_STANDARD.md` - Installation standards
- `/Users/blackhat01/.claude/servers/standard-server-setup.sh` - Automated setup script

---

## Next Steps

### For Future Bot Deployments
1. Clone template (VMID 101, 102, or 103)
2. Run standard setup script
3. Verify all software installed
4. Configure SSH key authentication
5. Update SERVER_INDEX.md with new server
6. Create individual config file

### For Existing Infrastructure Servers
- Consider upgrading Node.js on all servers to v22.x
- Install OpenClaw on servers that need AI gateway functionality
- Test automated setup script on a staging server first

---
**Last Updated:** 2026-02-22 07:13 UTC
**Updated By:** Claude Code CLI
