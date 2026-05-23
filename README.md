# 2026-my-ai-settings

My personal AI development environment — Claude Code config, multi-agent orchestration, and server setup. Everything you need to replicate this stack on your own server.

**What's inside:**
- Claude Code settings with server-optimized permissions
- Orchester: zero-API-cost multi-agent routing (Claude + OpenCode + AGY)
- CLAUDE.md template: instant context onboarding for any AI assistant
- GitHub SSH setup guide for headless servers

---

## Quick Start

```bash
git clone https://github.com/bbbirkan/2026-my-ai-settings
cd 2026-my-ai-settings
bash bootstrap.sh
```

The script walks you through each component interactively.

---

## What's Included

### `claude-code/` — Claude Code Settings

| File | Purpose |
|------|---------|
| `settings.json` | Global settings: dark theme, bypass permissions for server use |
| `settings.local.json` | Allowlist: git, pip, apt, docker, systemctl, etc. — no prompts for common commands |

Copy to `~/.claude/` or let `bootstrap.sh` do it.

**Why `bypassPermissions`?**
On a VDS/VPS running as root, Claude Code prompts for every `git`, `pip`, or `systemctl` command. This becomes noise. `bypassPermissions` removes that friction while keeping you in control via SSH terminal access.

---

### `orchester/` — Zero-API-Key Multi-Agent Routing

Route questions to the right combination of AI CLI tools automatically. No API keys — uses your existing subscriptions.

```
Question → Claude classifies → simple/medium/hard
  simple  → Claude alone          (~10s)
  medium  → Claude + OpenCode     (~35s)
  hard    → 3-CLI council, 3 rounds (~60-90s)
```

**Requirements:**
- `claude` CLI — Anthropic Pro subscription
- `opencode` CLI — OpenCode subscription
- `agy` CLI — AGY (Antigravity) subscription

See [`orchester/README.md`](orchester/README.md) for full setup.

---

### `CLAUDE.md.template` — AI Context Onboarding

A structured file that gives any AI assistant (Claude Code, Hermes, OpenCode) instant context about your server, projects, and working rules.

**How to use:**
1. Copy to `/root/CLAUDE.md` (or `~/CLAUDE.md`)
2. Replace `YOUR_*` placeholders with your values
3. Every AI assistant connecting to your server reads it automatically

Key sections:
- Who you are and what you're building
- Installed systems and their status
- Active projects with port map
- Git/GitHub working rules
- Skill index — auto-loads relevant capabilities

---

### `docs/github-ssh-setup.md` — GitHub SSH on Headless Servers

HTTPS tokens fail silently on servers (expired PATs, scope issues). This guide shows the only reliable method: SSH keys + `GIT_SSH_COMMAND`.

---

## Adapt to Your Setup

This repo is one person's actual config — exported as a template. The patterns transfer; the specifics don't.

| Thing to change | Where |
|----------------|-------|
| Project list, port map | `CLAUDE.md.template` |
| Allowed commands | `claude-code/settings.local.json` |
| Orchester install path | `bootstrap.sh` or `orchester/orchester.service` |
| SSH key name | `docs/github-ssh-setup.md` |
| AI CLI tools | `orchester/terminal_orchester.py` |

---

## Stack

| Tool | Purpose |
|------|---------|
| Claude Code CLI | Headless coding agent — `claude -p` |
| OpenCode CLI | Secondary coding agent — DeepSeek |
| AGY CLI | Third perspective — Antigravity |
| FastAPI | Orchester API server |
| systemd | Process management |

---

## License

MIT — use freely, adapt to your needs.
