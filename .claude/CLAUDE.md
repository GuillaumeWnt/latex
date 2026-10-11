# Claude Code Project Directives — LaTeX Authoring Workspace

> **Single Source of Truth:** All comprehensive guidelines, procedures, templates, and scripts for this project are centralized in the [`.agents/`](../.agents) directory.

---

## 1. Project Context & Philosophy
This repository is a modular, high-quality LaTeX document authoring environment.
When assisting with LaTeX authoring, formatting, or compilation, adhere strictly to the rules defined in `.agents/`:

* **Code Style & Math:** Consult [`.agents/rules/coding-style.md`](../.agents/rules/coding-style.md) (2-space indentation, semantic line breaks, AMS math, `booktabs` tables with no vertical lines).
* **Architecture & Layout:** Consult [`.agents/rules/architecture.md`](../.agents/rules/architecture.md) (modular preambles, `preamble/`, `content/`, and `main.tex`).
* **Build & Testing:** Consult [`.agents/rules/testing.md`](../.agents/rules/testing.md) (`latexmk` commands, log triage, `chktex`).
* **Security:** Consult [`.agents/rules/security.md`](../.agents/rules/security.md) (no unrestricted `-shell-escape`, character escaping).

---

## 2. Workflows & Runbooks
* **Compilation & Diagnostics:** When asked to build or troubleshoot compilation issues, follow the procedure in [`.agents/workflows/sample-workflow.md`](../.agents/workflows/sample-workflow.md).
* **Logs Inspection:** If compilation fails, inspect `build/main.log` to identify the failure line (`l.<number>`).

---

## 3. Skills, Templates & Scripts
* **Templates:** Reusable document templates (article, report) are in [`.agents/skills/sample-skill/resources/templates/`](../.agents/skills/sample-skill/resources/templates/).
* **Package Guides:** Cheatsheets and common error manuals are in [`.agents/skills/sample-skill/references/`](../.agents/skills/sample-skill/references/).
* **Automation Scripts:** Pre-built PowerShell compilation and cleaning scripts are in [`.agents/skills/sample-skill/scripts/`](../.agents/skills/sample-skill/scripts/).

