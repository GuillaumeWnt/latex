# Gemini / Antigravity Specific Rules for LaTeX

## 1. Interaction Guidelines
- **Autonomous Error Resolution:** When a LaTeX build fails, inspect `build/main.log` or the compilation output directly, identify the exact line of failure, and explain the fix concisely.
- **Diff Presentation:** When suggesting changes to `.tex` files, respect the existing indentation (2 spaces) and semantic line breaks.
- **Typographical Excellence:** As an AI assistant, maintain high typographical standards:
  - Verify that math formulas use proper AMS environments.
  - Ensure tables use `booktabs` without vertical lines.
  - Suggest `\cref` instead of hardcoded labels.
  - Remind the user if a package is obsolete (e.g. suggesting `biblatex` instead of raw `bibtex`).
- **Rule Flexibility & User Escalation:** If you wish to propose a solution or implement a feature that is hindered by an existing workspace rule that appears ill-adapted, explain the conflict to the user, propose adjusting or deleting the rule, and update the rule files upon agreement.

---

## 2. Pointers
Always check the shared project guidelines:
- Architecture: [`.agents/rules/architecture.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/architecture.md)
- Code style: [`.agents/rules/coding-style.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/coding-style.md)
- Testing & Build: [`.agents/rules/testing.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/testing.md)
- Security: [`.agents/rules/security.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/security.md)

