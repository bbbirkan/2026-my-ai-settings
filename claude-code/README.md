# Claude Code Settings

Copy these to `~/.claude/` to apply settings.

## Files

| File | Purpose |
|------|---------|
| `settings.json` | Global: dark theme, `bypassPermissions` for server use |
| `settings.local.json` | Allowlist: git, pip, apt, docker, systemctl — no prompts |

## Skills (Built-in via Claude Code marketplace)

These skills are available after `claude plugins install` or auto-loaded from the official marketplace:

| Skill | Trigger | Purpose |
|-------|---------|---------|
| `init` | `/init` | Initialize CLAUDE.md for a codebase |
| `review` | `/review` | Pull request review |
| `security-review` | `/security-review` | Security audit of branch changes |
| `simplify` | `/simplify` | Refactor and simplify changed code |
| `update-config` | `/update-config` | Edit Claude Code settings.json / hooks |
| `keybindings-help` | `/keybindings-help` | Customize keyboard shortcuts |
| `fewer-permission-prompts` | `/fewer-permission-prompts` | Auto-allowlist common commands |
| `claude-api` | auto-trigger | Claude API / Anthropic SDK development |
| `loop` | `/loop` | Run a prompt on recurring interval |
| `schedule` | `/schedule` | Schedule remote agents via cron |

## Why `bypassPermissions`?

On a VDS running as root, Claude Code prompts for every `git`, `pip`, or `systemctl`.
`bypassPermissions: true` removes friction. You stay in control via SSH.
