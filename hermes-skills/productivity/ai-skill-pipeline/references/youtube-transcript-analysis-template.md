# YouTube Transcript → Profesyonel Analiz Şablonu
> ai-skill-pipeline'in bir parçası. Transcript gelince bu yapıyı takip et.

---

## 1. Transcript Hazırlığı
- Zaman damgalarını temizle (`1:12 ·`, `0:00 ·` gibi)
- Konuşmacı tanımlayıcılarını koru (isim lazımsa)
- Bölüm sonu işaretleyicilerini (`### Tier 1`, `---` vb.) ayıkla

## 2. Yapısal Analiz (Her video için)

### 2a Başlık Bloğu
```markdown
# [Video Başlığı]
> Kaynak: [Kanal] — [Video ID]  
> Kategori: `Code/alt-kategori` veya `Video/`  
> Tarih: YYYY-MM-DD
```

### 2b Özet (3-5 cümle)

### 2c Detaylı Bölümler
- Hiyerarşiyi koru (Tier 1/2/3, Level 1/2/3/4/5)
- Her bölüm için: ne anlatıldı, neden önemli
- Tablo ile sayısal verileri özetle

### 2d Reusable Çıkarımlar
- Prompt'lar, checklist'ler, snippet'ler

### 2e Sisteme Uygulanabilir Mapping (trade/otomasyon varsa)
| Kaynak Prensibi | Projeye Uygulama |

## 3. Skill Çıkarım Kararı
- **Bütünsel SKILL.md:** Sadece otonom workflow ise
- **Reusable not:** Tek seferlik taktik ise

## 4. Humanized Yanıt Formatı
> "Bilgileri kaptım, `{X}` klasörüne profesyonelce yerleştirdim. Skill de hazır, GitHub'a da attım. Başka neye bakalım?"
