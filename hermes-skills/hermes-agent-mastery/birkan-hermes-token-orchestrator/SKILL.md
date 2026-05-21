---
name: birkan-hermes-token-orchestrator
description: "Birkan'ın Hermes Agent kullanımını token tasarruflu, model-orchestrated ve wiki-first hale getiren kalıcı çalışma protokolü. ÜST/ALT model seçimi, uzun kaynakların wiki'ye alınması, subagent bütçesi ve 2 aylık model güncelleme döngüsünü yönetir."
version: 1.0.0
created_by: agent
trigger:
  - "token tasarrufu"
  - "orkestra"
  - "orchestrator"
  - "Hermes'i verimli kullan"
  - "uzun yazı"
  - "kitap"
  - "wiki"
  - "model güncelle"
---

# Birkan Hermes Token Orchestrator

Bu skill, Hermes'i **az token + yüksek zekâ** prensibiyle kullanmak için kalıcı çalışma protokolüdür.

## Ana Felsefe

1. **ÜST model ana akıl / karar verici** olarak kalır.
2. **ALT modeller araştırma, özet, veri çıkarma, formatlama ve wiki hazırlama** işlerini yapar.
3. Uzun metinler, kitaplar, raporlar ve büyük web çıktıları sohbete basılmaz; **wiki / dosya / graphify** katmanına alınır.
4. Ana sohbete sadece **kısa sentez + karar gereken nokta** döner.
5. Multi-agent pahalıdır; sadece paralellik veya uzmanlık gerçek değer katıyorsa kullanılır.

---

## Model Havuzu — Mayıs 2026

### 3x3 Şirket Hiyerarşisi (9 Modelli Otonom Routing)

Sistem otonom olarak (görevin türüne göre) ameleden şefe, şeften patrona doğru otomatik paslaşma (routing) yapar.

**1. AŞAMA: MADENCİLER (Ameleler - Büyük Veri Okuma)**
- **Taşıyıcı Heighliner (DeepSeek-V4-Flash):** Uzmanlık -> Kod ve Repo İndeksleme
- **Gemini-3-Flash:** Uzmanlık -> İnternet Araması, Web Kazıma, Transkript
- **MiniMax-M2.5:** Uzmanlık -> Uzun Metin, PDF, Trello Notları, Kitap

**2. AŞAMA: ŞEFLER (İcra ve Karar)**
- **GLM-4.7:** Uzmanlık -> Rutin İşler, Standart Python Scriptleri
- **Grok-4.20:** Uzmanlık -> Güncel Veri, Twitter (X), Hızlı Analitik
- **DeepSeek-V4-Pro:** Uzmanlık -> Ağır Algoritma, Zorlu Kod, Senior Bug-Fix

**3. AŞAMA: PATRONLAR (Nihai Sentez ve Mimar)**
- **Claude-Opus-4.7:** Uzmanlık -> Sistem Mimarisi, Prompt Tasarımı, İskelet Kurulum
- **Claude-Opus-4.6:** Uzmanlık -> Kusursuz Akademik/Teknik Dil, Yaratıcı Kurgu, Vizyon
- **GPT-5.5:** Uzmanlık -> Baş Orkestratör (Genel Müdür), Nihai Mantıksal Karar

*(Sansürsüz ve serbest metin işleri için sistem otomatik olarak 'uncensored-model-router' skill'ine yönlendirir. Bu hiyerarşi tamamen teknik ve iş odaklıdır).*

Kullanım:
- Web araştırma, ham veri çıkarma, özet, sınıflandırma, tablo, JSON, uzun doküman bölme → ALT.
- ALT yetersiz kalırsa ÜST'e sadece sıkıştırılmış paket ver.

---

## Model Yeteneklerine Göre Routing

### Çok büyük dosya / mega-context
**Birinci tercih:** `deepseek/deepseek-v4-flash`

Neden:
- 1M context.
- Çok ucuz input/output.
- Ham metin tarama, indeksleme, bölümleme ve “needle finding” için iyi aday.

Kullanım:
- 100K+ token metin.
- Büyük PDF / kitap / log dump.
- Çok büyük JSON/CSV/HTML çıktı.
- Önce DeepSeek V4 Flash ile bölüm haritası çıkarılır.
- Sonra gerekirse GLM/Gemini ile bölüm özetleri alınır.
- Final sentez GPT-5.5 veya Claude Opus 4.6 ile yapılır.

### Genel işçi / dengeli akıl
**Birinci tercih:** `z-ai/glm-4.7`

Neden:
- İyi genel worker.
- Kod/prototip/özet/araştırma dengesi iyi.
- Delegation default modeli olarak kullanılır.
- Gerçek debug sonucu: GLM-4.7 bozuk değil; fazla reasoning token üretirse görünen content boş kalabilir.

Kullanım:
- Standart subagent işleri.
- 5-20 kaynak web araştırması.
- Kod dosyası inceleme.
- Wiki sayfası taslağı.

GLM çağırma notu:
- `reasoning: {effort: "low"}` kullan.
- `max_tokens` düşük verme; en az 1200 kullan.
- GLM-4.7 Flash ile karıştırma; Flash sürümünde content boş kalma riski daha yüksek.
- Tool-call testi başarılı: `report_status` fonksiyon çağrısını doğru yaptı.

### Hızlı ve ucuz özet / multimodal uyum
**Birinci tercih:** `google/gemini-3-flash-preview`

Kullanım:
- Hızlı ikinci özet.
- Uzun bölümden kısa bullet çıkarma.
- Tablo/JSON formatlama.
- Çok modlu içerik ihtimali varsa ön değerlendirme.

### En ucuz işçi / toplu sınıflandırma
**Birinci tercih:** `minimax/minimax-m2.5`

Kullanım:
- Çok sayıda küçük metin sınıflandırma.
- Basit extraction.
- “Bu metin hangi kategori?” tarzı işler.
- Maliyet kritik batch işlemleri.

### Zor kod / mimari / yüksek doğruluk
**ÜST tercih sırası:**
1. `openai/gpt-5.5`
2. `anthropic/claude-opus-4.6`
3. `deepseek/deepseek-v4-pro`
4. `anthropic/claude-opus-4.7`

Kullanım:
- Final karar.
- Mimari tasarım.
- Kritik kod değişikliği.
- Çelişkili kaynakları uzlaştırma.

### ÜST Danışma Konseyi — gerçekçi uygulama

Gerçek API testinde görüldü: Her model Hermes gibi güvenilir tool-call yapmıyor. Bu yüzden danışman modeller **tool-agent değil, text-only danışman panel** olarak kullanılır.

Ana prensip:
- Danışman modeller sadece kısa görüş verir.
- Tool çağırma / dosya okuma / terminal / web / patch işlemlerini Hermes ana executor yapar.
- Danışmanların çıktısı karar desteğidir; eylem yetkisi yoktur.

### Tetikleyici (Trigger) Mekanizması: İki Farklı Mod

Sistem kullanıcının mesajının başına koyduğu işarete göre iki farklı modda çalışır:

1. **`$` (Dolar) İşareti ile Başlayan Mesajlar (OpenRouter / API Modu):**
   - **Amaç:** Terminal kullanılmaz. Sadece OpenRouter API üzerinden modellerle (Şirket Hiyerarşisi) konuşulur.
   - **Nasıl Çalışır:** *Taşıyıcı Heighliner* (DeepSeek V4 Flash) isteği karşılar. Bütün büyük veriyi o okur, süzer ve hiyerarşideki Şeflere veya Patronlara (GPT-5.5 / Claude Opus) taşır. Tamamen API tokenları (OpenRouter) harcanarak çalışır. 

2. **İşaretsiz Mesajlar (Terminal / Abonelikli CLI Modu):**
   - **Amaç:** API maliyetini sıfırlayıp, aylık sınırsız abonelikleri (OpenCode Go, Claude Pro, Gemini Advanced) kullanmak.
   - **Nasıl Çalışır:** Bu modun hiyerarşisi (hangi terminal aracının, hangi göreve atanacağı) özel olarak ayarlanacaktır. Emir verildiğinde doğrudan terminaldeki abonelikli CLI'lar ateşlenir.

Danışma sırası:
1. Ana model: `openai/gpt-5.5`
2. Danışman 1: `anthropic/claude-opus-4.6`
3. Danışman 2: `deepseek/deepseek-v4-pro`
4. Acil / tie-breaker: `anthropic/claude-opus-4.7`

Nasıl yapılır:
- Danışman modellere tüm sohbet gönderilmez.
- Sadece sıkıştırılmış problem paketi verilir:
  - amaç
  - hata / seçenekler
  - ilgili kod/veri özeti
  - karar kriterleri
- Her danışmandan max 5 madde görüş alınır.
- Final kararı ana Hermes executor verir.
- Kullanıcıya “danışma sonucu” kısa özetlenir.

Çalışan script:
- `/root/.hermes/scripts/model_council.py`

Örnek:
```bash
python3 /root/.hermes/scripts/model_council.py --mode upper --question "Problem paketini buraya yaz"
```

Test sonucu:
- GPT-5.5, Claude Opus 4.6, DeepSeek V4 Pro, Claude Opus 4.7 text-only danışman olarak başarılı yanıt verdi.
- Tool-call bazı modellerde güvenilir değil; bu nedenle tool execution merkezi Hermes'te kalır.

### Routing pseudo-code

```text
if task == huge_file or tokens > 100k:
    worker = deepseek/deepseek-v4-flash
    action = map_sections + extract_key_claims + save_to_wiki
elif task == normal_research or standard_subagent:
    worker = z-ai/glm-4.7
elif task == fast_summary or table_json_format:
    worker = google/gemini-3-flash-preview
elif task == cheap_batch_classification:
    worker = minimax/minimax-m2.5
else:
    worker = z-ai/glm-4.7

final_synthesis = openai/gpt-5.5
if GPT-5.5 fails or too expensive:
    final_synthesis = anthropic/claude-opus-4.6
```

---

## Routing Kuralları

### Basit sohbet / kısa cevap
- Ana model yanıt verir.
- Araç kullanma gerekmiyorsa tool çağırma.
- Yanıt kısa tutulur.

### Araştırma / web / 5+ kaynak
- `delegate_task` kullan.
- Child agent toolsets sadece gerekli olanlarla sınırlandırılır: genelde `web`, `browser`, `file`.
- Child çıktısı max 20 madde / 1000 kelime olmalı.
- Ana ajan sadece synthesis yapar.

### Uzun yazı, kitap, PDF, büyük rapor
1. Ham içerik `~/wiki` veya proje wiki/vault içine alınır.
2. Kaynak raw olarak saklanır.
3. ALT model bölüm bölüm özetler.
4. Wiki sayfaları oluşturulur: entity/concept/comparison/query.
5. Ana sohbete sadece:
   - 5 madde özet
   - karar/aksiyon önerisi
   - oluşturulan dosya yolları

### Kod / repo işleri
- Önce graphify varsa `graphify-out/GRAPH_REPORT.md` okunur.
- Repo ilişkileri için grep yerine graphify/wiki tercih edilir.
- Geniş refactor'da görevler dosya sınırlarına göre ayrılır.
- Subagent çıktısı sadece diff özeti + risk + test komutu döndürür.

### Multi-agent / swarm
- Önce görev grafiği çıkar: bağımsız işler + bağımlılıklar.
- Ruflo/RecursiveMAS mantığı uygulanır: ajanlar arası uzun metin değil, kısa durum paketi.
- Her worker sadece kendi görevini ve gerekli dosyaları görür.
- Ana ajan final integrator olur.

---

## Token Hijyeni Kuralları

- Konu değişince `/reset` öner.
- Context %60 civarında ise `/compress` öner.
- 3-4 compact sonrası kalite düşerse yeni oturum + kısa özetle devam et.
- Tool çıktıları uzun olmasın; terminal komutlarında filtrele/özetle.
- Büyük dosyayı komple okuma; `read_file offset/limit`, `search_files`, graphify ve wiki kullan.
- Subagent pahalıdır: 1-2 basit iş için spawn etme; 3+ bağımsız parça varsa kullan.
- Skills gereksiz yüklenmez; sadece ilgili skill yüklenir.
- Memory kısa tutulur; prosedür skill'e, geçici ilerleme session/log'a yazılır.

---

## Kalıcı Sistem Döngüsü

### Günlük kullanım
- Ana sohbet: kısa karar + net aksiyon.
- Araştırma: ALT worker → özet → wiki.
- Kod: graphify map → küçük görevler → test.

### 2 aylık model güncelleme
`birkan-model-secim` skill'i çalıştırılır:
1. Benchmark siteleri taranır.
2. 15 ÜST + 20 ALT tablo güncellenir.
3. Kullanıcı seçim yapar.
4. Bu skill'teki model havuzu güncellenir.
5. Hermes config / delegation ayarları yumuşak geçişle güncellenir.

---

## Hermes Config Önerisi

- `model.default`: kaliteli ana model (`openai/gpt-5.5`)
- `model.max_tokens`: `8192` — KRİTİK. Bu **output cap** değeridir, context/input limiti değildir. Boş bırakılırsa bazı provider profilleri 64K/128K output cap ister; OpenRouter 402 / kredi yetersiz hatası verebilir.
- Büyük tek-parça çıktı gerekiyorsa işi durdurma: geçici olarak `model.max_tokens` yükselt, işi bitir, sonra `8192`'ye geri al.
- `delegation.model`: maliyet/işçi modeli (`z-ai/glm-4.7`)
- `delegation.provider`: `openrouter`
- `delegation.reasoning_effort`: `low` — GLM için önemli.
- `compression.enabled`: `true`
- `compression.threshold`: `0.35` veya `0.40`
- `compression.target_ratio`: `0.15` - `0.20`
- `compression.protect_last_n`: `10` - `14`
- `agent.reasoning_effort`: `medium`
- `agent.max_turns`: `45` - `60`
- `display.show_cost`: `true` mümkünse açılır.

See `references/openrouter-output-cap-and-glm.md` for the GLM/OpenRouter debugging notes.

---

## Kullanıcıya Davranış

Birkan gereksiz izin sorulmasını sevmez. Karar netse uygula. Ancak pahalı model değişimi, kalıcı config değişimi veya yıkıcı işlem varsa kısa bilgi ver, sonra uygula.

Workflow kuralı: Kullanıcı "yap" dedikten sonra "sen /reset yaz" gibi işi kullanıcıya geri atma. Hermes içinde mümkünse terminal/CLI ile kendin uygula, restart/status doğrula ve sonucu bildir. Kullanıcı özellikle sürtünmesiz otonom uygulama bekler.

Yanıtlar Türkçe, kısa ve net olmalı. Tablo gerekiyorsa Telegram uyumlu bullet kullan.

Biçim kuralı: Kullanıcı okunabilirliğe çok hassas. Sıkışık tek satırlı model listeleri (`ÜST1=...`) veya dar tablo görünümü kullanma. Temiz başlık + kısa bullet yap. PDF/rapor tasarlarken yazılar üst üste binmeyecek şekilde geniş kolon, küçük ama okunur font ve gerekirse firma kolonunu kaldırma tercih edilir.

---

🤖 *Bu skill Hermes Agent tarafından oluşturuldu*
