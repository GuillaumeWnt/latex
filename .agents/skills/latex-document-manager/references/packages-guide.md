# Modern LaTeX Packages Cheatsheet

A curated list of recommended packages for professional typography and formatting in this workspace.

---

## 1. Document Layout, Geometry & Headings
- **`scrlayer-scrpage`**: Standard headers and footers customization for KOMA-Script (`\ohead`, `\ihead`, `\lehead`). Replaces obsolete `fancyhdr`.
- **`geometry`**: Fine-grained page dimensions and dynamic layout switches (`\geometrieWord`, `\geometrieLarge`, `\restoregeometry`). Always specify `headheight=26pt, footskip=30pt` when used with KOMA.
- **`setspace`**: Line spacing control (`\singlespacing`, `\onehalfspacing`, `\doublespacing`).
- **`microtype`**: Subliminal typographical enhancements (character protrusion, font expansion).

---

## 2. Fonts, Typography & Language (LuaLaTeX)
- **`fontspec`**: Advanced font loading for OpenType and TrueType fonts under LuaLaTeX.
- **`unicode-math`**: Unicode mathematics fonts (`\setmathfont{XITS Math}`).
- **`luacolor` & `lua-ul`**: Safe text underlining (`\underLine`) and background highlighting (`\highLight`) preserving hyphenation and UTF-8 accents.
- **`babel`**: Multilingual support (`\frenchsetup{StandardLists=true}`).
- **`csquotes`**: Context-sensitive quotations (`\enquote{...}`).
- **`siunitx`**: Standardized typesetting of units and quantities (`\qty{10}{\meter\per\second}`).

---

## 3. Mathematics
- **`amsmath`**: Standard AMS mathematical enhancements.
- **`mathtools`**: Bugfixes and enhancements to `amsmath` (e.g. `\DeclarePairedDelimiter`).

---

## 4. Tables, Figures & Visual Boxes
- **`booktabs`**: Publication-quality tables (`\toprule`, `\midrule`, `\bottomrule`). Never use vertical lines (`|`).
- **`tabularx`**: Tables with auto-expanding columns (`X` column type).
- **`graphicx`**: Image inclusion (`\includegraphics[width=\linewidth]{...}`).
- **`subcaption`**: Multi-panel figures and sub-figures.
- **`tcolorbox`**: Modern styled boxes and decorated frames (`\begin{cadreFigure}`, `\begin{boiteSynthese}`).
- **`pdfpages`**: Multi-page PDF insertion for appendix attachments (`\includepdf`).

---

## 5. Review Notes & Hyperlinks
- **`todonotes`**: Margin notes and revision management.
- **`pdfcomment`**: Tooltips on hover in PDF (`\pdftooltip`).
- **`xurl`**: Automatic URL line-breaking across margins and notes.
- **`hyperref`**: PDF hyperlinks, bookmarks, and document metadata.
- **`cleveref`**: Intelligent cross-referencing (`\cref`, `\Cref`, `\cpageref`). Always load after `hyperref`.
- **`biblatex`**: Modern bibliography engine (paired with `biber`).
