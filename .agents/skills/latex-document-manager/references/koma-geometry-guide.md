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

## 2. Best Practices & The Hybrid Protocol

To prevent conflicts and avoid the infamous warning `Package scrlayer-scrpage Warning: \headheight to small`:

### Rule 1: Always pass `usegeometry=true` to the Document Class
When loading KOMA-Script in `ClasseGuillaume.cls`:
```latex
\LoadClass[
  11pt,
  a4paper,
  oneside,
  usegeometry=true,      % Tells KOMA to delegate geometry calculations cleanly
  parskip=half-
]{scrbook}
```

### Rule 2: Explicitly declare `headheight` and `footskip` in all Geometry macros
Whenever `\newgeometry` or `\geometry` is configured, always include explicit values:
```latex
\newgeometry{
  top=2.5cm,
  bottom=2.5cm,
  left=2.5cm,
  right=2.5cm,
  headheight=26pt,       % Prevents scrlayer-scrpage header collision
  footskip=30pt
}
```

---

## 3. Predefined Geometry Presets in `ClasseGuillaume.cls`

1. **Default Document Layout:**
   - Balanced academic proportions with room for margin notes (`\todoH`) when in draft mode.
2. **`\geometrieWord`:**
   - Standard 2.5 cm margins all around:
   ```latex
   \newcommand{\geometrieWord}{%
     \newgeometry{top=2.5cm, bottom=2.5cm, left=2.5cm, right=2.5cm, headheight=26pt, footskip=30pt}%
   }
   ```
3. **`\geometrieLarge`:**
   - Narrower 1.5 cm margins for dense technical appendices, large data tables, or wide figures:
   ```latex
   \newcommand{\geometrieLarge}{%
     \newgeometry{top=1.5cm, bottom=1.5cm, left=1.5cm, right=1.5cm, headheight=26pt, footskip=30pt}%
   }
   ```
4. **Returning to Default:**
   - Always call `\restoregeometry` at the conclusion of a custom section.

