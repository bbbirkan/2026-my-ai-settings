---
name: mcp-catalog
description: |
  Küratörlü MCP (Model Context Protocol) server listesi. appcypher ve punkpeye
  tarafından yönetilen awesome-mcp-servers listelerinden derlendi.
  Kategoriye göre doğru MCP server'ı seçme rehberi.

  TRIGGER bu skill'i şu durumlarda çağır:
  - "hangi MCP var", "MCP kataloğu", "MCP öner" istendiğinde
  - Belirli bir araç için MCP alternatifi arandığında
  - awesome-mcp-servers bahsi geçtiğinde
---

# MCP Catalog — Küratörlü Server Listesi

**Kaynaklar:**
- appcypher/awesome-mcp-servers → `/Users/birkan/Desktop/Work /00 Github PROJELERI/awesome-mcp-servers-appcypher/`
- punkpeye/awesome-mcp-servers → `/Users/birkan/Desktop/Work /00 Github PROJELERI/awesome-mcp-servers-punkpeye/`
- Resmi registry: https://registry.modelcontextprotocol.io/

## Kategoriye Göre Seçim

### 📁 Dosya & Sistem
| MCP | Yaptığı |
|-----|---------|
| `filesystem` | Yerel dosya okuma/yazma (resmi) |
| `git` | Git repo analizi (resmi) |
| `docker` | Docker container yönetimi |

### 🌐 Web & Tarayıcı
| MCP | Yaptığı |
|-----|---------|
| `fetch` | URL → metin dönüşümü (resmi) |
| `playwright` | Tarayıcı otomasyonu |
| `puppeteer` | Headless Chrome kontrolü |
| `firecrawl` | JS-render + crawl |

### 🗃️ Veritabanı
| MCP | Yaptığı |
|-----|---------|
| `sqlite` | SQLite sorgu ve yönetim |
| `postgresql` | PostgreSQL entegrasyonu |
| `redis` | Redis cache yönetimi |
| `supabase` | Supabase (Postgres + Auth + Storage) |

### 🤖 AI & LLM
| MCP | Yaptığı |
|-----|---------|
| `memory` | Knowledge graph hafıza (resmi) |
| `sequential-thinking` | Zincir düşünce (resmi) |
| `openai` | GPT modelleri |
| `perplexity` | Perplexity arama |

### 📊 Veri & Analiz
| MCP | Yaptığı |
|-----|---------|
| `google-sheets` | Sheets okuma/yazma |
| `airtable` | Airtable entegrasyonu |
| `notion` | Notion veritabanı |

### 🚀 DevOps & Cloud
| MCP | Yaptığı |
|-----|---------|
| `github` | GitHub API (PR, issue, repo) |
| `gitlab` | GitLab API |
| `vercel` | Vercel deployment |
| `aws` | AWS servis yönetimi |

### 📣 İletişim & Üretkenlik
| MCP | Yaptığı |
|-----|---------|
| `slack` | Slack mesaj gönderme |
| `google-calendar` | Takvim yönetimi |
| `gmail` | Email entegrasyonu |
| `linear` | Linear issue yönetimi |

### 🔍 Arama & SEO
| MCP | Yaptığı |
|-----|---------|
| `brave-search` | Brave arama API |
| `ahrefs` | SEO metrik verisi |
| `dataforseo` | SEO data sağlayıcı |

## Kurulum

```bash
# .mcp.json'a ekle (Claude Code proje konfigürasyonu)
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": { "GITHUB_TOKEN": "..." }
    }
  }
}
```
