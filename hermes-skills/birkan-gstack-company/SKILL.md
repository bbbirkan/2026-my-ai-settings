---
name: gstack-company
description: |
  Garry Tan (YC CEO) tarafından oluşturulan gstack plugin'i — Claude Code'a
  CEO, CTO, mühendislik müdürü, QA, release manager dahil 23 farklı kurumsal
  rol kazandırır. Tek bir plugin içinde tam şirket hiyerarşisi.

  TRIGGER bu skill'i şu durumlarda çağır:
  - "proje yöneticisi modu", "CEO gözüyle bak", "mühendislik müdürü" istendiğinde
  - Kod review için farklı perspektif (QA, security, performance) istendiğinde
  - Release yönetimi, sprint planlama, teknik borç analizi istendiğinde
  - gstack, Garry Tan, YC (Y Combinator) bahsi geçtiğinde
  - "şirket gibi çalış", "takım simülasyonu" istendiğinde
---

# gstack — Şirket Hiyerarşisi Plugin

Y Combinator CEO'su Garry Tan'ın geliştirdiği, Claude Code'u tam bir yazılım
şirketi gibi çalıştıran plugin sistemi.

**Kaynak:** https://github.com/garrytan/gstack  
**Yerel:** `/Users/birkan/Desktop/Work /00 Github PROJELERI/gstack/`

## 23 Rol — Ne Zaman Hangisi

### C-Suite & Liderlik
| Rol | Ne Zaman Kullanılır |
|-----|---------------------|
| **CEO** | Ürün yönü kararları, önceliklendirme, "büyük resim" |
| **CTO** | Mimari kararlar, teknoloji seçimi, teknik borç |
| **CPO** | Kullanıcı deneyimi, feature öncelikleri, roadmap |

### Mühendislik
| Rol | Ne Zaman Kullanılır |
|-----|---------------------|
| **Engineering Manager** | Sprint planlama, ekip koordinasyonu |
| **Staff Engineer** | Karmaşık sistem tasarımı, RFC yazımı |
| **Senior Developer** | Kod review, refactoring, mimari |
| **Junior Developer** | Basit implementasyonlar, bug fix |

### Kalite & Güvenlik
| Rol | Ne Zaman Kullanılır |
|-----|---------------------|
| **QA Lead** | Test stratejisi, edge case tespiti |
| **Security Engineer** | Güvenlik audit, vulnerability analizi |
| **Performance Engineer** | Bottleneck analizi, optimizasyon |

### Operasyonlar
| Rol | Ne Zaman Kullanılır |
|-----|---------------------|
| **Release Manager** | Deployment planı, rollback stratejisi |
| **DevOps Engineer** | CI/CD, altyapı, monitoring |
| **SRE** | Incident response, SLA yönetimi |

### İş & İletişim
| Rol | Ne Zaman Kullanılır |
|-----|---------------------|
| **Product Manager** | User story yazımı, acceptance criteria |
| **Technical Writer** | Dökümantasyon, API docs |
| **Data Analyst** | Metrik analizi, A/B test yorumlama |

## Kurulum

```bash
# Marketplace'e ekle
/plugin marketplace add garrytan/gstack

# Kurulum
/plugin install gstack
```

## Kullanım Örnekleri

```
# CEO perspektifi
"CEO gözüyle bu feature'ın business value'suna bak"

# QA modu
"QA Lead olarak bu kodu test et — edge case'leri bul"

# Security audit
"Security Engineer olarak bu API endpoint'ini incele"

# Release planlama
"Release Manager olarak bu deploy'u planla"

# Full review
"Bu PR'ı Staff Engineer, QA Lead ve Security Engineer olarak sırayla incele"
```

## Test & Geliştirme Komutları

```bash
bun install          # bağımlılıkları kur
bun test             # ücretsiz testler
bun run test:evals   # LLM judge + E2E testler (~$4/çalıştırma)
bun run skill:check  # skill sağlık raporu
bun run dev:skill    # watch mode: otomatik yeniden üret + doğrula
```

## Felsefe

gstack, Claude Code'un "tek bir ajan gibi" değil "bir ekip gibi" davranmasını sağlar.
Her rol kendi expertise'ini getirir:
- QA, developer'ın gözden kaçırdığı edge case'leri bulur
- Security engineer, performans optimizasyonunun açtığı deliği görür
- Release manager, "bu sabah deploy olur mu?" sorusunu gerçekçi cevaplar

**Temel ilke:** Tek bir "süper-ajan" yerine, uzmanlaşmış roller arasında
sorumluluk paylaşımı. Gerçek ekiplerin nasıl çalıştığını simüle eder.
