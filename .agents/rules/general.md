# General LaTeX Rules & Core Philosophy

## 1. Project Philosophy
- **Modular Design:** Documents must be broken down into logically independent modules rather than compiled as monolithic single `.tex` files.
- **Separation of Presentation and Content:**
  - Content files (`chapters/` or `content/`) must focus on semantic text, sections, and mathematics.
  - Formatting macros, geometry, font definitions, and package configurations belong in dedicated `.cls` classes or `preamble/`.
- **Reproducibility:** A clean clone of this repository should build deterministically using standard TeX distributions (TeX Live, MiKTeX) via `latexmk`.
- **Templates Ecosystem & Evolution:** The primary reference template is `templates/template_principal/`. Other templates are located in `templates/` (and new ones may be added dynamically). Because existing templates may not all be optimal yet, agents are explicitly empowered to deviate from suboptimal practices found within them and introduce additional modern packages or refactorings whenever beneficial.

---

## 2. Page Geometry & KOMA-Script + Geometry Hybrid Rules

The repository standardizes on a controlled hybrid approach when using KOMA-Script (`scrbook`):

1. **Initial Proportions with KOMA-Script:**
   - KOMA-Script establishes typographic proportions via `DIV` and `BCOR`.
   - **Requirement:** Always specify `usegeometry=true` in `\KOMAoptions` so KOMA informs `geometry` of its calculations.
2. **Explicit Adjustments via `geometry`:**
   - Loading `\RequirePackage{geometry}` enables explicit geometry profiles (`\geometrieWord`, `\geometrieLarge`, `\geometrieStandard`).
   - **Crucial Rule:** Any geometry switch (`\newgeometry`) **must explicitly define `headheight` and `footskip`** (e.g. `headheight=26pt, footskip=30pt`) matching the font size and `scrlayer-scrpage` requirements. Omitting `headheight` causes severe `Overfull \vbox` warnings.
   - **Page Break Rule:** Always prefix geometry switches and restorations with `\cleardoublepage` (or `\clearpage`) to avoid geometry collisions on the same physical page.

---

## 3. Package Management & Compilation Engines

- **Compilation Engine Policy:**
  - If using OpenType/TrueType fonts (`fontspec`, `unicode-math`) or Lua-based underlining (`lua-ul`), the required compilation engine is **LuaLaTeX** (`latexmk -lualatex`).
- **Load Order Matters:**
  - `hyperref` should generally be loaded almost last.
  - `xurl` should be loaded before or with `hyperref` to enable proper URL line-breaking in margin notes and bibliographies.
  - `cleveref` must be loaded **after** `hyperref`.
- **Avoid Obsolete / Conflicting Packages:**
  - Do NOT use legacy `soul` with LuaLaTeX for highlighting; use `lua-ul` with `luacolor` (`\highLight`) to avoid UTF-8 accent corruption.
  - Do NOT use `frenchbsetup`; use modern `\frenchsetup{StandardLists=true}`.
  - Do NOT use `fancyhdr` with KOMA-Script classes; use `scrlayer-scrpage`.
  - Do NOT use `subfig` or legacy `subfigure`; standardize on `subcaption`.

---

## 4. Typographical Standards

- **Quotes:** Use `csquotes` and `\enquote{text}` instead of manual backticks and single quotes.
- **Dashes:** Respect standard typographical rules:
  - `-` for hyphens (e.g., *state-of-the-art*).
  - `--` for en-dashes / ranges (e.g., *pages 12--15*).
  - `---` for em-dashes (parenthetical thoughts).
- **Non-breaking Spaces (`~`):**
  - Always use `~` before citations (`\cite{...}` or `\parencite{...}`).
  - Always use `~` before cross-references (`\ref{...}` or `\cref{...}`).
  - Use `~` or `siunitx` macros (`\qty{10}{\kilo\gram}`) between numbers and units.
- **Math Mode Purity:**
  - Mathematical symbols (e.g. `\rightarrow`) must ALWAYS be inside math mode (`$\rightarrow$`). Never place them directly in text mode.
