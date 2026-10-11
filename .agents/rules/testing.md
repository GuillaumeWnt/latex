# LaTeX Compilation, Testing & Quality Verification

## 1. Compilation Commands

### Primary Build Engine: LuaLaTeX via `latexmk`
Because this repository standardizes on modern typography (`fontspec`, `unicode-math`, `lua-ul`), **LuaLaTeX** is the primary compilation engine:

```powershell
# Recommended: LuaLaTeX compilation with output directory
latexmk -lualatex -outdir=build -interaction=nonstopmode -synctex=1 main.tex

# Or via the template's dedicated PowerShell script:
.\scripts\compile.ps1

# Continuous compilation (watch mode)
latexmk -lualatex -outdir=build -pvc -interaction=nonstopmode main.tex
```

### Clean Commands
```powershell
# Remove temporary files but keep final PDF
latexmk -c -outdir=build
# Or: .\scripts\clean.ps1

# Full purge (removes temporary files AND output PDF)
latexmk -C -outdir=build
# Or: .\scripts\clean.ps1 -All
```

---

## 2. Analyzing the Compilation Log (`build/main.log`)

When troubleshooting a compilation failure, agents must inspect `build/main.log`:

1. **Fatal Errors (`! LaTeX Error:` / `! Undefined control sequence`):**
   - Check the exact line number reported just above or below the `!` marker (`l.<line>`).
   - Mismatched braces (`{}`), unescaped characters (`_`, `%`, `&`), or missing packages.
2. **Missing Glyphs (`Missing character: There is no X in font...`):**
   - A mathematical operator (e.g. `\rightarrow`) was written in text mode. Wrap it in math mode (`$\rightarrow$`).
3. **Header/Footer Dimension Warnings (`scrlayer-scrpage Warning: \headheight to low`):**
   - A `\newgeometry` call omitted `headheight` or `footskip`. Ensure `headheight=26pt` and `footskip=30pt` are specified.
4. **Fontspec File Embedding Errors (`! error: (file ) (type 2): cannot find file ''`):**
   - A font was defined with an empty filename or an invalid path in `fontspec`. Check that font paths point to existing TTF/OTF files.
5. **Undefined References / Citations:**
   - `LaTeX Warning: There were undefined references.` -> Cross-references require another run.
   - `LaTeX Warning: Citation '...' on page X undefined.` -> Biber must be run, or citation key is missing in `.bib`.

---

## 3. Linting and Static Analysis

- **ChkTeX:**
  ```powershell
  chktex -q -v0 main.tex
  ```
- **Code Formatter (`latexindent`):**
  ```powershell
  latexindent -w -s main.tex
  ```
