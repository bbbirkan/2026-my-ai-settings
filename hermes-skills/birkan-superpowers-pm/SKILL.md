---
name: superpowers-pm
description: |
  Claude Code'u doğrudan koda atlamak yerine önce plan yapan, test yazan
  ve ürettiği işi inceleyen "Proje Müdürü" moduna geçiren skill.
  136K GitHub yıldızına sahip en popüler Claude Code plugin'i.

  TRIGGER bu skill'i şu durumlarda çağır:
  - "önce plan yap", "adım adım düşün", "acele etme" istendiğinde
  - Karmaşık özellik geliştirme başlamadan önce
  - "TDD", "test-driven", "önce test yaz" istendiğinde
  - Claude'un çok hızlı koda daldığını fark ettiğinde
  - superpowers, proje müdürü modu bahsi geçtiğinde
---

# Superpowers — Proje Müdürü Modu

Claude Code'u sabırsızlıktan kurtaran, disiplinli çalışmasını sağlayan
136K ⭐ plugin. Temel fikir: **planla → test yaz → implement et → incele**.

**Kaynak:** https://github.com/elie222/superpowers  
**Yerel:** `/Users/birkan/Desktop/Work /00 Github PROJELERI/superpowers/`

## Temel Davranış Değişikliği

### Superpowers OLMADAN (varsayılan Claude)
```
İstek → Hemen kod yaz → Belki test ekle → Belki review et
```

### Superpowers İLE
```
İstek → Planı açıkla → Onayla → Test yaz → İmplementasyon → Self-review
```

## Kurulum

```bash
/plugin marketplace add elie222/superpowers
/plugin install superpowers
```

## Etkinleşen Davranışlar

### 1. Önce Plan
Claude, koda başlamadan önce ne yapacağını açıklar:
- Hangi dosyaları değiştireceği
- Hangi yaklaşımı seçtiği ve neden
- Alternatif yaklaşımlar ve neden seçmediği

### 2. Test-First
Uygulama yazmadan önce test yazar:
```python
# Claude önce bunu yazar:
def test_should_calculate_total_with_discount():
    ...

# Sonra bunu:
def calculate_total(items, discount):
    ...
```

### 3. Self-Review
Kod yazdıktan sonra kendi kodunu inceler:
- Edge case'leri kontrol eder
- Güvenlik açıklarını arar
- Performans sorunlarını işaretler

### 4. Yavaş Değişiklik
Birden fazla dosyayı tek seferde değiştirmek yerine
değişiklikleri parçalara böler ve onay ister.

## Felsefe (Superpowers Manifestosu'ndan)

> "Ajan olmak, hızlı olmak demek değildir. Doğru olmak demektir."

Plugin'in %94 PR rejection rate'i olan bir repo olduğunu hatırla —
maintainer'lar kalitesiz kodu anında kapatıyor. Superpowers tam olarak
bunu önlemek için var: kaliteli, düşünülmüş, test edilmiş kod.

### Kabul Edilmeyen PR Türleri
- Third-party bağımlılık ekleyen PR'lar
- Gerçek bir problem olmadan yapılan "iyileştirmeler"
- Kopyala-yapıştır, insan gözden geçirmesi olmayan değişiklikler

## Kullanım Senaryoları

```
# Yeni özellik geliştirme
"Kullanıcı profil sayfası ekle" 
→ Claude önce: tasarım planı, data model, API endpoints listeler
→ Onayından sonra test yazar, sonra implementasyon yapar

# Refactoring
"Bu modülü refactor et"
→ Claude önce: ne değişecek, ne değişmeyecek, risk noktaları listeler
→ Her adım için onay ister

# Bug fix
"Bu hatayı düzelt"
→ Claude önce: hatanın kök nedenini bulur, fix planını açıklar
→ Regression test yazar, sonra fix uygular
```

## Zero-Dependency Tasarım

Superpowers hiçbir external araç gerektirmez.
Sadece bir CLAUDE.md + GEMINI.md dosyasıdır — API key, npm paketi yok.
