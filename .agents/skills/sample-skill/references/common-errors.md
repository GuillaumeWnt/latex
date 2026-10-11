# Common LaTeX Errors & Diagnostics Guide

---

## 1. Syntax & Structural Errors

### `! Undefined control sequence`
- **Cause:** You used a macro that LaTeX does not recognize (typo in command name, or missing `\usepackage`).
- **Fix:** Check the line number indicated after `l.<line>`. Verify spelling or import the relevant package in `preamble/packages.tex`.

### `! LaTeX Error: \begin{env} on input line X ended by \end{other}`
- **Cause:** Mismatched environment delimiters or nested environments closed out of order.
- **Fix:** Trace the opening `\begin{...}` and ensure exact match with `\end{...}`.

### `! Missing $ inserted`
- **Cause:** Math-only command used in normal text (e.g. `_`, `^`, `\alpha`), or special character `_` unescaped in text mode.
- **Fix:** If mathematical, wrap in `$...$`. If literal underscore, write `\_`.

---

## 2. Layout & Formatting Warnings

### `Overfull \hbox (XXpt too wide) in paragraph at lines Y--Z`
- **Cause:** A word or equation could not be broken across lines and protrudes into the right margin.
- **Fix:**
  1. Add soft hyphenation to long words: `hy\-phen\-ation`.
  2. For display math, break into multiline environment (`align`, `multline`).
  3. Load `microtype` in preamble (often resolves subtle margin overflow automatically).

### `LaTeX Warning: There were undefined references`
- **Cause:** Cross-referencing labels are newly created or changed.
- **Fix:** Recompile. `latexmk` handles this automatically in multiple passes.

### `LaTeX Warning: Citation 'XYZ' on page P undefined`
- **Cause:** The citation key `XYZ` was not found in `bib/references.bib`, or Biber hasn't processed the `.bcf` file yet.
- **Fix:** Run `biber build/main` or recompile with `latexmk -pdf -outdir=build main.tex`.

