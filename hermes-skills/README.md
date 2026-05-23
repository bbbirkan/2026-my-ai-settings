# Hermes Skills

[Hermes Agent](https://hermes-agent.dev) skill collection — copy to `~/.hermes/skills/` to enable.

Each skill is a directory with a `SKILL.md` file that defines triggers, behavior, and usage.

## Quick Install

```bash
cp -r hermes-skills/* ~/.hermes/skills/
```

## Skill Categories

### Custom Skills (`birkan-*`)
Personal workflow automation skills — adapt triggers and paths to your setup.

| Skill | Purpose |
|-------|---------|
| `birkan-video-pipeline` | YouTube / TikTok / MP4 → transcript → analysis (3-stage fallback) |
| `birkan-terminal-orchester` | Route to 3 AI CLIs (Claude + OpenCode + AGY) for debate/analysis |
| `birkan-deep-research` | Multi-source research with source ranking |
| `birkan-autoresearch` | Autonomous background research loop |
| `birkan-model-secim` | AI model selection guide (cost vs capability) |
| `birkan-desktop-packaging` | PyInstaller + Tauri 2.0 + Chrome Extension packaging |
| `birkan-mcp-servers-guide` | MCP server setup and catalog |
| `birkan-claude-parallel` | Claude Code headless / parallel usage patterns |
| `birkan-humanizer` | Rewrite AI text to sound human |
| `birkan-copywriting` | Copywriting frameworks and templates |
| `birkan-ai-seo` | AI-assisted SEO strategy |
| `birkan-backend-development__*` | API design + workflow orchestration |
| `birkan-agent-teams__*` | Multi-agent coordination strategies |
| `birkan-subagents-catalog` | Subagent delegation patterns |
| `birkan-graphify-skill` | Knowledge graph building with Graphify |
| `birkan-anthropic-skill-creator` | Create new Hermes skills automatically |

### Project Skills (`2026-*`)
Skills tied to specific projects — paths reference `/root/2026-*` directories.

| Skill | Purpose |
|-------|---------|
| `2026-channel-router` | YouTube channel routing (port 8000) |
| `2026-visionwatch` | YouTube video visual analysis (port 8001) |
| `2026-youtube-mini` | Lightweight YouTube metadata (port 8002) |
| `2026-yt-harvester` | Transcript engine with 4-stage fallback (port 8003) |
| `2026-medium-reader` | Medium article extractor with cookie auth (port 8004) |
| `2026-hermes-trello-agent` | Trello weekly task agent (port 8005) |

### Generic Skills (Category Folders)
Reference/library skills — `creative/`, `data-science/`, `mlops/`, `devops/`, etc.

## Adapt to Your Setup

Skills reference paths like `/root/2026-orchester/` — update these for your environment.

`birkan-system-context` is intentionally excluded (contains personal server config — use `CLAUDE.md.template` instead).
