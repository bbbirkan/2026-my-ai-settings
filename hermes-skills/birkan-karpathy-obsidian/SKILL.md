---
name: karpathy-obsidian
description: |
  Andrej Karpathy'nin Obsidian + Claude Code + Graphify iş akışını uygulayan skill.
  Ham notları, YouTube transkriptlerini ve araştırma materyallerini yapılandırılmış,
  aranabilir bir Obsidian knowledge base'e dönüştürür. LLM wiki deseniyle entegre çalışır.

  TRIGGER bu skill'i şu durumlarda çağır:
  - Obsidian vault kurulumu veya yönetimi istendiğinde
  - "Karpathy tarzı" not alma veya araştırma organizasyonu istendiğinde
  - YouTube video notlarını Obsidian'a aktarma istendiğinde
  - Knowledge graph + Obsidian entegrasyonu sorulduğunda
  - "second brain", "PKM", "personal knowledge management" konuşulduğunda
---

# Karpathy Obsidian Workflow — Claude Code Skill

Andrej Karpathy'nin geliştirdiği ve kamuoyuyla paylaştığı LLM destekli Obsidian
knowledge management iş akışı. Temel fikir: Claude Code + Obsidian + Graphify
üçlüsünü birlikte kullanarak kalıcı, büyüyen bir kişisel bilgi tabanı inşa etmek.

## Temel Araçlar

| Araç | Rol |
|------|-----|
| **Obsidian** | Markdown vault, graph view, wikilink navigasyonu |
| **Claude Code / Antigravity** | Ingest, query, lint, synthesis ajanı |
| **Graphify** | Knowledge graph extraction + Obsidian canvas export |
| **Whisper / yt-dlp** | YouTube → transkript → raw materyal |

## Vault Yapısı

```
vault/
├── CLAUDE.md           # Şema (anayasa) — ajan her oturumda okur
├── index.md            # İçerik kataloğu
├── log.md              # Append-only olay kaydı
├── raw/                # Ham materyaller (DOKUNULMAZ)
│   ├── articles/       # Web scrape, markdown makaleler
│   ├── papers/         # Akademik makaleler
│   ├── transcripts/    # YouTube / podcast transkriptleri
│   └── assets/         # Resimler, PDF'ler
├── sources/            # Her raw kaynak için özet sayfası
├── entities/           # Kişiler, modeller, organizasyonlar
├── concepts/           # Soyut kavramlar, algoritmalar
├── decisions/          # Kararlar ve gerekçeleri
└── syntheses/          # Çok-kaynaklı sentez sayfaları
```

## 3 Temel Operasyon

### INGEST — Yeni kaynak ekle
```
Yeni materyal geldi: raw/ altına koy → ajana "ingest et" de
Ajan: source sayfası yazar + entity/concept bağlantıları kurar + index.md günceller
```

### QUERY — Soru sor
```
Soruyu ajana sor → ajan önce index.md'yi okur → ilgili sayfalara iner
İyi cevapları "file-back" et → synthesis/ altında kalıcı sayfa olur
```

### LINT — Sağlık kontrolü
```
"vault'u lint et" → ajan: orphan sayfalar, çelişkiler, eksik bağlantıları raporlar
Periyodik (haftada 1): wiki'yi taze ve tutarlı tutar
```

## Graphify Entegrasyonu

```bash
# Vault'u graphify ile analiz et
/Users/birkan/.local/bin/graphify update /path/to/vault

# Obsidian'a export et (graph.canvas oluşturur)
/Users/birkan/.local/bin/graphify export obsidian \
  --graph /path/to/vault/graphify-out/graph.json \
  --dir /path/to/vault/graphify-export/
```

Graphify vault'daki wikilink'leri ve kavramsal bağlantıları analiz eder,
Obsidian canvas dosyası olarak görselleştirir.

## YouTube → Vault Pipeline

```bash
# 1. Video indir ve transkript çıkar
yt-dlp -x --audio-format mp3 "https://youtube.com/watch?v=..." -o "raw/transcripts/%(title)s.%(ext)s"
# veya: Obsidian Web Clipper ile YouTube sayfasını markdown'a çevir

# 2. Claude'a: "Bu transkripti vault'a ingest et"
# → Ajan source sayfası + concept bağlantıları + index güncellemesi yapar
```

## CLAUDE.md Şema Şablonu

```markdown
# [Vault Adı] — LLM Şema

## Amaç
Bu vault [ALAN]'daki kaynakları yönetir.

## Klasör Yapısı
[Tabloda klasörler ve içerikleri]

## Naming Convention
- Sayfa isimleri: kebab-case
- Entity isimleri: canonical (ilk geçen yazılış)

## Hard Rules
1. raw/ immutable — ajan asla yazmaz
2. Her iddia kaynaklı
3. Çelişki silinmez, işaretlenir
4. Sayfa silinmez, archive edilir
```

## Obsidian Eklentileri (Önerilen)

| Eklenti | Kullanım |
|---------|----------|
| **Dataview** | Frontmatter üzerinde sorgu |
| **Graph Analysis** | Hub ve orphan tespiti |
| **Templater** | Yeni sayfa şablonları |
| **Web Clipper** | Tarayıcıdan direkt import |

## Hard Rules

1. `raw/` immutable — ajan sadece okur
2. Her önemli iddia hangi kaynaktan geldiğini belirtir
3. Çelişkiler silinmez, `> [!WARNING] Çelişki:` ile işaretlenir
4. Sayfa silinmez → `archive/` altına taşınır
5. Her operasyon `log.md`'ye zaman damgalı eklenir

## Kaynak

- [Karpathy LLM Wiki video](https://www.youtube.com/watch?v=v5bu6hEYgSc)
- [Claude Code + Graphify = Local RAG](https://www.youtube.com/watch?v=WXcIArINefw)
- Yerel repo: `/Users/birkan/Desktop/Work /00 Github PROJELERI/karpathy/`
