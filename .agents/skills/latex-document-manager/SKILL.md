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
- **[Compile Document](../../../templates/template_principal/scripts/compile.ps1):** Runs `latexmk -lualatex` targeting `main.tex` and outputs to `build/`.
- **[Clean Build](../../../templates/template_principal/scripts/clean.ps1):** Cleans auxiliary compilation files.

---

## 2. Reusable Templates & Modular Ecosystem

Ready-to-use document templates are located in [`templates/`](../../../templates/):
- **[Template Principal (`templates/template_principal/`)](../../../templates/template_principal/README.md):** Complete academic thesis, portfolio, and report template based on `ClasseGuillaume.cls`, with full LuaLaTeX font support, intelligent todonotes, multiple geometries, and booktabs tables. **This is the primary reference template on which to base projects.**
- **Écosystème modulaire de templates :** Le dossier `templates/` contient plusieurs autres modèles (notes de calcul, rapports techniques, etc.) et l'utilisateur est libre d'en ajouter d'autres à tout moment. L'agent doit explorer dynamiquement le dossier `templates/` pour découvrir les structures pertinentes sans dépendre d'une liste figée.
- **Liberté d'optimisation :** Ces templates ne sont pas tous parvenus à un état optimal. L'agent est explicitement encouragé à s'écarter de pratiques obsolètes ou déconseillées rencontrées dans certains templates, à moderniser la structure et à introduire tout package moderne nécessaire.
- **[Article Template](./resources/templates/article-template.tex):** Clean, standard article template with modular preambles.

---

## 3. Reference Documentation

Consult these reference manuals during complex edits:
- **[KOMA-Script & Geometry Hybrid Guide](./references/koma-geometry-guide.md):** Architectural rationale and instructions for mixing KOMA-Script and `geometry` without header warnings.
- **[Modern Packages Guide](./references/packages-guide.md):** Best practices for fonts, math, figures, tables, and BibLaTeX.
- **[Common Errors & Diagnostics](./references/common-errors.md):** Detailed guide to resolving Overfull `\hbox`, missing packages, and bib anomalies.
- **[Code Snippets & Examples](./examples/snippets.tex):** Production-ready snippets for tables, math, callout boxes, and custom geometry switches.
