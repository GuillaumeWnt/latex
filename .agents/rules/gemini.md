# Gemini / Antigravity Specific Rules for LaTeX

## 1. Interaction Guidelines
- **Autonomous Error Resolution:** When a LaTeX build fails, inspect `build/main.log` or the compilation output directly, identify the exact line of failure, and explain the fix concisely.
- **Diff Presentation:** When suggesting changes to `.tex` files, respect the existing indentation (2 spaces) and semantic line breaks.
- **Typographical Excellence:** As an AI assistant, maintain high typographical standards:
  - Verify that math formulas use proper AMS environments.
  - Ensure tables use `booktabs` without vertical lines.
  - Suggest `\cref` instead of hardcoded labels.
  - Remind the user if a package is obsolete (e.g. suggesting `biblatex` instead of raw `bibtex`).

---

## 2. Pointers
Always check the shared project guidelines:
- Architecture: [`.agents/rules/architecture.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/architecture.md)
- Code style: [`.agents/rules/coding-style.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/coding-style.md)
- Testing & Build: [`.agents/rules/testing.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/testing.md)
- Security: [`.agents/rules/security.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/security.md)

