# KOMA-Script & Geometry Hybrid Architecture Guide

This guide explains how this repository combines **KOMA-Script** (`scrbook`) and **`geometry`** cleanly and without compilation warnings or layout anomalies.

---

## 1. Architectural Motivation

1. **Why start with KOMA-Script?**
   - KOMA-Script computes harmonic, typographically sound page proportions based on classical book design principles (medieval canon of page construction, `DIV`, `BCOR`).
   - It provides powerful document-level abstraction for headers, footers (`scrlayer-scrpage`), chapter headings, and margins.

2. **Why fix and override with `geometry`?**
   - Pure KOMA-Script recalculations (`\recalctypearea`) can be rigid when strict physical specifications are imposed (e.g., standard 2.5cm thesis margins, full-page clinical or architectural landscape attachments, or Word-style layouts).
   - `geometry` allows instant switching between page geometry presets mid-document (`\newgeometry` and `\restoregeometry`).

---

## 2. Best Practices & The Hybrid Synchronization Protocol

To prevent conflicts (`Package typearea Warning: Bad type area settings!`, `Package scrlayer-scrpage Warning: \headheight to small`, or misaligned headers after `\newgeometry`):

### Rule 1: Pass Base Layout Options Once Before `\LoadClass{scrbook}`
Never call `\KOMAoptions{fontsize=11pt, paper=a4, DIV=12}` or `\recalctypearea` *after* loading fonts or configuring `\geometry{...}`, as that triggers multiple `typearea` recalculations that overwrite `geometry`'s `footskip` and emit `Bad type area settings` warnings. Instead, pass them once before `\LoadClass`:
```latex
\PassOptionsToClass{
  fontsize=11pt,
  paper=a4,
  twoside=false,
  twocolumn=false,
  DIV=12,
  usegeometry=true
}{scrbook}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ProcessOptions\relax
\LoadClass{scrbook}
```

### Rule 2: Synchronize `scrlayer-scrpage` and KOMA `parskip` on Every `\newgeometry` / `\restoregeometry`
When `geometry` changes `\textwidth` and `\oddsidemargin` mid-document via `\newgeometry` or `\restoregeometry`, it does **not** automatically notify `scrlayer-scrpage` or KOMA's relative paragraph skip. Hook a synchronization macro into both commands using `etoolbox`:
```latex
\newcommand{\syncKomaGeometry}{%
  \csname par@updaterelative\endcsname
  \KOMAoptions{headwidth=text, footwidth=text}%
}
\apptocmd{\newgeometry}{\syncKomaGeometry}{}{}
\apptocmd{\restoregeometry}{\syncKomaGeometry}{}{}
```

### Rule 3: Explicitly Declare `headheight` and `footskip`
Always set `headheight=26pt` and `footskip=30pt` in `\geometry` and `\newgeometry` presets so `scrlayer-scrpage` headers never overflow.

---

## 3. Geometry Commands & `pageDesign` Environment in `ClasseGuillaume.cls`

1. **`\geometrieStandard` (Default Canonical Layout):**
   - Calls `\cleardoublepage\restoregeometry` and tracks `\renewcommand*{\currentGeometryCmd}{\geometrieStandard}`.
2. **`\geometrieWord`:**
   - Symmetric 2.5 cm margins with `marginparwidth=2.0cm, marginparsep=2.5mm` (leaving 2.5 mm safety clearance on the right edge for `\todoH` drop shadows).
3. **`\geometrieLarge`:**
   - Compact margins (`left=1.2cm, right=1.2cm, top=1.6cm, bottom=1.6cm`) for wide tables or syntheses.
4. **`\geometrieLibre{<geometry options>}`:**
   - Applies custom `geometry` parameters mid-document with automatic KOMA header/footer synchronization.
5. **`\begin{pageDesign}[<geometry options>] ... \end{pageDesign}`:**
   - Opens an isolated custom-designed page (`\thispagestyle{empty}`, `\masquerLogo`, custom margins) and automatically restores the previously active geometry (`\currentGeometryCmd`) and logo visibility at `\end{pageDesign}`.

