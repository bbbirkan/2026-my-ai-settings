---
name: code-wiki
description: GitHub repolarının URL'sinden otomatik dokümantasyon, wiki ve mimari diyagramlar çıkaran (codewiki.google) analiz skill'i.
tags: [skill, documentation, github, architecture]
---
# Code Wiki Skill

## Mimarisi ve Çalışma Mantığı
Google destekli bu araç, karmaşık bir repoyu saniyeler içinde analiz eder. Sistemin çalışması, kodu indirip parse ederek bileşenler arası ilişkileri çıkarması ve bunları görsel mimari diyagramlara dönüştürmesi temeline dayanır. Repo'ya özel Gemini destekli soru-cevap özelliği vardır.

## Prompt ve RCI Döngüsü
<thinking>
1. Hedef: Yeni keşfedilen bir GitHub reposunun mimarisini anlamak.
2. Plan: codewiki.google mantığını lokalde çalıştırarak veya API kullanarak reponun yapısını analiz et.
3. Uygulama: Çıkarılan wiki'yi Obsidian vault'a aktar.
</thinking>
