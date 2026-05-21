---
name: mcp-servers-guide
description: |
  Model Context Protocol (MCP) sunucuları rehberi. Resmi referans implementasyonlar,
  registry, kurulum adımları ve doğru server'ı seçme rehberi.
  Anthropic MCP steering group tarafından yönetilen kaynak.

  TRIGGER bu skill'i şu durumlarda çağır:
  - MCP server kurulumu veya yapılandırması istendiğinde
  - "hangi MCP kullanayım", "MCP ekle" sorulduğunda
  - Filesystem, Git, Memory, Fetch, Sequential Thinking MCP'leri sorulduğunda
  - MCP server yazma veya geliştirme istendiğinde
---

# MCP Servers Guide — Model Context Protocol

Anthropic MCP steering group'un resmi referans server koleksiyonu.
Bu sunucular production araçları değil, **eğitim amaçlı örnek implementasyonlardır.**

**Registry (gerçek sunucu listesi):** https://registry.modelcontextprotocol.io/  
**Kaynak repo:** https://github.com/modelcontextprotocol/servers  
**Yerel:** `/Users/birkan/Desktop/Work /00 Github PROJELERI/modelcontextprotocol-servers/`

## 7 Resmi Referans Server

| Server | Ne Yapar | Kullanım |
|--------|----------|----------|
| **Filesystem** | Güvenli dosya operasyonları | Yerel dosya okuma/yazma |
| **Git** | Git repo okuma ve arama | Commit geçmişi, diff analizi |
| **Memory** | Knowledge graph hafıza | Oturumlar arası kalıcı hafıza |
| **Fetch** | Web içerik çekme | URL → LLM-uyumlu metin |
| **Sequential Thinking** | Düşünce zincirleri | Adım adım problem çözme |
| **Time** | Zaman ve saat dilimi | Tarih/saat dönüşümleri |
| **Everything** | Test + referans | Tüm MCP özelliklerini test et |

## Dil SDK'ları

MCP server yazarken hangi SDK'yı kullanacağını seç:

```bash
# Python (en yaygın)
pip install mcp

# TypeScript
npm install @modelcontextprotocol/sdk

# Go, Rust, Java, Kotlin, C#, Ruby, Swift, PHP — hepsi mevcut
```

## Kurulum (Claude Code'a MCP Ekle)

```bash
# Registry'den server ekle
/mcp add <server-adı>

# Ya da manuel olarak .mcp.json'a ekle:
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/allowed/path"]
    },
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    }
  }
}
```

## Doğru Server'ı Seçme Rehberi

| İhtiyaç | Önerilen MCP |
|---------|-------------|
| Yerel dosyalara eriş | `filesystem` |
| Git geçmişine bak | `git` |
| Oturumlar arası hafıza | `memory` |
| Web sayfası çek | `fetch` |
| Karmaşık akıl yürütme | `sequential-thinking` |
| SEO verisi | Ahrefs / DataForSEO / SEMrush MCP |
| Tarayıcı kontrolü | Playwright / Puppeteer MCP |
| Veritabanı | SQLite / PostgreSQL MCP |

## Önemli Uyarı

```
⚠️  Bu repodaki serverlar ÜRETİM ORTAMINA HAZIR DEĞİLDİR.
    Kendi security gereksinimlerinizi değerlendirin.
    Gerçek production MCP serverleri için:
    https://registry.modelcontextprotocol.io/
```

## Kendi MCP Server'ını Yaz

```python
from mcp.server import Server
from mcp.server.models import InitializationOptions
import mcp.types as types

server = Server("my-server")

@server.list_tools()
async def handle_list_tools():
    return [types.Tool(name="my-tool", description="...")]

@server.call_tool()
async def handle_call_tool(name: str, arguments: dict):
    if name == "my-tool":
        return [types.TextContent(type="text", text="sonuç")]
```
