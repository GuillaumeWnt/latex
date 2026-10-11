# Common LaTeX Errors & Diagnostics Guide

---

## 1. Syntax & Structural Errors

### `! Undefined control sequence`
- **Cause:** You used a macro that LaTeX does not recognize (typo in command name, or missing package).
- **Fix:** Check the line number indicated after `l.<line>`. Verify spelling or import the relevant package.

### `! Missing character: There is no → (U+2192) in font ...`
- **Cause:** A math symbol (like `\rightarrow`, `\alpha`, `\sum`) was used directly in text mode. When using OpenType text fonts via `fontspec`, text fonts lack math glyphs.
- **Fix:** Always wrap math symbols in math mode: `$\rightarrow$`.

### `! Package lua-ul Error: Color support in lua-ul requires luacolor.`
- **Cause:** `lua-ul` was used with color arguments without importing `luacolor`.
- **Fix:** Add `\RequirePackage{luacolor}` before loading `lua-ul`.

### `! Missing number, treated as zero. <to be read again> \group_end:`
- **Cause:** An internal TeX primitive counter (like `\year`) was passed as a unit name to `siunitx` (e.g. `\qtyrange{18}{65}{\year}`).
- **Fix:** Use standard unit abbreviations or plain text: `de 18 à 65~ans` or `\qtyrange{18}{65}{\kilo\gram}`.

---

## 2. Layout, Geometry & Warnings

### `Package scrlayer-scrpage Warning: \headheight to low. At least XXpt needed...`
- **Cause:** A `\newgeometry` or KOMA-Script setup defined a `headheight` smaller than the height of the font used in the header.
- **Fix:** Explicitly pass `headheight=26pt, footskip=30pt` to `\newgeometry` and in `\geometry{...}`.

### `Overfull \hbox (XXpt too wide) in paragraph at lines Y--Z`
- **Cause:** A line could not be hyphenated and protrudes into the margin.
- **Fix:**
  1. Add soft hyphens: `hy\-phen\-ation`.
  2. For URLs, load `xurl`.
  3. Load `microtype` in preamble.

### `LaTeX Warning: There were undefined references`
- **Cause:** Cross-referencing labels are newly created or changed.
- **Fix:** Recompile. `latexmk` handles this automatically in multiple passes.

### `LaTeX Warning: Citation 'XYZ' on page P undefined`
- **Cause:** The citation key was not found in `bib/references.bib`, or Biber hasn't processed the `.bcf` file yet.
- **Fix:** Recompile with `latexmk -lualatex -outdir=build main.tex` (or `biber build/main`).
