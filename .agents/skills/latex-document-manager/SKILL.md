---
name: latex-document-manager
description: >-
  Use this skill when creating, structuring, compiling, or troubleshooting LaTeX documents,
  modular preambles, mathematical formatting, and bibliographies in this workspace.
---

# LaTeX Document Manager Skill

This skill provides operational workflows, templates, and scripts for managing LaTeX documents within this repository.

---

## 1. Fast Scripts & Utilities

Helper scripts are available in the [`scripts/`](./scripts/) directory and directly in templates:
- **[Compile Document](../../../templates/rapport-memoire/scripts/compile.ps1):** Runs `latexmk -lualatex` targeting `main.tex` and outputs to `build/`.
- **[Clean Build](../../../templates/rapport-memoire/scripts/clean.ps1):** Cleans auxiliary compilation files.

---

## 2. Reusable Templates

Ready-to-use document templates are located in [`templates/`](../../../templates/):
- **[Rapport & Mémoire Universitaire Complet](../../../templates/rapport-memoire/README.md):** Complete academic thesis, portfolio, and report template based on `ClasseGuillaume.cls`, with full LuaLaTeX font support, intelligent todonotes, multiple geometries, and booktabs tables.
- **[Article Template](./resources/templates/article-template.tex):** Clean, standard article template with modular preambles.

---

## 3. Reference Documentation

Consult these reference manuals during complex edits:
- **[KOMA-Script & Geometry Hybrid Guide](./references/koma-geometry-guide.md):** Architectural rationale and instructions for mixing KOMA-Script and `geometry` without header warnings.
- **[Modern Packages Guide](./references/packages-guide.md):** Best practices for fonts, math, figures, tables, and BibLaTeX.
- **[Common Errors & Diagnostics](./references/common-errors.md):** Detailed guide to resolving Overfull `\hbox`, missing packages, and bib anomalies.
- **[Code Snippets & Examples](./examples/snippets.tex):** Production-ready snippets for tables, math, callout boxes, and custom geometry switches.
