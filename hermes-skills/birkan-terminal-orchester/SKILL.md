---
name: birkan-terminal-orchester
description: |
  Telegram/Discord mesajlarını 3 CLI terminaline (Claude + Gemini + OpenCode) yönlendiren köprü.
  API key kullanmaz — sadece subscription. Kullanıcı "/debate", "/orchester" veya
  "3 terminal", "3 ajan", "analiz et" diyince tetiklenir.

  TRIGGER bu skill'i şu durumlarda çağır:
  - "/debate", "/orchester", "/3cli" komutu geldiğinde
  - "3 terminal ile analiz et", "3 ajan", "çoklu bakış açısı" istendiğinde
  - Karmaşık bir konuda farklı perspektifler istendiğinde
---

# Terminal Orchester Skill

Kullanıcıdan gelen mesajı 3 farklı AI CLI'a gönder ve sentezlenmiş yanıtı döndür.

## Nasıl Çalışır

```
Telegram mesajı → Hermes → Bu skill → terminal_orchester.py → Claude + Gemini + OpenCode → Hermes → Telegram
```

## Kullanım

Kullanıcı şunlardan birini yazınca bu skill devreye girer:
- `/debate <soru>` 
- `/orchester <soru>`
- `/3cli <soru>`
- "3 terminal ile analiz et: <soru>"

## Uygulanacak Adımlar

Aşağıdaki Bash komutunu çalıştır ve çıktıyı kullanıcıya ilet:

```bash
export CLAUDE_CODE_BUBBLEWRAP=1
python3 /root/2026-orchester/terminal_orchester.py --mode parallel "KULLANICI_MESAJI"
```

`--mode` seçenekleri:
- `parallel` — Claude + OpenCode aynı anda, Gemini sentezler (varsayılan, en hızlı)
- `chain` — Claude → OpenCode → Gemini sıralı
- `sequential` — Gemini taslak → eleştiri → revizyon

## Yanıt Formatı

Kullanıcıya şu şekilde sun:

```
🤖 **3 CLI Analizi** (Claude + OpenCode + Gemini)

**Soru:** [kullanıcının sorusu]

**Final Sentez:**
[gemini_out içeriği]

---
*Detaylı tartışma: `/root/2026-orchester/debates/` dizininde*
```

## Önemli Notlar

- Ortalama süre: 45-90 saniye (3 CLI paralel çalışıyor)
- API maliyeti: **0** — subscription kullanılıyor
- Çıktı `/root/2026-orchester/debates/` dizininde kayıtlı kalır
- Hermes config'indeki model (OpenRouter) bu skill aktifken KULLANILMAZ
