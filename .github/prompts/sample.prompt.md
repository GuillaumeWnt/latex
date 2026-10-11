---
description: Review and format a LaTeX document following project guidelines
---

Review the currently active LaTeX file or selection against our workspace standards:

1. **Check Coding Style:**
   - Verify 2-space indentation inside environments.
   - Verify semantic line breaks (one sentence per line).
   - Ensure tables use `booktabs` (`\toprule`, `\midrule`, `\bottomrule`) with zero vertical bars.
   - Check that math uses proper AMS environments (`\[ ... \]`, `align`) and not `$$ ... $$`.
   - Ensure labels follow standard prefixes (`sec:`, `fig:`, `tab:`, `eq:`) and are referenced via `\cref{}`.

2. **Check Rules in `.agents/`:**
   - Refer to [.agents/rules/coding-style.md](../../.agents/rules/coding-style.md) for full style constraints.

Highlight any violations found and propose the corrected code.

