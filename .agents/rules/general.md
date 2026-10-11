# General LaTeX Rules & Core Philosophy

## 1. Project Philosophy
- **Modular Design:** Documents must be broken down into logically independent modules rather than compiled as monolithic single `.tex` files.
- **Separation of Presentation and Content:**
  - Content files (`content/` or `chapters/`) must focus on semantic text, sections, and mathematics.
  - Formatting macros, geometry, font definitions, and package configurations belong in `preamble/`.
- **Reproducibility:** A clean clone of this repository should build deterministically using standard TeX distributions (TeX Live, MacTeX, MiKTeX) or via `latexmk`.

---

## 2. Package Management Guidelines
- **Import Once:** Always declare packages in `preamble/packages.tex`, never inside content files.
- **Load Order Matters:**
  - `hyperref` should generally be loaded almost last (except for packages explicitly requiring loading after it, like `cleveref`, `bookmark`, `geometry` when needed, or `autonum`).
  - `cleveref` must be loaded **after** `hyperref`.
- **Avoid Obsolete / Conflicting Packages:**
  - Do NOT use `a4wide` or `geometry` together with hardcoded page dimensions. Use `geometry` exclusively.
  - Do NOT use `epsfig` (use `graphicx`).
  - Do NOT use `subcaption` and `subfig` or `subfigure` simultaneously. Standardize on `subcaption`.
  - Do NOT use `times`, `palatino`, or `mathptmx` directly without modern unicode/math font packages.

---

## 3. Typographical Standards
- **Quotes:** Use `csquotes` and `\enquote{text}` instead of manual backticks and single quotes.
- **Dashes:** Respect standard typographical rules:
  - `-` for hyphens (e.g., *state-of-the-art*).
  - `--` for en-dashes / ranges (e.g., *pages 12--15*).
  - `---` for em-dashes (parenthetical thoughts).
- **Non-breaking Spaces (`~`):**
  - Always use `~` before citations (`\cite{...}` or `\parencite{...}`).
  - Always use `~` before cross-references (`\ref{...}` or `\cref{...}`).
  - Use `~` between numbers and units (e.g., `$10$\,\mathrm{kg}` or `\SI{10}{\kilo\gram}`).

