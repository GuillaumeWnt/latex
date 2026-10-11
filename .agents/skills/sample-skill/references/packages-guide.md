# Modern LaTeX Packages Cheatsheet

A curated list of recommended packages for professional typography and formatting.

---

## 1. Document Layout & Fonts
- **`geometry`**: Page dimensions and margins (`\usepackage[margin=2.5cm]{geometry}`).
- **`microtype`**: Subliminal typographical enhancements (character protrusion, font expansion).
- **`fancyhdr`**: Headers and footers customization.
- **`setspace`**: Line spacing (`\onehalfspacing`, `\doublespacing`).

---

## 2. Typography & Language
- **`babel` / `polyglossia`**: Multilingual support, hyphenation rules.
- **`csquotes`**: Context-sensitive quotations (`\enquote{...}`).
- **`siunitx`**: Standardized typesetting of units and quantities (`\qty{10}{\meter\per\second}`).

---

## 3. Mathematics
- **`amsmath`**: Standard AMS mathematical enhancements.
- **`amssymb`**: Extended symbol set.
- **`mathtools`**: Bugfixes and enhancements to `amsmath` (e.g. `\DeclarePairedDelimiter`).
- **`bm`**: Bold math symbols (`\bm{\alpha}`).

---

## 4. Tables & Figures
- **`booktabs`**: Publication-quality tables (`\toprule`, `\midrule`, `\bottomrule`).
- **`tabularx`**: Tables with auto-expanding columns (`X` column type).
- **`graphicx`**: Image inclusion (`\includegraphics[width=\linewidth]{...}`).
- **`subcaption`**: Multi-panel figures and sub-figures.
- **`xcolor`**: Advanced color management and mixing (`\usepackage{xcolor}`). Always load before `hyperref`.

---

## 5. Citations & References
- **`biblatex`**: Modern bibliography engine (pair with `biber`).
- **`hyperref`**: PDF hyperlinks, bookmarks, and document metadata.
- **`cleveref`**: Intelligent cross-referencing (`\cref`, `\Cref`). Always load after `hyperref`.

