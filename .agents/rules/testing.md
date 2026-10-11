# LaTeX Compilation, Testing & Quality Verification

## 1. Compilation Commands

### Primary Build Tool: `latexmk`
Always favor `latexmk` as it automatically tracks dependencies, runs BibTeX/Biber, updates cross-references, and re-compiles the exact number of times required.

```powershell
# Standard PDFLaTeX compilation with output directory
latexmk -pdf -outdir=build -interaction=nonstopmode -synctex=1 main.tex

# LuaLaTeX compilation (recommended for modern fonts & microtype)
latexmk -lualatex -outdir=build -interaction=nonstopmode -synctex=1 main.tex

# Continuous compilation (watch mode)
latexmk -pdf -outdir=build -pvc -interaction=nonstopmode main.tex
```

### Clean Commands
```powershell
# Remove temporary files but keep final PDF
latexmk -c -outdir=build

# Full purge (removes temporary files AND output PDF)
latexmk -C -outdir=build
```

---

## 2. Analyzing the Compilation Log (`build/main.log`)

When troubleshooting a compilation failure, agents must inspect `build/main.log`:

1. **Fatal Errors (`! LaTeX Error:` / `! Undefined control sequence`):**
   - Look for the exact line number reported just above or below the `!` marker.
   - Check for mismatched braces (`{}`), unescaped special characters (`_`, `%`, `&`), or missing packages.
2. **Undefined References / Citations:**
   - `LaTeX Warning: There were undefined references.` -> Cross-references require another run.
   - `LaTeX Warning: Citation '...' on page X undefined.` -> Biber must be run, or citation key is missing in `.bib`.
3. **Overfull / Underfull `\hbox`:**
   - `Overfull \hbox (XXpt too wide)` means text or math exceeds the text margin.
   - Remedies: Add optional hyphens (`\-`), rephrase slightly, or enclose math inside an alignment or smaller environment.

---

## 3. Linting and Static Analysis

- **ChkTeX:**
  Run `chktex` to detect common typographical errors (e.g., missing non-breaking spaces before `\cite`, space before punctuation, incorrect quotes):
  ```powershell
  chktex -q -v0 main.tex
  ```
- **Code Formatter (`latexindent`):**
  Format `.tex` files with consistent indentation:
  ```powershell
  latexindent -w -s main.tex
  ```

