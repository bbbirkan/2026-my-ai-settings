---
name: autoresearch
description: |
  Andrej Karpathy'nin autoresearch projesi — otonom LLM araştırma ajanı.
  Bir AI ajanına küçük bir LLM eğitim ortamı verilir ve gece boyunca
  özerk deney yapar: kodu değiştirir, 5 dakika eğitir, sonuçları kontrol eder.
  GPU gerektiren araştırma otomasyonu.

  TRIGGER bu skill'i şu durumlarda çağır:
  - "autoresearch", "otonom araştırma ajanı" bahsi geçtiğinde
  - LLM eğitim deneyleri otomatize edilmek istendiğinde
  - "program.md", "train.py" dosyaları çalışıldığında
  - Karpathy autoresearch projesi sorulduğunda
---

# Autoresearch — Otonom LLM Araştırma Ajanı

Andrej Karpathy'nin Mart 2026'da yayınladığı proje. Bir AI ajanına
küçük bir GPT eğitim ortamı verilir ve insan müdahalesi olmadan
gece boyunca deney yapar.

**Kaynak:** https://github.com/karpathy/autoresearch  
**Yazar:** Andrej Karpathy  
**Yerel:** `/Users/birkan/Desktop/Work /00 Github PROJELERI/autoresearch/`

## Nasıl Çalışır

```
1. prepare.py   → Veri indir, BPE tokenizer eğit (bir kez, ~2 dk)
2. train.py     → GPT modeli + optimizer + eğitim döngüsü (AJAN DEĞİŞTİRİR)
3. program.md   → Ajana talimatlar (KULLANICI DEĞİŞTİRİR)

Döngü:
  Ajan train.py'yi değiştirir → 5 dk eğit → val_bpb ölçer → 
  iyileşti mi? → sakla / at → tekrar
```

**Metrik:** `val_bpb` (validation bits per byte) — düşük = daha iyi.  
**Zaman:** Sabit 5 dakika bütçe (donanımdan bağımsız adil karşılaştırma).

## Kurulum

```bash
# Gereksinim: NVIDIA GPU, Python 3.10+, uv

# 1. uv kur
curl -LsSf https://astral.sh/uv/install.sh | sh

# 2. Bağımlılıkları yükle
cd autoresearch && uv sync

# 3. Veri hazırlığı (bir kez, ~2 dk)
uv run prepare.py

# 4. Manuel test çalıştırma (~5 dk)
uv run train.py
```

## Ajanı Çalıştır

```bash
# Claude Code / Codex'i bu klasörde aç (tüm izinleri kapat)
# Sonra şunu söyle:
"program.md dosyasına bak ve yeni bir deney başlat."
```

`program.md` ajana ne deneyeceğini söyler. İstediğin kadar özelleştir.

## program.md Yazma Rehberi

```markdown
# Research Program

## Objective
val_bpb'yi minimize et, mevcut: [baseline değer]

## Constraints
- train.py dışındaki dosyalara dokunma
- Her deney tam 5 dakika çalışmalı

## Experiments to try
1. Learning rate schedule değiştir
2. Attention head sayısını artır
3. Optimizer: Muon yerine AdamW dene

## Log format
Sonuçları experiments.md'ye yaz: [deney] → [val_bpb] → [karar]
```

## 3 Temel Dosya

| Dosya | Kim Değiştirir | İçerik |
|-------|----------------|--------|
| `prepare.py` | **Kimse** | Sabit — veri + runtime utility |
| `train.py` | **Ajan** | GPT model, optimizer, eğitim döngüsü |
| `program.md` | **Kullanıcı** | Araştırma hedefleri ve kısıtlar |

## Gereksinimler

- NVIDIA GPU (H100 test edildi, farklı GPU da çalışır)
- Python 3.10+
- `uv` paket yöneticisi

> Mac'te GPU olmadan çalışmaz. Trade Bots veya başka bir sunucuda dene.
