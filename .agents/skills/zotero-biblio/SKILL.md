---
name: zotero-biblio
description: >-
  Use this skill when searching academic literature, managing citations, interacting with Zotero via MCP,
  generating evidence tables, or maintaining clean BibLaTeX files (.bib) across any citation style.
---

# Compétence Zotero & Bibliographie Académique (`zotero-biblio`)

Workflows et bonnes pratiques pour gérer les références scientifiques dans ce workspace via le serveur MCP `zotero-citations` et **BibLaTeX + Biber**, en s'adaptant librement aux choix du projet.

---

## 1. Bonnes pratiques de base (sans style imposé)

- **Fichier bibliographique :** `biblio/references.bib` (chargé via `\addbibresource{biblio/references.bib}`).
- **Style totalement libre :** `templates/template_officiel/` embarque `biblio/custom-style.bbx`/`.cbx` à titre d'exemple de départ, mais chaque projet peut utiliser n'importe quel style BibLaTeX (`authoryear`, `numeric`, `ieee`, `vancouver`, `alphabetic`, etc.) sans contrainte imposée.
- **Commandes de citation souples :**
  - `\autocite{cle}`, `\parencite{cle}`, `\cite{cle}` ou `\supercite{cle}` selon les habitudes et le style du document (avec `~` devant en milieu/fin de phrase : `~\autocite{cle}`).
  - `\textcite{cle}` lorsque l'auteur est le sujet grammatical de la phrase (`Comme l'expliquent \textcite{cle}...`).
  - *Astuce :* `\autocite{cle}` s'adapte automatiquement si le style du document passe d'auteur-année à numérique.

---

## 2. Workflows rapides

### Recherche bibliographique & ajout dans `biblio/references.bib`
1. Interroger `zotero_search_items`, `zotero_semantic_search` ou `zotero_scholar`.
2. Inspecter les métadonnées complètes avec `zotero_get_item` (vérifier DOI nu `10.xxxx/...`, auteurs, date ISO `YYYY-MM-DD`, titre protégé par `{...}`).
3. Ajouter l'entrée formatée dans `biblio/references.bib` (clé libre — ex. clé Zotero existante ou `auteur2024mot`, en évitant uniquement espaces, accents et doublons).
4. Vérifier que les citations compilent sans avertissement Biber (`WARN - ...`) lors du build `latexmk`.

### Tableaux de synthèse documentaire (*Evidence Tables*)
1. Sélectionner les clés Zotero pertinentes et appeler `zotero_evidence_table`.
2. Générer un tableau `tabularx` + `booktabs` (`L`, `C`, `R`, `Y`) dans `content/<chapitre>.tex` ou dans un fichier modulaire inclus via `\input{...}`, selon [`sample-evidence-table.tex`](./examples/sample-evidence-table.tex).

### Audit d'intégrité du `.bib`
Exécuter le script de contrôle avant finalisation :
```powershell
.\.agents\skills\zotero-biblio\scripts\audit-bib.ps1 -BibFile "projets/<mon-projet>/biblio/references.bib"
```

---

## 3. Documentation et exemples associés
- **[Guide des outils MCP Zotero](./references/zotero-mcp-guide.md)** : paramètres et usages de `zotero-citations`.
- **[Guide BibLaTeX & styles libres](./references/vancouver-biblatex.md)** : exemples d'options (`custom-style`, `numeric`, `ieee`, `vancouver`) et bonnes pratiques `.bib`.
- **[Exemple de tableau de synthèse](./examples/sample-evidence-table.tex)** et **[exemple `.bib`](./examples/sample-references.bib)**.
