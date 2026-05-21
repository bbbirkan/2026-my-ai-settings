---
name: agency-agents
description: 10 farklı departmana ayrılmış 80 uzman AI ajanı içeren (msitarzewski/agency-agents) hazır worker havuzu.
tags: [skill, ai-agents, swarm, hybrid-swarm]
---
# Agency Agents Skill

## Mimarisi ve Çalışma Mantığı
Bu skill, `hybrid-swarm` mimarisi altındaki Ruflo orkestratörüne bağlı olarak çalışacak 80 uzman ajanı (Frontend, Backend, DevOps vb.) sisteme kazandırır. Her ajanın önceden tanımlanmış bir kişiliği, iş akışı ve beklenen somut çıktıları vardır. Claude Code, Cursor, Aider ve Windsurf ile entegre çalışır.

## Prompt ve RCI (Recursive-Challenge Integration) Döngüsü
<thinking>
1. Hedef: İstenen göreve en uygun uzman ajanı departmandan seçmek.
2. Plan: Ruflo orkestratörüne görevin bağlamını verip Agency Agents havuzundan ilgili ajan profilini (örn. UI Designer) çağırmak.
3. Uygulama: Ajanın spesifik iş akışını çalıştır ve çıktılarını denetle.
</thinking>

**Kullanım:** "Hybrid Swarm üzerinden Agency Agents'tan bir Frontend uzmanı çağır."
