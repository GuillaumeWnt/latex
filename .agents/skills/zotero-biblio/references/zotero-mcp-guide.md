# Guide des Outils MCP Zotero (`zotero-citations`)

Ce guide récapitule les principaux outils du serveur MCP `zotero-citations` pour alimenter et vérifier `biblio/references.bib`.

---

## 1. Recherche & Découverte

- **`zotero_search_items`** : recherche dans la bibliothèque Zotero locale (`query`, `collection` optionnelle, `tag` optionnel, `limit`).
- **`zotero_semantic_search`** : recherche conceptuelle par similarité sémantique dans la bibliothèque.
- **`zotero_scholar`** : recherche académique externe (`query`, `num_results`) pour récupérer métadonnées, compteurs de citations et extraits BibTeX.

---

## 2. Extraction & Synthèse

- **`zotero_get_item`** : extrait les métadonnées complètes d'un item (`title`, `creators`, `publicationTitle` → `journaltitle`/`booktitle`, `date`, `DOI`, `url`, `urldate`, `abstractNote`).
- **`zotero_evidence_table`** : génère une matrice structurée à partir d'une liste `item_keys` et de colonnes `fields` (ex. `["Objective", "Methodology", "Sample", "Results", "Limitations"]`).
  - Intégrer le résultat dans `content/<section>.tex` (ou dans un fichier dédié inclus par `\input{...}`) au format `tabularx` + `booktabs` (`L`, `C`, `R`, `Y`).

---

## 3. Export & Hygiène de bibliothèque

- **`zotero_export`** : export direct d'items ou de collections au format `biblatex` (à privilégier par rapport à `bibtex` brut).
- **`zotero_tag_audit`** : contrôle la cohérence des tags et repère les références non classées.

> **Rappel qualité :** après tout ajout ou mise à jour dans `biblio/references.bib`, lancer `audit-bib.ps1` et recompiler avec `latexmk` pour vérifier que Biber n'émet ni erreur ni avertissement (`WARN - BibTeX subsystem`).
