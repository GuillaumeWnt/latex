# GitHub Copilot Instructions — LaTeX Authoring Workspace

> **Central Reference:** All authoritative conventions, document structures, scripts, and procedures reside in the [`.agents/`](../.agents) directory.

---

## 1. Core Guidelines
When writing, completing, or refactoring LaTeX documents in this workspace:

* **Coding Standards:** Follow [`.agents/rules/coding-style.md`](../.agents/rules/coding-style.md):
  * Maintain 2-space indentation inside all environments.
  * Use semantic line breaks (one sentence per line) for optimal Git diffs.
  * Use modern AMS math (`\[ ... \]`, `\begin{align}`, `\DeclarePairedDelimiter`). Never use `$$ ... $$`.
  * Create tables using `booktabs` (`\toprule`, `\midrule`, `\bottomrule`) with **strictly zero vertical lines** (`|`).
  * Use `cleveref` (`\cref{...}`) for all cross-references with standardized prefixes (`sec:`, `fig:`, `tab:`, `eq:`).
* **Modularity:** Keep document preambles strictly separate from content files in accordance with [`.agents/rules/architecture.md`](../.agents/rules/architecture.md).

---

## 2. Compilation & Diagnostics
* **Build Engine:** Standard compilation command is `latexmk -pdf -outdir=build -interaction=nonstopmode -synctex=1 main.tex`.
* **Troubleshooting:** Refer to the diagnostic workflow in [`.agents/workflows/sample-workflow.md`](../.agents/workflows/sample-workflow.md) and reference guides in [`.agents/skills/sample-skill/references/`](../.agents/skills/sample-skill/references/).

---

## 3. Assets & Templates
* Consult [`.agents/skills/sample-skill/resources/templates/`](../.agents/skills/sample-skill/resources/templates/) for base document templates and [`.agents/skills/sample-skill/examples/snippets.tex`](../.agents/skills/sample-skill/examples/snippets.tex) for formatted table and formula examples.

