# Architecture Documentaire & Modèle `template_officiel`

## 1. Structure de Référence (`templates/template_officiel/`)

Tout nouveau projet créé dans ce dépôt doit être placé sous `projets/<nom_projet>/` et suivre intégralement l'architecture modulaire de `templates/template_officiel/` :

```text
projets/<nom_projet>/
├── main.tex                  # Chef d'orchestre unique (profil screen/print, front/main/appendix/back)
├── mythesis.cls              # Classe KOMA-Script (scrbook) + métadonnées + calque logo
├── mythesis-screen.clo       # Profil écran (marges symétriques, palette interactive, hyperliens colorés)
├── mythesis-print.clo        # Profil impression reliée (twoside, BCOR=10mm, liens neutres)
├── latexmkrc                 # Compilation auto LuaLaTeX + Biber + outdir=build
├── .chktexrc                 # Linter typographique (espaces insécables ~ avant \cref/\cite)
├── .editorconfig             # UTF-8, LF, indentation 2 espaces (.tex/.cls/.sty/.bib)
├── .gitignore                # Exclusion de build/ et des auxiliaires TeX
├── config/
│   ├── packages.sty          # Importation ordonnée et configuration des packages tiers
│   └── macros.sty            # Macros maths/texte (\term, \code), boîtes tcolorbox, géométries, \todoH
├── frontmatter/              # Page de titre, remerciements, résumés bilingues
├── content/                  # Chapitres rédactionnels autonomes (01-*.tex ... conclusion.tex)
├── backmatter/               # Annexes (appendix-*.tex) et glossaire (glossary.tex)
├── biblio/                   # Base references.bib + styles BibLaTeX custom-style.bbx/.cbx
├── data/                     # Données brutes (.csv, .tsv) tracées par pgfplots
├── listings/                 # Codes sources externes testables importés via \lstinputlisting
├── figures/                  # Médias vectoriels, figures Python/Matplotlib et sous-dossier tikz/
├── fonts/                    # Polices locales OpenType (portabilité CI/CD & Overleaf)
├── scripts/                  # Scripts locaux (ex. generate_plots.py via uv)
└── build/                    # Sorties de compilation (généré automatiquement, gitignored)
```

---

## 2. Création de Projet & Règle de Rétroportage

1. **Initialisation :**
   - Copier `templates/template_officiel/` (hors dossier `build/`) vers `projets/<nom_projet>/`.
   - Adapter les métadonnées dans `main.tex` et les textes de `frontmatter/`, `content/`, `backmatter/`, `biblio/references.bib`.
   - Ne jamais créer un nouveau projet en partant de zéro ou d'un ancien modèle (`template_principal/`, `BE_mecanique/`, `labo_PID/`), sauf demande explicite de l'utilisateur.
2. **Rétroportage continu vers `templates/template_officiel/` :**
   - Dès qu'une fonctionnalité générique (nouvelle macro dans `config/macros.sty`, environnement `tcolorbox`, amélioration de `mythesis.cls`/`.clo`, nouveau réglage `config/packages.sty`, correction de bug ou d'avertissement TeX, amélioration de `latexmkrc`/`.chktexrc`) est ajoutée ou corrigée dans un projet, **elle doit également être rétroportée dans `templates/template_officiel/`**.
   - Vérifier que l'ajout rétroporté reste générique, compatible `screen` et `print`, et compile sans erreur dans `templates/template_officiel/`.

---

## 3. Règles d'Inclusion : `\include{}` vs `\input{}`

- **`\include{chemin/fichier}` (sans extension `.tex`) :**
  - Réservé exclusivement aux chapitres entiers (`content/*.tex`) et annexes autonomes (`backmatter/appendix-*.tex`) appelés depuis `main.tex`.
  - Insère automatiquement un saut de page, crée un `.aux` dédié (nécessite les sous-dossiers `build/content/` et `build/backmatter/` gérés par `latexmkrc`) et permet `\includeonly{...}`.
- **`\input{chemin/fichier.tex}` :**
  - Pour tous les sous-éléments : `frontmatter/`, sections internes, tableaux externalisés, schémas TikZ (`figures/tikz/`), `backmatter/glossary.tex`.
  - N'insère pas de saut de page forcé et ne doit jamais contenir d'appel `\include{}`.

---

## 4. Organisation de `.agents/`

```text
.agents/
├── mcp_config.json            # Serveurs MCP métier du workspace (synchronisés via sync-mcp.ps1)
├── rules/                     # Règles locales (architecture, general, coding-style, testing, security)
├── scripts/sync-mcp.ps1       # Synchronisation MCP vers .vscode, .claude, .gemini
├── workflows/                 # Procédures pas-à-pas (new-project, markdown-to-latex, build-and-verify)
├── subagents/                 # Sous-agents spécialisés (compilateur, QA, diagrammes, biblio, mémoire)
└── skills/                    # Skills modulaires :
    ├── markdown-to-latex/     # Conversion Markdown -> LaTeX enrichi (mythesis)
    ├── latex-document-manager/# Gestion documentaire, KOMA+geometry, erreurs courantes
    ├── latex-quality-auditor/ # Audit typographique, booktabs, lint-latex.ps1 + chktex
    ├── visual-diagrams/       # Draw.io MCP & TikZ / cadreFigure
    ├── zotero-biblio/         # Zotero MCP, BibLaTeX/Biber, audit .bib
    └── project-memory/        # Graphe Memory MCP & vérification Brave Search
```
