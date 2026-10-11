# Document Architecture & Modular Layout

## 1. Recommended Workspace Directory Trees

This workspace supports two clean, modular architectures for LaTeX authoring:

### Layout A: Class-Based Template (`templates/rapport-memoire/`)
Recommended for theses, dissertations, portfolios, and comprehensive university reports:

```text
templates/rapport-memoire/
├── README.md                 # Complete documentation and cheatsheet
├── main.tex                 # Master file (calls chapters, frontmatter, backmatter)
├── ClasseGuillaume.cls      # Modular KOMA-Script custom class (styling, packages, fonts)
├── Fonts/                   # Local TrueType / OpenType font families (Asap, Calibri, ComicSans)
├── images/                  # Institutional and graphic assets (logos, diagrams)
├── chapters/                # Modular document chapters
│   ├── 00_frontmatter/      # Title page, abstract, todolist
│   ├── 01_chapitre1/        # Chapter I modular sections
│   └── 02_chapitre2/        # Chapter II modular sections
├── tables/                  # Externalized booktabs/tabularx tables
├── bib/                     # BibLaTeX database (references.bib)
├── scripts/                 # Compilation and maintenance scripts (compile.ps1, clean.ps1)
└── build/                   # Compilation output directory (gitignored)
```

### Layout B: Preamble-Folder Layout (`preamble/`)
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
\includepdf[pages=-, pagecommand={\thispagestyle{plain}}]{documents/annexe.pdf}

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

