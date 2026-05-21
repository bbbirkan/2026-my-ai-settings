---
name: wshobson-agents
description: |
  wshobson'ın 184 ajan + 150 skill + 78 plugin + 16 orkestratör koleksiyonunu
  kullanma rehberi. Claude Code için doğru plugin'i seçmek, kurmak ve
  multi-agent workflow kurmak için kapsamlı katalog ve decision tree.

  TRIGGER bu skill'i şu durumlarda çağır:
  - "hangi agent'ı kullanayım", "plugin kur", "marketplace" sorulduğunda
  - Python, JS/TS, Kubernetes, güvenlik, ML gibi domain agent'ı istendiğinde
  - Multi-agent orchestration kurulumu istendiğinde
  - "/plugin install" veya Smithery marketplace bahsi geçtiğinde
---

# wshobson Agents — Claude Code Plugin Kataloğu

En kapsamlı Claude Code plugin koleksiyonu. 78 odaklanmış plugin, her biri
kendi domain'inde uzmanlaşmış agent'lar, skill'ler ve komutlar içerir.

**Kaynak:** https://github.com/wshobson/agents  
**Marketplace:** https://smithery.ai/skills?ns=wshobson  
**Yerel:** `/Users/birkan/Desktop/Work /00 Github PROJELERI/agents-wshobson/`

## Hızlı Kurulum

```bash
# Marketplace'i ekle (agent yüklemez, sadece katalog)
/plugin marketplace add wshobson/agents

# Mevcut plugin'leri listele
/plugin

# İstediğin plugin'i kur
/plugin install <plugin-adı>
```

## Plugin Kategorileri & Karar Rehberi

### 🐍 Geliştirme
| Ne İstiyorsun | Plugin |
|---------------|--------|
| Python kod yazma/refactor | `python-development` |
| JavaScript / TypeScript | `javascript-typescript` |
| Backend API geliştirme | `backend-development` |
| Frontend / React | `frontend-development` |
| Tam-yığın (full-stack) | `full-stack-orchestration` |

### ☁️ Altyapı & DevOps
| Ne İstiyorsun | Plugin |
|---------------|--------|
| Kubernetes yönetimi | `kubernetes-operations` |
| AWS / Azure / GCP | `cloud-infrastructure` |
| CI/CD pipeline | `devops-automation` |
| Docker / container | `container-management` |

### 🔒 Güvenlik & Kalite
| Ne İstiyorsun | Plugin |
|---------------|--------|
| Güvenlik açığı tarama | `security-scanning` |
| Kod review | `comprehensive-review` |
| Test yazma | `test-automation` |
| Performans analizi | `performance-optimization` |

### 🤖 AI / ML
| Ne İstiyorsun | Plugin |
|---------------|--------|
| ML pipeline | `ml-pipeline` |
| Veri analizi | `data-engineering` |
| LLM entegrasyonu | `ai-integration` |

### 📊 İş Operasyonları
| Ne İstiyorsun | Plugin |
|---------------|--------|
| SEO içerik | `seo-content` |
| Dökümantasyon | `documentation` |
| Proje yönetimi | `project-management` |

## 16 Multi-Agent Orkestratör

Karmaşık işlemler için tek agent yetmez — bunlar birden fazla agent'ı koordine eder:

| Orkestratör | Ne Yapar |
|-------------|----------|
| `full-stack-orchestration` | Frontend + Backend + DB + Test paralel |
| `security-hardening` | Audit + Fix + Verify döngüsü |
| `ml-pipeline-orchestration` | Data + Train + Eval + Deploy |
| `incident-response` | Detect + Diagnose + Fix + Post-mortem |
| `code-migration` | Analyze + Plan + Execute + Test |

## Model Stratejisi (Tier Sistemi)

wshobson 3 tier model stratejisi önerir:
- **Opus 4.7** — Karmaşık mimari kararlar, orchestration planlaması
- **Sonnet 4.6** — Standart geliştirme görevleri (varsayılan)
- **Haiku 4.5** — Hızlı, tekrarlayan işlemler (token tasarrufu)

## Progressive Disclosure Mimarisi

Her plugin minimal token kullanır:
```
python-development kurulumu:
  → 3 Python agent (~300 token)
  → 1 scaffolding tool (~100 token)  
  → 16 skill başlığı (~600 token)
  TOPLAM: ~1000 token (tüm 78 plugin değil!)
```

Skill içerikleri sadece ilgili olduğunda tam yüklenir.

## Önerilen Başlangıç Seti

```bash
# Temel geliştirme
/plugin install python-development
/plugin install javascript-typescript
/plugin install comprehensive-review

# Güvenlik
/plugin install security-scanning

# Dokümantasyon
/plugin install documentation
```
