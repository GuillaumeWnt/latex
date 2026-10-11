# LaTeX Coding Style Guide

## 1. Syntax & Indentation
- **Indentation:** Use **2 spaces** inside all environments:
  ```latex
  \begin{itemize}
    \item Premier point
    \item Deuxième point
  \end{itemize}
  ```
- **Semantic Line Breaks:** Write **one sentence per line**.
  - Breaking lines at sentence boundaries dramatically improves Git diffs and eases review.
  - Never let lines stretch indefinitely.
- **Never use `\\` for paragraph breaks:** Leave a blank line instead. `\\` should only be used inside tables, matrices, or explicit multiline environments.

---

## 2. Mathematical Equations
- **AMS-LaTeX Conventions:** Always use `amsmath` and `mathtools`.
- **Display Math:**
  - Unnumbered: Use `\[ ... \]`. Never use `$$ ... $$`.
  - Numbered: Use `\begin{equation} ... \end{equation}`.
  - Multi-line aligned: Use `\begin{align} ... \end{align}` (or `align*`).
- **Operators & Units:**
  - Multi-letter functions must use `\operatorname{...}` or predefined operators (`\sin`, `\exp`, `\log`).
  - Text in math mode must use `\text{...}` or `\mathrm{...}`.
  - Mathematical constants (differential $d$, imaginary unit $i$, Euler $e$) should be formatted consistently (e.g. `\mathrm{d}x`).
- **Punctuation:** Display math is grammatically part of the sentence. End equations with a comma or period when sentence structure dictates it.

---

## 3. Labels and Cross-Referencing
- **Prefixed Labels:** Always use standardized prefixes:
  - `sec:` for sections (`\label{sec:introduction}`)
  - `fig:` for figures (`\label{fig:architecture}`)
  - `tab:` for tables (`\label{tab:results}`)
  - `eq:` for equations (`\label{eq:loss_function}`)
  - `lst:` for code listings (`\label{lst:main_script}`)
  - `thm:` / `def:` for theorems and definitions
- **Label Placement:** In floats (`figure`, `table`), always place `\label{...}` **after** `\caption{...}`. Placing it before causes incorrect numbering.
- **Smart References:** Prefer `\cref{fig:my_fig}` or `\Cref{sec:my_sec}` from `cleveref`. It automatically adds "Figure", "Section", etc.

---

## 4. Tables & Floats
- **Professional Tables with `booktabs`:**
  - Use `\toprule`, `\midrule`, and `\bottomrule`.
  - **Never use vertical lines** (`|`). Good typography avoids vertical grid lines.
  - Use `\centering` inside floats, never `\begin{center} ... \end{center}` (which adds unwanted vertical padding).
- **Float Placement:**
  - Default placement: `\begin{figure}[htbp]`. Avoid forcing `[H]` unless absolutely necessary.

