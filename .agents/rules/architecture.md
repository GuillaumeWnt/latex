# Document Architecture & Modular Layout

## 1. Recommended Workspace Directory Trees

This workspace supports two clean, modular architectures for LaTeX authoring:

### Layout A: Modèle de Référence (`templates/template_principal/`)
Le dossier `templates/` héberge plusieurs modèles de documents afin de couvrir différents besoins. Parmi eux, **`templates/template_principal/` est le template principal et pérenne de référence** sur lequel s'appuyer en priorité :

```text
templates/template_principal/
├── README.md                 # Documentation complète et aide-mémoire
├── main.tex                 # Fichier maître (ordonnance chapitres, frontmatter, backmatter)
├── ClasseGuillaume.cls      # Classe personnalisée modulaire (KOMA-Script, polices, styles)
├── Fonts/                   # Polices OpenType / TrueType locales (Asap, Calibri, ComicSans)
├── images/                  # Ressources graphiques et logos institutionnels
├── chapters/                # Modules de chapitres
│   ├── 00_frontmatter/      # Page de titre, résumé, todos
│   ├── 01_chapitre1/        # Sections modulaires du chapitre 1
│   └── 02_chapitre2/        # Sections modulaires du chapitre 2
├── tables/                  # Tableaux booktabs / tabularx externalisés
├── bib/                     # Base bibliographique BibLaTeX (references.bib)
├── scripts/                 # Scripts de compilation et nettoyage (compile.ps1, clean.ps1)
└── build/                   # Dossier de compilation (gitignored)
```

### Écosystème des templates (`templates/`) & directives d'évolution
- **Multiplicité et modularité :** Le répertoire `templates/` contient plusieurs templates adaptés à divers types de documents (rapports, notes de calcul, mémoires, etc.). L'utilisateur peut en ajouter de nouveaux au fil du temps sans avoir à modifier la documentation. Les agents doivent explorer dynamiquement le dossier `templates/` pour découvrir les modèles disponibles selon le contexte.
- **Rôle pivot de `template_principal` :** `templates/template_principal/` reste le socle de référence structurel et typographique immuable du dépôt.
- **Liberté d'optimisation et modernisation :** Les templates présents dans `templates/` ne sont pas tous parfaits ou optimaux à ce jour. Si un modèle comporte des mauvaises pratiques (packages obsolètes, formatage rigide, commandes dépréciées, etc.), **l'IA a pleine autorisation de s'en écarter, de moderniser le code et d'ajouter tout package ou macro moderne pertinent** pour garantir un résultat de qualité supérieure.

### Layout B: Preamble-Folder Layout (`preamble/`) — *Reference Only*
> **Note:** This layout is documented as a reference architecture for articles and multi-author papers. It is **not currently implemented** in this workspace. Only Layout A is active.

Recommended for articles and modular multi-author papers without custom `.cls`:

```text
├── main.tex                 # Master file
├── preamble/                # Modular configuration files
│   ├── packages.tex         # \usepackage imports
│   ├── geometry.tex         # Page margins, headers & footers
│   ├── typography.tex       # Fonts, language (babel), microtype
│   ├── math.tex             # AMS packages, custom theorem environments
│   ├── tables.tex           # booktabs, tabularx
│   ├── graphics.tex         # graphicx, figure setup
│   ├── biblio.tex           # biblatex configuration
│   ├── hyperref.tex         # hyperref, cleveref, PDF metadata
│   └── commands.tex         # Custom shortcuts and macros
├── content/                 # Document body sections
├── figures/                 # All visual assets
├── bib/                     # Bibliography files
└── build/                   # Compilation output directory (gitignored)
```

---

## 2. Master File Anatomy (`main.tex`)

A clean master file delegates all styling to the class/preamble and orchestrates structure:

```latex
\documentclass[
  french,
  english,
  font=calibri,
  todoNote
]{ClasseGuillaume}

% --- Metadata ---
\title{Document Title}
\author{Author Name}
\date{\today}

% --- Bibliography Database ---
\addbibresource{bib/references.bib}

\begin{document}

% --- Frontmatter ---
\frontmatter
\masquerLogo
\geometrieLarge
\input{chapters/00_frontmatter/titlepage.tex}
\geometrieWord
\begin{singlespace}
  \listoftodos[Liste des révisions]
  \label{table_todos}
\end{singlespace}
\input{chapters/00_frontmatter/abstract.tex}
\tableofcontents

% --- Mainmatter ---
\mainmatter
\afficherLogo
\chapter{First Chapter}
\input{chapters/01_chapitre1/sec01_presentation.tex}

% --- Annexes ---
\appendix
\chapter{Documents Complémentaires}
\includepdf[pages=-, pagecommand={\thispagestyle{plain}}]{path/to/annexe.pdf}  % adapter le chemin

% --- Backmatter ---
\backmatter
\listoffigures
\listofillustrations
\listoftables
\printbibliography[heading=bibintoc, title={Références Bibliographiques}]

\end{document}
```

---

## 3. Inclusion Rules: `\input{}` vs `\include{}`

- **Use `\input{path/file.tex}`:**
  - For preamble components and `.cls` sub-modules.
  - For sections, tables, and subsections inside chapters.
  - Does NOT enforce an unwanted page break.
- **Use `\include{path/file}` (without `.tex` extension):**
  - Only for entire standalone chapters in `report` or `book` classes.
  - Automatically inserts `\clearpage`.
  - **Never use `\include{}` inside sections, tables, or another included file.**

---

## 4. Specialized AI Assistants & Skills Tree (`.agents/`)

```text
.agents/
├── subagents/
│   ├── biblio-researcher.md     # Zotero MCP, arXiv, Brave Search, BibLaTeX evidence synthesis
│   ├── diagram-designer.md      # Draw.io MCP, TikZ, cadreFigure, illustration float
│   ├── latex-qa-reviewer.md     # Typographical auditing, booktabs, ~ spacing, memory recall
│   ├── compiler-debugger.md     # LuaLaTeX logs, geometry/KOMA conflicts, fontspec
│   └── knowledge-curator.md     # Memory MCP (knowledge graph), Brave Search fact-checking
└── skills/
    ├── latex-document-manager/  # Core LaTeX authoring runbook, KOMA+geometry guide
    ├── zotero-biblio/           # Literature research, evidence tables, bib audit
    ├── visual-diagrams/         # Draw.io MCP & TikZ schematics, cadreFigure
    ├── latex-quality-auditor/   # Pre-flight publishing audit, lint-latex.ps1
    └── project-memory/          # Knowledge graph persistence, styling recall, web search
```

