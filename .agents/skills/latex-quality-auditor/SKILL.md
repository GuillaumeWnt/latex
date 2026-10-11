---
name: latex-quality-auditor
description: >-
  Use this skill when auditing LaTeX documents for publication quality, typographical compliance,
  table modernization (booktabs/tabularx), semantic line breaks, and eliminating obsolete syntax.
---

# LaTeX Quality Assurance & Typographical Auditor Skill

This skill provides checklists, transformation recipes, and automated linter scripts to ensure LaTeX source code complies with the highest academic and typographical standards.

---

## 1. Fast Workflows

### Run the Automated LaTeX Linter
Audit all `.tex` files in a directory or template:
```powershell
.\.agents\skills\latex-quality-auditor\scripts\lint-latex.ps1 -TargetDir "content"
```
The script flags:
- Obsolete font commands (`{\bf`, `{\it`, `{\tt}`).
- Display math using `$$ ... $$` instead of `\[ ... \]`.
- Hardcoded vertical lines `|` in `tabular` / `tabularx`.
- Missing non-breaking spaces `~` before `\cite{}` and `\cref{}`.
- Unescaped arrows outside math mode (`\rightarrow` instead of `$\rightarrow$`).

### Table Modernization Workflow
1. Identify legacy `tabular` blocks containing `|` and `\hline`.
2. Follow the [Table Conversion Guide](./references/table-conversion-guide.md) to migrate to `booktabs` (`\toprule`, `\midrule`, `\bottomrule`) and `tabularx`.
3. Add `siunitx` alignment for numerical columns (`S` column type).

---

## 2. Reference Documentation
- **[Publication Typography Checklist](./references/typography-checklist.md):** Exhaustive rules for French/English academic typography, punctuation, math expressions, and margin notes.
- **[Table Conversion Guide](./references/table-conversion-guide.md):** Step-by-step before/after recipes for modernizing LaTeX tables.

---

## 3. Automation Scripts
- **[Lint Script (`lint-latex.ps1`)](./scripts/lint-latex.ps1):** PowerShell script executing static analysis across `.tex` files.

