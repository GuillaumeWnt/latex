---
name: zotero-biblio
description: >-
  Use this skill when searching academic literature, managing citations, interacting with Zotero via MCP,
  generating evidence tables, or maintaining BibLaTeX files (.bib) in author-year or Vancouver style.
---

# Compétence Zotero & Bibliographie Académique (`zotero-biblio`)

Workflows et bonnes pratiques pour gérer les références scientifiques dans ce workspace via le serveur MCP `zotero-citations` et **BibLaTeX + Biber**, en cohérence avec `templates/template_officiel/`.

---

## 1. Conventions du socle `template_officiel`

- **Fichier bibliographique :** `biblio/references.bib` (chargé via `\addbibresource{biblio/references.bib}`).
- **Style par défaut :** style auteur-année personnalisé (`biblio/custom-style.bbx` et `biblio/custom-style.cbx`).
- **Commandes de citation à privilégier :**
  - Citation parenthétique en fin de proposition : `~\parencite{cle}` ou `~\parencite[p.~42]{cle}`
  - Citation intégrée dans la phrase (sujet ou complément) : `\textcite{cle}` (précédé d'une espace normale dans la phrase, ex. `Comme l'expliquent \textcite{cle}...`)
  - En cas de bascule sur un style numérique (`vancouver`) : `~\autocite{cle}` ou `~\cite{cle}`.

---

## 2. Workflows rapides

### Recherche bibliographique & ajout dans `biblio/references.bib`
1. Interroger `zotero_search_items`, `zotero_semantic_search` ou `zotero_scholar`.
2. Inspecter les métadonnées complètes avec `zotero_get_item` (vérifier DOI nu `10.xxxx/...`, auteurs, date ISO `YYYY-MM-DD`, titre protégé par `{...}`).
3. Ajouter l'entrée formatée dans `biblio/references.bib` (clé recommandée : `auteurAnneeMot` en minuscules, ex. `dupont2024optimisation`).
4. Vérifier que `\textcite` / `\parencite` compile sans avertissement Biber (`WARN - ...`) lors du build `latexmk`.

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
- **[Guide BibLaTeX & styles](./references/vancouver-biblatex.md)** : configuration `custom-style` (défaut) vs `vancouver`, règles strictes `.bib`.
- **[Exemple de tableau de synthèse](./examples/sample-evidence-table.tex)** et **[exemple `.bib`](./examples/sample-references.bib)**.
