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

Helper scripts are available in the [`scripts/`](./scripts/) directory:
- **[Compile Document](./scripts/compile.ps1):** Runs `latexmk` targeting `main.tex` and outputs to `build/`.
- **[Clean Build](./scripts/clean.ps1):** Cleans auxiliary compilation files.

---

## 2. Reusable Templates

Ready-to-use document templates are located in [`resources/templates/`](./resources/templates/):
- **[Article Template](./resources/templates/article-template.tex):** Clean, modern standard article with modular preambles.
- **[Report Template](./resources/templates/report-template.tex):** Multi-chapter report setup with frontmatter, mainmatter, and appendix.

---

## 3. Reference Documentation

Consult these reference manuals during complex edits:
- **[Modern Packages Guide](./references/packages-guide.md):** Best practices for fonts, math, figures, tables, and BibLaTeX.
- **[Common Errors & Diagnostics](./references/common-errors.md):** Detailed guide to resolving Overfull `\hbox`, missing packages, and bib anomalies.

