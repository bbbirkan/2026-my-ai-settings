---
name: data-product-designer
description: UX odaklı veri analitiği, ileri düzey gösterge paneli tasarımı, Edward Tufte veri-mürekkep optimizasyonu, Xenographics, L-sistemleri, tomografik katmanlama ve ödüllü görselleştirme metodolojileri.
tags: [data-analysis, ux-design, visualization, dashboard, performance, powerbi, streamlit, xenographics, l-systems, data-art, data-humanism]
---

# Data Product Designer (UX-Driven Data Architect)

Bu yetenek (skill), karmaşık veri kümelerini anlaşılır, ikna edici ve eyleme dönüştürülebilir "veri ürünlerine" (data products) ve gösterge panellerine dönüştürmek için kullanılır. Veri bilimi ile UX tasarımını (bilişsel yük optimizasyonu, renk semantiği, tipografi) ve performans mühendisliğini birleştirir.

## 🎯 Ne Zaman Kullanılmalı (Trigger)
- "Gösterge paneli (dashboard) tasarla", "veri görselleştir", "grafik türü öner" dendiğinde.
- Edward Tufte, Stephen Few, Data-Ink Ratio, Bullet Graph, Sparkline gibi görselleştirme teorileri sorulduğunda.
- Power BI, Tableau veya Streamlit panellerinde **performans optimizasyonu / hızlandırma** istendiğinde.
- Figma veri tasarımları, Monospace tipografi seçimi veya renk semantiği kuralları hakkında danışıldığında.
- PyGWalker, Data Formulator, D3.js, Datoviz gibi GitHub açık kaynak veri görselleştirme araçları talep edildiğinde.

## 🧠 Temel Felsefe: Tufte & Few Bilişsel Prensipleri
1. **Veri-Mürekkep Oranı (Data-Ink Ratio):** Ekrana çizilen her piksel veri taşımalıdır. 3D grafikler, ağır ızgara çizgileri, gölgeler (Chartjunk) KESİNLİKLE reddedilir.
2. **Kısa Süreli Bellek Optimizasyonu:** KPI'lar doğal F-Pattern okuma yönüyle sol üstte yer almalıdır.
3. **Grafik Seçimi:** 
   - Kadran (Gauge) yerine **Bullet Graph** (Gerçekleşen, Hedef, Performans Bantları).
   - Basit trendler için eksensiz **Sparkline**.
   - Kümülatif analiz için **Şelale Grafiği**.
   - Akış/Hacim darboğazları için **Sankey Diyagramı**.

## 🎨 UX, Renk Semantiği ve Tipografi
- **Renk Kullanımı:** Trafik ışığı (kırmızı-sarı-yeşil) renkleri renk körlüğüne (accessibility) karşı tek başına KULLANILAMAZ. Her zaman ikincil ikonlar (oklar, işaretler) eklenir. WCAG 2.1 AA (4.5:1 kontrast) zorunludur.
- **Tipografi:** Veri tablolarında dikey hizalama (scannability) için KESİNLİKLE **Monospace** fontlar (JetBrains Mono, Fira Code, Space Mono, Right Serif Mono) kullanılır.

## ⚡ Performans Optimizasyon Kuralları
Görselleştirme ne kadar iyi olursa olsun, gecikme (latency) ürünü öldürür.
- **Power BI:** Büyük fact tablolarında *DirectQuery*, küçük dimension tablolarında *Import Mode* birleştirilerek **Kompozit Mod** kullanılır. Snowflake yerine Star Schema tercih edilir.
- **Tableau:** Ağır Join'ler SQL katmanında (dbt) bitirilir, Tableau'ya temiz veri çekilir. Incremental Load (Artımlı Yükleme) zorunludur. Boolean/Integer hesaplamalar, String işlemlerine tercih edilir.
- **Streamlit:** CSV/JSON yerine ikili **Apache Parquet / Arrow** formatı kullanılır. `@st.cache_data` ile veritabanı sorguları RAM'de (memoization) önbelleklenir.

---

## 🤖 Data Product Designer Komutu (Prompt)
*(Bir UX Odaklı Veri Ajanı başlatmak veya kapsamlı dashboard tasarlatmak için aşağıdaki komutu kullanın)*

```text
SİSTEM ROLÜ
Sen elit bir 'Veri Ürün Tasarımcısı' (Data Product Designer) ve UX Odaklı Görselleştirme Mimarı'sın. Sadece veri analizi yapmaz, veriyi Edward Tufte'nin 'Veri-Mürekkep Oranı' (Data-Ink Ratio) felsefesine uygun, bilişsel yükü sıfırlanmış dashboard arayüzlerine dönüştürürsün. Geliştirdiğin her veri ürününde (Python, Power BI, Streamlit vb.) maksimum performansı ve WCAG 2.1 AA erişilebilirlik standartlarını sağlamakla yükümlüsün.

GÖREV ÇERÇEVESİ VE BEKLENTİLER
Aşağıdaki veri setini veya analiz senaryosunu incele: [VERİ/SENARYO GİRİNİZ].
Bana sadece istatistiksel bir özet değil, baştan uca bir 'Gösterge Paneli (Dashboard) Tasarım ve Optimizasyon Belgesi' hazırla.

TASARIM VE UX KISITLAMALARI
1. Grafik Seçimi: Hiçbir şartta 3D grafik veya geleneksel kadran (gauge) kullanma. Trendler için Sparkline, performans hedefleri için Bullet Graph, akışlar için Sankey önereceksin.
2. Renk ve İkonografi: Durum bildiren (kırmızı/yeşil) renklerde renk körlüğünü hesaba katarak her zaman ikincil semboller (ok ikonları vb.) ata.
3. Tipografi: Veri hizalaması gerektiren tüm bileşenlerde hangi Monospace fontu (ör. JetBrains Mono) neden seçtiğini açıkla.
4. Bilişsel Hiyerarşi: F-patern kuralına uygun olarak en önemli 3 KPI'ı en başa yerleştir.

TEKNİK PERFORMANS VE ARAÇ YÖNLENDİRMESİ
1. Kullanılacak platforma göre (Streamlit, Tableau, Power BI) veri formatı (örneğin CSV yerine Parquet) ve önbellekleme (caching) mekanizmalarını açıkça tanımla.
2. Analizi hızlandırmak için PyGWalker, Data Formulator, Datoviz veya n8n gibi açık kaynak AI/GitHub araçlarından hangisinin bu süreçte entegre edilebileceğini stratejik olarak ekle.
3. Raporun sonunda, bu analizin arka plandaki SQL veya Python veritabanı yükünü nasıl azaltacağıyla ilgili bir 'Yük Kaydırma' (Load Shifting) önerisi yap.
```

---

## 🛠 Açık Kaynak Araçlar ve Kodlama Kılavuzu

**1. PyGWalker (Kodsuz Pandas Arayüzü)**
Veri kümelerini kod yazmadan saniyeler içinde Tableau benzeri bir sürükle-bırak arayüzüne çevirir. Kodu yazarken veya önerirken aşağıdaki parametreleri KESİNLİKLE uygula:
- `spec`: Hazır grafik şablonlarını JSON veya URL olarak kaydetmek/çağırmak için.
- `use_preview=True`: Tarayıcının kilitlenmesini önlemek için devasa verilerde sadece önizleme modunu açar.
- `use_kernel_calc=True`: Ağır hesaplamaları (groupby vb.) JavaScript motoru yerine doğrudan Python çekirdeğine devrederek müthiş performans sağlar.
- `store_chart_data=True`: Tasarımları yerel diske otomatik kaydeder.
*Kullanım Örneği:* `pyg.walk(df, use_kernel_calc=True, use_preview=True, store_chart_data=True)`

**2. Microsoft Data Formulator**
LLM ve DuckDB entegrasyonlu yapay zeka grafik motorudur. Geleneksel formatlama yerine ajana/kullanıcıya şu özellikleri sunar: Ayrı tablolardaki verileri otomatik birleştirme (multi-table automatic joins), veriden içgörü çıkarma ve hedefe uygun görselleştirmeyi AI ile oluşturma. 

**3. Datoviz (GPU Tabanlı Render)**
Milyarlarca veri noktasını veya Lidar Point-Cloud yapılarını işlerken (Matplotlib'in yetersiz kaldığı anlarda) kullanılır. Tamamen C ve Vulkan tabanlı mimarisiyle veriyi CPU/tarayıcı yerine doğrudan GPU üzerinden render eder. Milyonlarca noktada bile 60 FPS kaydırma ve yakınlaştırma (pan/zoom) imkanı sağlar.

**4. D3.js ve Closeread (Quarto)**
Karar vericilere statik tablo değil, 'Veri Hikayesi' sunmak için "Scrollytelling" altyapıları. Okuyucu aşağı kaydırdıkça grafiklerin canlandığı etkileşimli sunumlar inşa eder.

---

## 🎨 Avangart Görselleştirme: Xenographics, L-Sistemleri ve Estetik Mükemmellik

Bu bölüm; ödül kazanan (Red Dot, Kantar Information is Beautiful, Webby) veri görselleştirmelerinin temel metodolojilerini kapsar. Standard grafiklerin yetersiz kaldığı durumlarda devreye girer.

### Ne Zaman Kullanılmalı
- "Ödül alan görselleştirme nasıl yapılır" / "bilgi tasarımı" / "infografik estetik" sorulduğunda.
- Botanik, bilimsel, doğa veya çok katmanlı veri setleri görselleştirilecekse.
- "Xenographics", "L-sistemi", "veri sanatı", "veri hümanizmi" kelimeleri geçtiğinde.
- Standart bar/pie/line grafiklerinin yetersiz kaldığı karmaşık ilişkisel verilerde.

---

### 🧠 Veri Hümanizmi (Giorgia Lupi)
Veriye salt teknik yaklaşımı reddeder. Temel ilkeler:
- Rakamların arkasındaki **nüans, belirsizlik ve insani bağlamı** görünür kıl.
- Teknolojiyi devreden çıkar, **kağıtta eskizle** — yazılım kısıtlamalarından özgürleş.
- Her görselleştirmeye **"Nasıl Okunur" (How to Read It)** rehberi ekle.
- Karmaşıklığı kaçınılması gereken bir şey olarak değil, **kucaklanması gereken bir zenginlik** olarak gör.
- Referans: *Dear Data* projesi (Lupi + Posavec) — elle çizilmiş haftalık veri kartpostalları.

---

### 📊 Xenographics — Alışılmadık Grafik Türleri
Maarten Lambrechts'in derlediği "xenographics" kütüphanesi, standart grafiklerin anlatamadığı veri yapıları için kullanılır:

**Zaman ve Döngü Grafikleri:**
- **Radyal Zaman Çizelgesi** — mevsimsel/döngüsel veriler için daire formunda çizgi grafik.
- **Heatmap Takvim** — 365 günlük yoğunluk verisi tek görselde.
- **Horizon Chart** — çakışan bantlarla yüksek yoğunluklu zaman serisi.
- **Stream Graph** — akış/hacim değişimi, kategoriler arası geçişler.

**Korelasyon ve Dağılım:**
- **Beeswarm Plot** — çakışmayan noktalarla bireysel veri dağılımı.
- **Ridgeline Chart** — kategoriler arası dağılım karşılaştırması.
- **Chord Diagram** — iki taraflı akış/ilişki (göç, ticaret, bağlantı).
- **Arc Diagram** — ağ bağlantılarını lineer düzlemde gösterir.

**Ağ ve Hiyerarşi:**
- **Sunburst** — iç içe hiyerarşiyi halka formunda gösterir.
- **Treemap + Voronoi** — alan oranı + organik sınır birleşimi.
- **Alluvial Diagram** — kategorilerin zaman içinde nasıl dönüştüğünü gösterir.

**Uygulama Kuralı:** Her xenographic türün yanına **"Nasıl Okunur"** kılavuzu ekle. İzleyiciyi öğrenme sürecine davet et, şaşırtma — aydınlat.

---

### 🌿 L-Sistemleri — Algoritmik Botanik Modelleme
Aristid Lindenmayer'ın (1968) geliştirdiği dize-yeniden yazma algoritması; bitki büyümesini matematiksel olarak modeller ve **veriyi organik form olarak görselleştirir**.

**Temel yapı:**
```
Aksiyom: F
Kurallar: F → F[+F]F[-F]F
Turtle komutları:
  F = ileri git + çizgi çiz (dal uzat)
  + = sola dön (θ açısı)
  - = sağa dön (θ açısı)
  [ = mevcut pozisyonu kaydet
  ] = kaydedilen pozisyona dön (dal bitir)
```

**Veri güdümlü L-sistemleri (Parametrik 0L):**
- Yağış miktarı → dal uzunluğu çarpanı
- Sıcaklık / güneş açısı → dallanma açısı (θ)
- Kimyasal konsantrasyon → yaprak boyutu / rengi
- Yıllık büyüme verisi → gövde kalınlığı

**Araçlar:** Python (`turtle`, `networkx`), Processing, p5.js, OpenSCAD, Blender Geometry Nodes.

**Sonuç:** Veri her parametreyi kontrol eder — ortaya çıkan form hem botanik olarak gerçekçi hem de istatistiksel olarak doğrudur.

---

### 🔬 Tomografik Katmanlama (Z-Ekseni Mimarisi)
Tıbbi CT taramalarından ilham alır: çok katmanlı veriyi **üst üste binen kesitler** olarak sunar.

**Temel ilke — Z-ekseni hiyerarşisi:**
1. En üst katman: **Açıklayıcı metinler, efsaneler, "nasıl okunur" rehberi**
2. Orta katman: **Veri işaretçileri** (xenographic elemanlar, L-sistemi görselleri)
3. Alt katman: **Arka plan, ızgara çizgileri, baz haritalar**

**Patlatılmış görünüm (Exploded View):**
- Odak noktasından sanal mercek hatları çıkar → sayfanın kenarına izometrik kesitler yerleştir.
- Her kesit farklı bir veri katmanını (anatomik, kimyasal, coğrafi) temsil eder.
- Katmanlar arasında görsel bağlantı (leader lines) kur.

**Yazılım iş akışı:**
1. **RAWGraphs** → ham verideki geometrik iskelet (vektörel çıktı)
2. **Adobe Illustrator** → katman mimarisi, renk, tipografi, organik düzenlemeler
3. **Datylon for Illustrator** → Google Sheets/CSV verisini doğrudan Illustrator'a bağla (dinamik güncelleme)

---

### 🏆 Ödüllü Stüdyolar ve Metodolojileri

| Tasarımcı / Stüdyo | Odak | Yaklaşım |
|---|---|---|
| **Giorgia Lupi** (Accurat) | Veri Hümanizmi | Elle eskizle başla, sonra dijitale taşı |
| **Nadieh Bremer** | Veri Sanatı (Data Art) | Algoritmik + estetik, varsayılanları tamamen reddet |
| **Federica Fragapane** | Organik görsel alfabeler | RAWGraphs → Illustrator, izleyiciyle empati |
| **Threestory Studio** | Bilgi tasarımı | Bağlam tartışması → napkin sketch → vektör |
| **5W Infographics** | Yüksek yoğunluklu haritalar | National Geographic tarzı "saatlerce bakılabilir" |
| **Pentagram** | Tipografik veri entegrasyonu | Marka kimliği + veri anlatısı birleşimi |

**Ödül platformları:** Kantar Information is Beautiful Awards, Red Dot Award, Webby Award, A'Design Award.

---

### 🎯 Estetik Mükemmellik İçin Kontrol Listesi
Bir görselleştirmenin ödül kalitesine ulaşması için:
- [ ] Her piksel veri taşıyor mu? (Tufte Data-Ink Ratio)
- [ ] "Nasıl Okunur" rehberi var mı?
- [ ] Renk körlüğü testi yapıldı mı? (WCAG 2.1 AA)
- [ ] Varsayılan grafik türü reddedildi, veri yapısına özel form seçildi mi?
- [ ] Z-ekseni hiyerarşisi (metin > veri > arka plan) uygulandı mı?
- [ ] İzleyici veriyle 10 dakikadan fazla vakit geçirebilir mi?
