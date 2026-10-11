# Document Architecture & Modular Layout

## 1. Recommended Workspace Directory Tree

For all multi-page LaTeX documents, adhere to this modular layout:

```text
├── main.tex                 # Master file (calls preambles and content)
├── preamble/                # Modular configuration files
│   ├── packages.tex         # All \usepackage imports
│   ├── geometry.tex         # Page margins, headers & footers
│   ├── typography.tex       # Fonts, language (babel/polyglossia), microtype
│   ├── math.tex             # AMS packages, custom theorem environments
│   ├── tables.tex           # booktabs, tabularx, array adjustments
│   ├── graphics.tex         # graphicx, tikz, figure setup
│   ├── biblio.tex           # biblatex configuration & style
│   ├── hyperref.tex         # hyperref, cleveref, PDF metadata
│   └── commands.tex         # Custom shortcuts and project-specific macros
│
├── content/                 # Document body (or chapters/ for books/theses)
│   ├── 00_abstract.tex
│   ├── 01_introduction.tex
│   ├── 02_state_of_the_art.tex
│   ├── 03_methodology.tex
│   ├── 04_experiments.tex
│   └── 05_conclusion.tex
│
├── figures/                 # All visual assets
│   ├── pdf/                 # High-resolution vector diagrams
│   ├── png/                 # Screenshots or bitmaps
│   └── tikz/                # TikZ or standalone source codes
│
├── bib/                     # Bibliography files
│   └── references.bib       # Clean, deduplicated BibLaTeX database
│
└── build/                   # Compilation output directory (gitignored)
```

---

## 2. Master File Anatomy (`main.tex`)

A typical master file must remain clean and readable:

```latex
\documentclass[11pt,a4paper]{article}

% --- Modular Preambles ---
\input{preamble/packages.tex}
\input{preamble/geometry.tex}
\input{preamble/typography.tex}
\input{preamble/math.tex}
\input{preamble/biblio.tex}
\input{preamble/commands.tex}
\input{preamble/hyperref.tex} % Loaded last with cleveref

\addbibresource{bib/references.bib}

\begin{document}

\maketitle
\input{content/00_abstract.tex}

\tableofcontents
\newpage

\input{content/01_introduction.tex}
\input{content/02_methodology.tex}
\input{content/03_conclusion.tex}

\printbibliography

\end{document}
```

---

## 3. Inclusion Rules: `\input{}` vs `\include{}`

- **Use `\input{path/file.tex}`:**
  - For preamble components.
  - For sections of an article or short reports.
  - Does NOT enforce a page break before/after.
- **Use `\include{path/file}` (without `.tex` extension):**
  - Only for chapters in `report` or `book` classes.
  - Automatically inserts `\clearpage`.
  - Enables fast draft compilation via `\includeonly{...}` in the preamble.

