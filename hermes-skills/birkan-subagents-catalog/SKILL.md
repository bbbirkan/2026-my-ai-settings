---
name: subagents-catalog
description: |
  VoltAgent'ın yönettiği 131+ Claude Code subagent koleksiyonu kataloğu.
  Her subagent belirli bir görev için uzmanlaşmıştır. Doğru subagent'ı
  seçme ve kullanma rehberi.

  TRIGGER bu skill'i şu durumlarda çağır:
  - "subagent", "alt ajan" bahsi geçtiğinde
  - Belirli bir görev için özel ajan arandığında
  - VoltAgent, awesome-claude-code-subagents sorulduğunda
---

# Subagents Catalog — 131+ Özel Ajan

VoltAgent'ın küratörlüğünü yaptığı Claude Code subagent koleksiyonu.

**Kaynak:** https://github.com/VoltAgent/awesome-claude-code-subagents  
**Yerel:** `/Users/birkan/Desktop/Work /00 Github PROJELERI/awesome-claude-code-subagents/`

## Kurulum

```bash
# Plugin sistemi ile
/plugin marketplace add voltagent/subagents
/plugin install <subagent-adı>

# Manuel
/agent add /path/to/subagent/
```

## Kategori Haritası

### 🧑‍💻 Geliştirme
- `code-reviewer` — PR review uzmanı
- `refactor-expert` — Kod yeniden yapılandırma
- `test-writer` — Test üretimi
- `debugger` — Hata ayıklama uzmanı
- `performance-optimizer` — Performans analizi

### 🏗️ Mimari
- `system-designer` — Sistem mimarisi tasarımı
- `api-designer` — API tasarım rehberi
- `database-architect` — Veritabanı şema tasarımı

### 📝 Dokümantasyon
- `doc-writer` — Teknik dokümantasyon
- `readme-generator` — README üretimi
- `changelog-writer` — Değişiklik günlüğü

### 🔒 Güvenlik
- `security-auditor` — Güvenlik denetimi
- `threat-modeler` — Tehdit modelleme

### 🚀 DevOps
- `ci-cd-expert` — Pipeline tasarımı
- `infrastructure-coder` — IaC (Terraform, etc.)
- `deployment-specialist` — Deploy stratejisi

### 🤖 AI/ML
- `prompt-engineer` — Prompt optimizasyonu
- `ml-pipeline-builder` — ML pipeline kurulumu
- `rag-architect` — RAG sistem tasarımı

## Kullanım Örneği

```bash
# Belirli bir subagent'ı çağır
/agent code-reviewer "bu PR'ı incele"
/agent test-writer "bu modül için test yaz"
/agent security-auditor "bu API'yi denetle"
```
