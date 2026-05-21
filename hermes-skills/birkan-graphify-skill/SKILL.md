---
name: graphify-skill
description: |
  Graphify knowledge graph aracının kurulum, çalıştırma, query ve Obsidian
  export rehberi. Herhangi bir proje klasörünü anında knowledge graph'a çevirir.
  Binary: /Users/birkan/.local/bin/graphify

  TRIGGER bu skill'i şu durumlarda çağır:
  - "/graphify", "knowledge graph", "graph build" istendiğinde
  - Obsidian export, graph query, god node analizi istendiğinde
  - Yeni bir proje klasörüne graphify kurmak istendiğinde
  - "graphify query", "graphify path", "graphify explain" sorulduğunda
---

# Graphify — Knowledge Graph Skill

Herhangi bir klasörü LLM-destekli knowledge graph'a çeviren araç.

**Binary:** `/Users/birkan/.local/bin/graphify`  
**Python:** `/Users/birkan/.local/pipx/venvs/graphifyy/bin/python`  
**Kaynak:** `/Users/birkan/Desktop/Work /00 Github PROJELERI/graphify/`

## Temel Komutlar

```bash
# Tam extraction (AST + semantic LLM)
graphify extract <klasör>

# Sadece AST (LLM gerekmez, hızlı)
graphify update <klasör>

# Mevcut graph'tan cluster + HTML yeniden üret
graphify cluster-only <klasör>

# Git hook kur (her commit'te otomatik güncelleme)
graphify hook install
```

## Query Komutları

```bash
# Doğal dil sorgu (BFS)
graphify query "sorum ne?" --graph <path>/graphify-out/graph.json --budget 3000

# İki node arasındaki en kısa yol
graphify path "node-a" "node-b" --graph <path>/graphify-out/graph.json

# Node açıklaması + komşuları
graphify explain "node-adı" --graph <path>/graphify-out/graph.json
```

## Export Komutları

```bash
# Obsidian vault (her node = .md dosyası + graph.canvas)
graphify export obsidian \
  --graph <path>/graphify-out/graph.json \
  --dir /path/to/obsidian/vault/

# Collapsible tree HTML
graphify tree \
  --label "Proje Adı" \
  --graph <path>/graphify-out/graph.json \
  --output <path>/graphify-out/GRAPH_TREE.html

# Diğer formatlar
graphify export html        # İnteraktif D3 graph
graphify export graphml     # Neo4j uyumlu
graphify export svg         # Statik SVG
```

## Multi-Repo Birleştirme

```bash
# 2+ graph.json'u cross-repo graph'a birleştir
graphify merge-graphs \
  /repo1/graphify-out/graph.json \
  /repo2/graphify-out/graph.json \
  --out /path/to/cross-repo-graph.json
```

## Birkan'ın Kurulu Graph'ları

| Klasör | graph.json | Boyut |
|--------|-----------|-------|
| 01 Promt MUHENDISLIGI | `graphify-out/graph.json` | 229 node |
| 00 Github PROJELERI | `graphify-out/graph.json` | 48,696 node |
| 2026_Trade Bots | `graphify-out/graph.json` | 34,933 node |
| **Cross-repo** | `/Desktop/Work /cross-repo-graph.json` | 83,858 node |

## Obsidian Vault'ları

```
/Users/birkan/Desktop/Work /Beynim/Obsidian Beynim/Graphify/
├── 01_Promt_Muhendisligi/   (231 not)
├── 00_Github_Projeleri/     (2,924 not)
└── 02_Trade_Bots/           (8,636 not)
```

## .gitignore için Önerilen

```gitignore
graphify-out/graph.json
graphify-out/graph_slim.json
graphify-out/*.html
graphify-out/cache/
graphify-out/.graphify_chunk_*.json
```

## Slim Graph (Büyük Repolar İçin)

48K+ node'lu graphlarda HTML viz ve Obsidian export için slim graph üret:

```python
# Yüksek-degree node'ları filtrele
python3 slim_graph.py --min-degree 3 --max-label 80 --top 3000 \
  --input graphify-out/graph.json \
  --output graphify-out/graph_slim.json
```
