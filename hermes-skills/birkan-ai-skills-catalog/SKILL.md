---
name: ai-skills-catalog
description: |
  Tüm Claude skill ekosisteminin küratörlü haritası. Resmi Anthropic skill'leri,
  partner skill'leri, topluluk katkıları, kurulum yöntemleri ve güvenlik uyarıları.
  "Hangi skill'i kullanayım?" sorusunun merkezi cevabı.

  TRIGGER bu skill'i şu durumlarda çağır:
  - "hangi skill var", "skill ekosistemi", "skill kataloğu" sorulduğunda
  - Yeni skill aramak veya karşılaştırmak istendiğinde
  - Skill kurulumu hakkında genel rehberlik istendiğinde
  - awesome-claude-skills bahsi geçtiğinde
---

# Claude Skills Kataloğu

travisvn'ın yönettiği `awesome-claude-skills` reposundan derlenen kapsamlı
Claude skill ekosistemi haritası.

**Kaynak:** https://github.com/travisvn/awesome-claude-skills  
**Yerel:** `/Users/birkan/Desktop/Work /00 Github PROJELERI/awesome-claude-skills/`

## Skill Nasıl Çalışır (Mimari)

```
1. Metadata (~100 token)  → Claude mevcut skill'leri tarar
2. Tam talimatlar (<5K)   → İlgili skill tam yüklenir
3. Bundled kaynaklar      → Sadece gerektiğinde yüklenir
```

Progressive disclosure: Birden fazla skill bağlamı doldurmadan aktif kalabilir.

## Kurulum Yöntemleri

### Claude.ai Web
```
Settings → Capabilities → Skills toggle → Aç
Team/Enterprise: Admin önce kurumsal aktifleştirmeli
```

### Claude Code CLI
```bash
# Marketplace'den kur
/plugin marketplace add anthropics/skills

# Yerel klasörden kur
/plugin add /path/to/skill-directory
```

### Claude API
```python
# /v1/skills endpoint'i — bkz: platform.claude.com/docs/en/api/beta/skills
import anthropic
client = anthropic.Client(api_key="...")
```

## Resmi Anthropic Skill'leri

| Skill | Ne Yapar |
|-------|----------|
| `mcp-builder` | MCP server tasarımı ve geliştirme |
| `skill-creator` | Yeni skill oluşturma rehberi |
| `claude-api` | Anthropic API entegrasyon yardımı |
| `frontend-design` | UI/UX tasarım desteği |
| `doc-coauthoring` | Döküman birlikte yazımı |
| `webapp-testing` | Web uygulama test otomasyonu |
| `web-artifacts-builder` | Web artifact üretimi |
| `docx` / `pdf` / `pptx` / `xlsx` | Office belge işleme |

**Yerel:** `/Users/birkan/Desktop/Work /00 Github PROJELERI/anthropics-skills/skills/`

## Yüksek Değerli Topluluk Skill'leri

| Kaynak | Skill Sayısı | Odak |
|--------|-------------|------|
| wshobson/agents | 150+ | Yazılım geliştirme, DevOps, AI/ML |
| marketingskills | 41 | Pazarlama, SEO, CRO |
| seo plugin | 5 | İçerik SEO pipeline |
| gstack | 23 rol | Şirket hiyerarşisi |
| superpowers | 1 | Plan-first geliştirme |
| humanizer | 1 | AI metin insanlaştırma |
| video-production-kit | 5 agent | Video düzenleme pipeline |
| knowledge-pipeline | 1 | Wiki/PKM sistemi |

## Birkan'ın Skill Klasörü

```
/Users/birkan/Documents/HariciAraclar/SkillSeekers/output/
```

Kurulu skill'ler bu klasördedir. Her skill bir `SKILL.md` içerir.

## Güvenlik Uyarıları

- Skill'ler kod çalıştırabilir — güvenilir kaynaklardan kur
- Bilinmeyen skill SKILL.md'lerini kurmadan önce içeriği oku
- Marketplace dışı skill'lerde dikkatli ol
