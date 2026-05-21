---
name: birkan-deep-research
description: |
  2025-2026 state-of-the-art derin araştırma sistemi. Anthropic çok-ajanlı mimarisi,
  OpenAI Deep Research döngüsü, STORM perspektif sistemi, CoVe anti-halüsinasyon,
  GAP_LEDGER bilgi-boşluğu takibi ve 4-katmanlı iddia sınıflandırması (FACT/REPORTED/
  PROJECTION/INFERENCE) içerir. Derinlik seviyesi: quick | standard | deep | exhaustive.

  TETIKLEYICILER — bu skill şu durumlarda devreye girer:
  - "derin araştır", "deep research", "araştır bunu", "incele bunu"
  - "detaylı araştırma yap", "kapsamlı analiz", "tam analiz"
  - /research veya /dr komutu
  - "bunu araştır + konu", "hakkında rapor", "rapor hazırla"
  - Karmaşık çok-boyutlu sorular (piyasa analizi, teknik karşılaştırma, akademik özet)
  - Herhangi bir "şunu araştır" tipi talep

  KAYNAK: 2025-2026 Deep Research Framework (Anthropic +90.2%, STORM, CoVe, ParallelSearch)
  Son güncelleme: 2026-05-17
---

# Birkan Deep Research Skill

Anthropic, OpenAI, Google Gemini ve Perplexity'nin flagship deep research sistemlerini
birleştiren üretim kalitesinde araştırma motoru.

---

## HIZLI REFERANS

| Komut | Derinlik | Süre | Maliyet |
|-------|----------|------|---------|
| `quick:` öneki | 1 geçiş, boşluk yok | ~1 dk | minimal |
| `standard:` öneki | 1 geçiş + 1 boşluk turu | ~3 dk | orta |
| `deep:` öneki | Orkestratör + 3-8 paralel sub-ajan | ~8 dk | yüksek |
| `exhaustive:` öneki | Tam pipeline + CoVe + RCI | ~15 dk | maksimum |

Önek yoksa → **standard** varsayılan.

---

## PHASE 1 — KAPSAM VE HİPOTEZ

Her araştırmanın başında mutlaka:

```
ARAŞTIRMA ÖZETI:
Soru: [kullanıcının sorusu, kesin formda]
Çalışma hipotezi: [tek cümle — neyin doğru olduğu tahmini]
Falsifikasyon koşulu: [bu hipotezi çürütecek kanıt nedir?]
Araştırma tipi: factual | comparative | causal | predictive | exploratory
Kapsam: [dahil / hariç]
Güncellik penceresi: [konu başına — piyasa verisi: 3 ay, hukuk: 1 ay, temel kavram: sınırsız]
Derinlik: quick | standard | deep | exhaustive
Araç bütçesi: [quick:5 | standard:15 | deep:40 | exhaustive:100]
```

Eğer soru, cevabı önemli ölçüde etkileyen bir belirsizlik içeriyorsa:
→ TEK bir netleştirici soru sor ve dur. Birden fazla soru sorma.

---

## PHASE 2 — SORGU AYRIŞIMI (RESEARCH_BRIEF)

### Ayrışım Şeması

```json
{
  "research_brief": {
    "main_query": "...",
    "sub_queries": [
      {
        "id": "q1",
        "question": "<tek oturumda cevaplanabilir, atomik soru>",
        "type": "factual | comparative | temporal | causal | quantitative | definitional",
        "depends_on": ["none"] ,
        "parallelizable": true,
        "expected_source_types": ["primary | secondary | dataset | paper | news | filing"],
        "recency_required": "<3 ay | 12 ay | tarihsel | sınırsız>",
        "success_criteria": "<tam cevap nasıl görünür>",
        "adversarial": false
      }
    ]
  }
}
```

### Ayrışım Kuralları

1. **5-8 alt sorgu** üret — ne az ne çok
2. `depends_on: ["none"]` olan sorguları **maksimize et** → paralel çalışır
3. En az **1 adversarial sorgu** ekle ("X'in başarısızlıkları", "X'e karşı kanıtlar", "X'in eleştirileri")
4. Her sorgu kendi başına cevaplanabilir olmalı — iç içe araştırma gerektirmemeli
5. **Kapsam genişliği** (breadth) + **yanlışlama alanı** (falsification space) birlikte kapat

### ParallelSearch Prensibi (arXiv:2508.09303)
Bağımsız sorgular eş zamanlı çalıştığında:
- +12.7% doğruluk
- ~%30 daha az model çağrısı
Bağımlı sorgular → sonuç alındıktan sonra sıraya al.

---

## PHASE 3 — ARAŞTIRMA DÖNGÜSÜ

### Quick / Standard Modu — Tek Ajan ReAct Döngüsü

Her araç çağrısı için:

```
Thought: [Şu an ne biliyorum | Nereye bakıyorum | Neden bu kaynak]
Action: [araç çağrısı]
Observation: [ne öğrendim | marjinal yeni bilgi %kaçı]
```

Duruş kriteri: marjinal yeni bilgi < %10 VEYA araç bütçesi tükendi.

### Deep / Exhaustive Modu — Orkestratör + Sub-Ajan

**LEAD ARAŞTIRMACI** (bu Hermes/Claude):
- RESEARCH_BRIEF üretir
- Sub-ajanlara görev dağıtır
- GAP_LEDGER tutar
- Sentez yapar
- CoVe ve RCI uygular

**SUB-AJAN ŞEMATİK** (delegasyon simülasyonu):

```
Sen bir ARAŞTIRMA SUB-AJANISSIN.
Tek bir alt sorguyu cevaplayıp sıkıştırılmış FINDINGS_ARTIFACT döndür.

SUB-SORGU: {sub_query}
BEKLENEN KAYNAK TİPLERİ: {types}
GÜNCELLIK GEREKSİNİMİ: {window}
MAX ARAÇ ÇAĞRISI: {n}

SÜREÇ (ReAct):
- İlk çağrıdan önce 2-4 spesifik arama dizesi planla
- Çeşitlendir — aynı kaynakta kalma
- Durdur: ≥2 bağımsız kaynak VEYA kamuya açık kaynak yok kanıtı VEYA bütçe doldu

DÖNDÜR: FINDINGS_ARTIFACT (aşağıda)
Parametrik bilgi kullanma. Bu oturumda kaynak bulamazsan dahil etme.
```

**FINDINGS_ARTIFACT Şeması:**

```json
{
  "sub_query_id": "q1",
  "answer": "<1-3 cümle veya 'KURULAMADI'>",
  "key_facts": [
    {
      "fact": "...",
      "source_id": "S1",
      "quote": "<doğrudan alıntı>",
      "date": "YYYY-MM-DD",
      "claim_type": "FACT | REPORTED | PROJECTION | INFERENCE"
    }
  ],
  "sources": [
    {
      "id": "S1",
      "title": "...",
      "url": "...",
      "author": "...",
      "pub_date": "YYYY-MM-DD",
      "accessed_date": "YYYY-MM-DD",
      "tier": 1,
      "credibility_notes": "..."
    }
  ],
  "evidence_confidence": "H | M | L | S",
  "contradictions_found": [],
  "follow_ups_recommended": [],
  "what_i_could_not_find": "..."
}
```

---

## PHASE 4 — GAP_LEDGER DÖNGÜSÜ

Her araştırma turunda bir GAP_LEDGER üret:

```json
{
  "gap_ledger": {
    "answered": [
      {
        "sub_query_id": "q1",
        "confidence": 0.85,
        "key_sources": ["S1", "S2"]
      }
    ],
    "partially_answered": [
      {
        "sub_query_id": "q3",
        "missing": "<hâlâ bilinmeyen>",
        "next_action": "<spesifik araç çağrısı>"
      }
    ],
    "unanswered": [
      {
        "sub_query_id": "q5",
        "blocker": "<neden kaynak bulunamadı>",
        "next_query": "<tam arama dizesi>"
      }
    ],
    "new_questions_uncovered": [
      {
        "question": "...",
        "priority": "high | medium | low"
      }
    ],
    "contradictions_to_resolve": [
      {
        "claim_a": "...",
        "claim_b": "...",
        "sources": ["S1", "S3"],
        "resolution_plan": "..."
      }
    ]
  }
}
```

**DÖNGÜ DURDURUCU:**
Devam et → `unanswered = []` VE `partially_answered = []` VE `contradictions_to_resolve = []`
VEYA marjinal yeni bilgi < %10
VEYA araç bütçesi doldu (kalan boşlukları raporda belirt)

---

## PHASE 5 — İDDİA SINIFLANDIRMASI (ZORUNLU)

Her taslaktaki her cümle için:

```
FACT:        Geçmiş/şimdiki zaman, ≥1 güvenilir kaynakta doğrudan belirtilmiş → [Sid] ekle
REPORTED:    Bir varlık öne sürmüş → "X'e göre, ..." veya "X iddiasına göre, ..."
PROJECTION:  İleriye dönük, modellenmiş, koşullu → "Öngörülen:" + kaynak + yöntem
INFERENCE:   Kaynaklardan sentezimiş → "Çıkarım:" + temel gerçekleri göster
```

Bu dört sınıf, araştırmadaki "halüsinasyonların" çoğunu önler — bunların büyük kısmı
kategori hatasıdır: projeksiyon gerçek, çıkarım rapor edilmiş gibi yazılmış.

---

## PHASE 6 — DOĞRULAMA (Chain-of-Verification, Faktörleştirilmiş)

Raporun taslağını bitirdikten SONRA:

```
1. Taslagtaki en kritik 10 olgusal iddiayı listele.
2. Her biri için bir DOĞRULAMA SORUSU üret.
3. Her doğrulama sorusunu BAĞIMSIZ olarak yanıtla
   (taslağa bakmadan — aynı halüsinasyonu kopyalamamak için).
4. Doğrulama cevabı taslakla çelişiyorsa → taslağı düzelt.
5. ATIF DENETİMİ: her olgusal cümle [Sid] ile bitmeli.
   Desteksiz cümle → AÇIK_SORULAR'a taşı veya sil.
```

CoVe (Dhuliawala et al., ACL 2024) kapalı kitap çoklu QA'da F1'i ~%23 artırıyor.
Faktörleştirilmiş varyant kritik — model taslağı görerek doğrularsa aynı hatayı kopyalar.

---

## PHASE 7 — ELEŞTİREL İNCELEME (RCI — Recursive Critique & Improve)

Şüpheci bir alan uzmanı personası al:

```
ELEŞTİRİ:
- Bu rapordaki en zayıf 5 iddia:
  1. [iddia] → [neden zayıf] → [nasıl düzeltilmeli]
  ...

- En olası 3 kör nokta:
  1. Aramadığımız ama önemli olabilecek alanlar...

- Kaynak monokulture riski:
  [Aynı kaynaktan mı çok fazla referans aldık?]

- Aşırı güven kontrolü:
  [Kanıt tabanından daha güçlü iddia eden yerler?]
```

Bu bulgular → "Kurulamadıklarımız" ve "Bilinmeyen Bilinmeyenler" bölümlerine ekle.

---

## KAYNAK KALİTE TİERLEMESİ

| Tier | Örnekler | Varsayılan ağırlık |
|------|----------|-------------------|
| 1 — Birincil/Yetkili | Resmi dosyalar, hakemli makaleler, mahkeme kararları, düzenleyici basın bültenleri, orijinal veri setleri | 1.0 |
| 2 — Yüksek kaliteli ikincil | FT, WSJ, Reuters, Nature News (adlandırılmış yazarlar + birincil kaynak bağlantıları ile) | 0.7 |
| 3 — Gri literatür | Ön baskılar, çalışma kağıtları, NGO raporları, standart taslakları | 0.5 |
| 4 — Toplayıcılar | Wikipedia, haber toplayıcılar, özet bloglar | 0.3 (harita olarak kullan, alıntılama) |
| 5 — Görüş/Pazarlama | Vendor blogları, veri içermeyen görüş yazıları | 0.1 (kaçın) |

**ARAMA STRATEJİSİ (sırayla):**
1. Akademik: Google Scholar, Semantic Scholar, arXiv, PubMed, SSRN
2. Resmi birincil: Hükümet sicilleri, SEC EDGAR, mahkeme kayıtları
3. Kaliteli basın: Yazar adı + birincil kaynak bağlantısı filtreleriyle
4. Gri literatür: Kurumsal repolar, konferans bildirileri, NBER/IMF/BIS
5. Atıf zincirleri: Anahtar makaleyi bul → referanslarını + atıflarını takip et
6. Adversarial: "X'in başarısızlıkları", "X'in eleştirileri", "X geri çekildi" ile ara

---

## GROUNDING POLİTİKASI (Katı)

```
GROUNDING POLİTİKASI:
- Her olgusal iddia [Sid] ile bitmeli (kaynak id'si).
- Destekleyici kaynak yoksa → (a) iddiayı düşür VEYA (b) "DOĞRULANMAMIŞ: <iddia>"
  olarak yaz ve AÇIK_SORULAR'a ekle.
- Şunlar için parametrik (eğitim verisi) bilgisi KULLANMA:
  tarihler, sayılar, kişi adları, adlandırılmış varlıklar, fiyatlar, istatistikler,
  çalışma sonuçları, hukuki/tıbbi/finansal ayrıntılar.
  Bunlar MUTLAKA kaynaklı olmalı.
- "Mevcut kaynaklar X'i kanıtlamamaktadır" demek, X'i öne sürmekten İYİDİR.
- Güven etiketleri:
  "doğrulandı [S1][S2]" vs. "S1 tarafından iddia edildi ancak teyit edilmedi"
  vs. "spekülasyon/tahmin (gelecek zaman, nitelikli dil)"
```

---

## GÜVENİLİRLİK ŞEMASI

Her son rapor iddiası şunu taşır:

```
[S1; S2 | güv=Y | güncellik=2025-09]

güv =
  Y (Yüksek): ≥2 bağımsız yüksek kaliteli birincil kaynak hemfikir; güvenilir çelişki yok
  O (Orta):   1 yüksek kaliteli kaynak VEYA ≥2 ikincil kaynak hemfikir; küçük çelişkiler çözülebilir
  D (Düşük):  Tek zayıf kaynak, anekdotal, veya önemli çözümsüz çelişki
  S (Spekülatif): İleriye dönük, modellenmiş, veya görüş temelli

güncellik = destekleyici en son kaynağın ISO tarihi
```

**Önemli:** LLM'lerin kendi kendine bildirdiği güven puanları kötü kalibre edilmiş (ECE 0.108-0.427).
GPT-4 yanıtların %87'sinde maksimum güven bildirdi — yanlışlar dahil.
Kanıt tabanlı güven kullan, model öz-raporlama değil.

---

## ÇELİŞEN KAYNAKLAR — Deterministik Prosedür

```
İki+ kaynak bir iddia üzerinde çeliştiğinde:
1. Uyuşmazlığı sınıflandır:
   a. Olgusal hata — kanıtla göster (düzeltme, birincil kayıt)
   b. Zamansal — her ikisi de farklı zamanlarda doğru; zaman çizelgesi yap
   c. Tanımsal — farklı tanımlar; her ikisini de göster
   d. Metodolojik — farklı yöntemler farklı sonuç; aralık + yöntem belirt
   e. Gerçek açık soru — her iki tarafı atıfla göster; ORTALAMA ALMA

2. Tercih: birincil > ikincil > üçüncül; hızlı değişen konular için güncel > eski

3. Güvenilirlik karşılaştırılabilir ve uyuşmazlık gerçekse →
   UYUŞMAZLIĞI AÇIKça RAPORLA, ortalama alma

4. ÇÖZÜLEN_ÇELIŞKILER veya AÇIK_SORULAR bölümüne ekle
```

---

## ZAMANSAL POLİTİKA

```
- Bugünün tarihi sistem promptuna HER ZAMAN ekle
- Her kaynağı EVIDENCE bloğunda tarihle birlikte etiketle
- Zaman hassasiyeti olan her iddia için o tarihi atıfta belirt
- Konu başına güncellik penceresi tanımla:
    Piyasa verisi: 3 ay → eski işaretle
    Düzenleyici durum: 1 ay → eski işaretle
    Teknoloji durumu: 6 ay → eski işaretle
    Temel kavramlar: sınırsız
- "X doğrudur" yerine "S'ye göre <tarih> itibarıyla, X doğruydu" tercih et
- Olay zamanı, kaynak zamanı ve erişim zamanını ayırt et
```

---

## NEGATIF KAPASİTE — Bilinmeyenleri Kabul Etme

Araştırma baskı altında model "her zaman bir cevap üretir" — bu en tehlikeli başarısızlık modudur.

```
## Kurulamadıklarımız
- Soru: <alt sorgu>
  belirsizlik-türü: [girdi-belirsizliği | bilgi-boşluğu | alandaki-açık-soru | çelişen-kanıt]
  çözecek-şey: <bunu kapatacak spesifik kaynak, veri seti, uzman veya deney>
  mevcut-en-iyi-tahmin: <varsa, S (spekülatif) güven ile>

## Bilinen Bilinmeyenler (alan da bilmiyor)
- ...

## Bilinmeyen Bilinmeyenler (şüpheli kör noktalar)
- Bu soruya bitişik ama aramadığımız, önemli olabilecek konular: ...
```

Son madde en kritik — iyi atıflı ama yapısal olarak eksik rapor en tehlikeli başarısızlık modudur.

---

## ÇIKTI ŞABLONU

```markdown
# [Başlık]
**Tarih:** YYYY-MM-DD
**Araştırma derinliği:** quick | standard | deep | exhaustive
**İncelenen kaynaklar:** N (Tier 1: a, Tier 2: b, Tier 3: c, Tier 4: d)
**Genel güven:** Y/O/D + tek cümle gerekçe

## Özet (≤150 kelime)
Kullanıcının sorusuna doğrudan cevap, en kritik 3 destekleyici gerçek ve 1 ana uyarı.

## Temel Bulgular (4-7 madde)
- <bulgu> [Sid | güv | güncellik]

## Arka Plan / Çerçeveleme
Sorunun gerçekte ne anlama geldiği; tanımlanan anahtar terimler; kapsam.

## Detaylı Analiz
Alt sorguya göre düzenlenmiş. Her bölüm:
- Doğrudan cevap
- Kanıt (atıflı alıntılar/parafrası)
- Güven ve nedeni
- Tespit edilen çelişkiler, çözümle

## Konsensüs Alanları
Birden fazla bağımsız kaynağın hemfikir olduğu yerler.

## Uyuşmazlık Alanları / Açık Tartışma
Kaynakların çeliştiği yerler; atıfla sunulmuş, ortalama alınmamış.

## Sayısal Özet (tablo)
| Metrik | Değer | Kaynak | Tarih | Güven |

## Zaman Çizelgesi (zaman hassas konular için)
Atıflı kronolojik tablo.

## Kurulamadıklarımız
(Yukarıdaki Negatif Kapasite bölümünden)

## Öneriler / Karar Etkileri
Güvene koşullu; spekülatif olduğu yerlerde işaretlenmiş.

## Metodoloji Eki
- Kullanılan araştırma özeti (alt sorgular)
- Arama stratejisi
- Hariç tutulan kaynaklar ve nedeni
- Araç çağrısı özeti

## Kaynak Listesi
Numaralı, şu bilgilerle: başlık, yazar/yayıncı, tarih, URL, tier, erişim tarihi.
```

---

## ÇIKTI KALİTE GEÇİTLERİ

Raporu teslim etmeden önce kontrol et:

- [ ] Her olgusal cümle [Sid] içeriyor
- [ ] Her iddia FACT/REPORTED/PROJECTION/INFERENCE olarak sınıflandırılmış
- [ ] Güven puanları kanıt tabanlı (model öz-raporu değil)
- [ ] Çelişen kaynaklar tespit edilip çözüme kavuşturulmuş
- [ ] Tarihler mutlak formatta (göreceli değil)
- [ ] "Kurulamadıklarımız" bölümü dolu
- [ ] "Bilinmeyen Bilinmeyenler" bölümü en az 2 madde içeriyor
- [ ] CoVe tamamlandı (en kritik 10 iddia doğrulandı)
- [ ] RCI tamamlandı (şüpheci uzman gözüyle 5 zayıf nokta tespit edildi)

---

## BAŞARISIZLIK MODELLERİ (Bunlara Karşı Tasarım Yapıldı)

| Başarısızlık | Önlem |
|-------------|-------|
| Kaynak monokulture | Sub-ajan promptlarında kaynak tipi çeşitlendirmesini zorla |
| Atıf tiyatrosu | CoVe faktörleştirilmiş geçişi + citation verifier |
| Aşırı güven | Kanıt tabanlı güven şeması, model öz-raporu değil |
| Zamansal bayatlık | Güncel tarih geç, kaynakları tarihle etiketle, güncellik pencereleri tanımla |
| Phantom kaynakta döngü | Sub-ajan başına araç çağrısı sınırla, "bulamayanları" raporla |
| Aşırı ayrışma | Max 8 alt sorgu, derinliğe göre paralel ajan sınırı |
| Paralel darboğaz | Bağımsız sorgular gerçekten paralel çalışmalı |
| Kategori hatası | Zorunlu FACT/REPORTED/PROJECTION/INFERENCE sınıflandırması |

---

## TEKNİK REFERANSLAR (Bu Skillin Dayandığı Kaynaklar)

- **Anthropic Research Multi-Agent (Jun 2025)** — +90.2% single-agent üzerinde; artifact pattern
- **ParallelSearch (arXiv:2508.09303, Aug 2025)** — +12.7% doğruluk, ~%30 daha az çağrı
- **STORM / Co-STORM (Stanford OVAL)** — perspektif keşfi, outline-driven RAG
- **CoVe (Dhuliawala et al., ACL 2024, arXiv:2309.11495)** — ~%23 F1 artışı
- **Deep Researcher Reflect Evolve (arXiv:2601.20843)** — 46.21 Deep-Research Bench SOTA
- **MEGA-RAG (Frontiers, 2025)** — DPAG + SEAE + DISC
- **LUMINA (arXiv:2509.21875)** — bağlam-vs-bilgi sinyal tabanlı halüsinasyon tespiti
- **CONFACT (arXiv:2505.17762, 2025)** — kaynak güvenilirlik metadata entegrasyonu
- **HopRAG (Liu et al., 2025)** — çok adımlı retrieval için geçiş grafiği
- **Stanford 2025 Legal RAG Study** — üretim RAG sistemlerinde %17-33 halüsinasyon oranı
