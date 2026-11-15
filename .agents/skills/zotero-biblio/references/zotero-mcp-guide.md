# Guide des Outils MCP Zotero (`zotero-citations`)

Ce guide récapitule les principaux outils du serveur MCP `zotero-citations` pour alimenter et vérifier `biblio/references.bib`.

---

## 1. Recherche, Identité & Contrôle externe

- **`zotero_whoami`** : à appeler en premier pour connaître le mode actif (`localApi`, `cloud`), la bibliothèque par défaut (`users/0` en local) et l'état de l'index sémantique.
- **`zotero_search_items`** : recherche dans la bibliothèque Zotero (`q`, `collectionKey` optionnelle, `tag` optionnel, `itemType`, `limit`).
- **`zotero_semantic_search`** : recherche conceptuelle par similarité sémantique dans la bibliothèque (nécessite `zotero_index action:"build"` au préalable).
- **`zotero_scholar`** : interrogation du graphe scientifique **externe** (OpenAlex + Crossref, ne modifie ni ne lit votre bibliothèque sauf avec `include_in_library: true`) à partir d'un `doi` et d'une `action` :
  - `lookup` : métadonnées complètes (auteurs, revue, volume/pages, date), nombre de citations et lien éventuel vers un PDF Open Access ;
  - `references` / `citations` / `related` : articles cités, articles citants ou travaux proches ;
  - `notices` : contrôle d'intégrité scientifique croisé (Crossref + Retraction Watch + OpenAlex) pour détecter d'éventuelles rétractations, corrections, errata ou retraits déposés contre ce DOI.

---

## 2. Extraction, Vérification & Synthèse

- **`zotero_get_item`** : extrait les métadonnées complètes d'un item (`title`, `creators`, `publicationTitle` → `journaltitle`/`booktitle`, `date`, `DOI`, `url`, `urldate`, `abstractNote`).
- **`zotero_evidence_table`** : génère une matrice structurée à partir d'une liste `item_keys` et de colonnes `fields` (ex. `["Objective", "Methodology", "Sample", "Results", "Limitations"]`).
  - Intégrer le résultat dans `content/<section>.tex` (ou dans un fichier dédié inclus par `\input{...}`) au format `tabularx` + `booktabs` (`L`, `C`, `R`, `Y`).
- **`zotero_check_citations`** : vérifie un brouillon LaTeX ou Markdown par rapport aux items et PDF stockés dans Zotero afin de repérer les citations inventées ou citations directes inexactes.

---

## 3. Export & Hygiène de bibliothèque

- **`zotero_export`** : export direct d'items ou de collections de **votre bibliothèque Zotero** au format `biblatex` ou `better-biblatex` (à privilégier par rapport à `bibtex` brut).
- **`zotero_tag_audit`** : contrôle la cohérence des tags et repère les références non classées.

---

## 4. Mode local (lecture seule) vs Écriture

- **Paramètre `ZOTEUS_LOCAL` (`auto` | `on` | `off`) :** utiliser `"auto"` (défaut) ou `"on"` pour exploiter Zotero Desktop lorsqu'il est ouvert avec bascule automatique sur l'API Web cloud (`ZOTERO_API_KEY`) ; réserver `"off"` à un usage 100 % cloud. Ne jamais mettre `"true"`.
- **Sans clé API cloud (`ZOTERO_API_KEY`) avec Zotero Desktop antérieur à la v10 :** le serveur fonctionne en **mode lecture seule** (`local-only read mode`) via l'API locale (`127.0.0.1:23119`, à activer dans *Zotero → Paramètres → Avancé → Général → Autoriser les autres applications sur cet ordinateur à communiquer avec Zotero*). Aucun outil ne modifie alors votre application Zotero locale.
- **Création / mise à jour d'items (`zotero_create_items`, `zotero_update_item`) :** nécessite soit une version Zotero Desktop compatible écriture locale (`Zotero 10+`), soit une clé API cloud (`ZOTERO_API_KEY`) configurée pour écrire via l'API Web Zotero.

> **Rappel qualité :** après tout ajout ou mise à jour dans `biblio/references.bib`, lancer `audit-bib.ps1` et recompiler avec `latexmk` pour vérifier que Biber n'émet ni erreur ni avertissement (`WARN - BibTeX subsystem`).
