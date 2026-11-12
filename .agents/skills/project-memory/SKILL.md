---
name: project-memory
description: >-
  Use this skill when recording or retrieving persistent project knowledge, editorial decisions,
  glossary terms, acronyms, or fact-checking web data using the Memory MCP and Brave Search servers.
---

# Compétence Mémoire Projet & Recherche Web (`project-memory`)

Workflows pour persister les décisions éditoriales d'un projet LaTeX via le serveur MCP **`memory`** (configuré globalement dans `C:\Users\guill\.agents\mcp_config.json`) et effectuer des vérifications externes via **`brave-search`** (configuré dans `.agents/mcp_config.json`).

---

## 1. Workflows essentiels

### Rappel de contexte en début de session
1. Interroger `read_graph` ou `search_nodes` pour retrouver :
   - La configuration active du projet (`mythesis.cls`, police, géométrie, options print/screen).
   - Les acronymes, notations mathématiques et conventions de glossaire figées.
   - L'état d'avancement des chapitres dans `projets/<nom_projet>/`.

### Enregistrement de décisions éditoriales et notations
1. Créer les nœuds via `create_entities` avec des types cohérents :
   - `DocumentConfig` (classe, options, polices)
   - `GlossaryTerm` / `Notation` (terme, sigle, notation LaTeX)
   - `StylingPreference` (macros projet, choix à rétro-porter dans `template_officiel`)
   - `ResearchClaim` / `LiteratureEntity` (faits vérifiés, clés BibLaTeX)
2. Relier ces entités aux projets/chapitres via `create_relations`.

### Vérification technique CTAN & DOI (`brave-search`)
1. Lancer `brave_web_search` avec des requêtes ciblées :
   - `site:ctan.org <package> documentation`
   - `"10.xxxx/..." doi metadata`
2. Capitaliser les résultats validés dans `memory` (et, si le sujet est structurant pour le projet, dans un fichier `.md` dédié selon la règle globale de capitalisation documentaire).

---

## 2. Ressources associées
- **[Guide du graphe de mémoire](./references/memory-graph-guide.md)** : schéma d'entités et relations recommandés pour `template_officiel`.
- **[Playbook Brave Search](./references/brave-search-playbook.md)** : requêtes ciblées CTAN, DOI et normes.
- **[Exemple de graphe JSON](./examples/sample-memory-graph.json)** : instantané aligné sur `mythesis.cls`.
