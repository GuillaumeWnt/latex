# AGENTS.md — Global Directives for AI Agents

> **Project Purpose:** Professional, modular, and high-quality LaTeX authoring workspace.
> **Scope:** These directives apply to all AI coding assistants (Google Antigravity, Claude, GitHub Copilot, OpenAI Operator, etc.).

---

## 1. Core Principles

1. **Separation of Concerns:**
   - Keep document styling, font configurations, and package preambles strictly separate from text content.
   - Content belongs in dedicated modular files (`content/` or `chapters/`), included via `\input{}` or `\include{}`.
   - Document structure and styling belong in `preamble/` (or custom `.sty`/`.cls` files).

2. **Modern LaTeX Standards (No Obsolete Packages/Syntax):**
   - **Never** use obsolete font commands like `{\bf ...}`, `{\it ...}`, or `{\tt ...}`. Always use `\textbf{...}`, `\textit{...}`, `\texttt{...}` or `\emph{...}`.
   - **Never** use `$$ ... $$` for display math. Always use `\[ ... \]` or AMS environments (`equation`, `align`, `gather`).
   - Use `biblatex` with `biber` backend for citations; avoid legacy `bibtex` unless explicitly requested.
   - For tables, use `booktabs` (`\toprule`, `\midrule`, `\bottomrule`) and **never** use vertical lines (`|`).
   - For cross-referencing, prefer `cleveref` (`\cref{}`, `\Cref{}`) over manual "figure \ref{}".

3. **Compilation Workflow:**
   - Always prioritize `latexmk` for compilation (`latexmk -pdf` or `latexmk -lualatex`).
   - Compilation artifacts (`.aux`, `.log`, `.toc`, etc.) should be routed to an output directory (e.g., `-outdir=build`) whenever possible.
   - Never commit or edit auxiliary compilation files.

4. **Git-Friendly Formatting:**
   - Adopt **semantic line breaks** (one sentence or clause per line). This minimizes Git merge conflicts and makes diffs readable.
   - Maintain a 2-space indentation inside environments (`\begin{...}` ... `\end{...}`).

5. **Rule Adaptability & Escalation to User (Feedback Loop):**
   - If an AI agent encounters a situation where an existing rule, constraint, or guideline in this workspace is ill-adapted, overly rigid, contradictory, or preventing the best technical outcome:
     - **Never ignore or bypass the rule silently.**
     - **Escalate the issue to the user immediately:** explain clearly why the rule is problematic or ill-adapted in the current context, and suggest modifying or removing it.
     - **Update/remove the rule upon agreement:** with the user's validation, edit the relevant rule file in `.agents/rules/` or `AGENTS.md` so that the documentation stays living, pragmatic, and aligned with real project needs.

6. **Templates Ecosystem (`templates/`) & Evolution Freedom:**
   - **`template_principal` as Foundation:** Le répertoire `templates/template_principal/` constitue le modèle de référence principal et pérenne sur lequel s'appuyer en priorité (architecture modulaire, `ClasseGuillaume.cls`, compilation LuaLaTeX).
   - **Modularité et extensibilité :** Le répertoire `templates/` contient plusieurs templates adaptés à divers types de livrables. L'utilisateur peut en ajouter de nouveaux librement. Les agents doivent explorer dynamiquement le dossier `templates/` pour trouver des modèles adaptés au besoin sans dépendre d'une liste fixe de noms.
   - **Liberté d'optimisation & ajout de packages :** Ces templates ne sont pas tous parvenus à un stade optimal. Les agents ont pleine autorisation de s'écarter de pratiques obsolètes ou sous-optimales présentes dans certains modèles, de moderniser la syntaxe et d'ajouter de nouveaux packages pertinents selon les exigences du projet.

## 2. Directory Navigation for Agents

Refer to the following `.agents/` resources when working on this repository:

| Path | Purpose | When to consult |
| :--- | :--- | :--- |
| [`.agents/rules/architecture.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/architecture.md) | Standard document tree, file breakdown & templates | When creating or organizing documents |
| [`.agents/rules/coding-style.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/coding-style.md) | Formatting rules, math, tables, floats, labels | When drafting or editing LaTeX source code |
| [`.agents/rules/testing.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/testing.md) | Compilation commands, linters, diagnostics | When building or debugging compile errors |
| [`.agents/rules/security.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/security.md) | `-shell-escape` restrictions, data hygiene | When executing scripts or adding tools |
| [`.agents/workflows/`](file:///c:/Users/guill/dev/perso/latex/general/.agents/workflows) | Step-by-step procedures (clean build, release) | When executing multi-step operations |
| [`.agents/skills/`](file:///c:/Users/guill/dev/perso/latex/general/.agents/skills) | Reusable skills, templates, scripts & cheatsheets | On demand for specialized workflows |
| [`.agents/subagents/`](file:///c:/Users/guill/dev/perso/latex/general/.agents/subagents) | Specialized subagent roles (biblio, diagrams, QA, compiler, memory & web research) | When delegating focused domain tasks |

