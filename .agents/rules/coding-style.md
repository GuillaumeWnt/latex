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
- **Run-in Paragraph Headings:**
  - When structuring points without full subsubsections, use `\paragraph{Critère}`:
    ```latex
    \paragraph{Critère d'évaluation} Le texte démarre directement sur la même ligne...
    ```

---

## 2. Mathematical Equations
- **AMS-LaTeX Conventions:** Always use `amsmath` and `mathtools`.
- **Display Math:**
  - Unnumbered: Use `\[ ... \]`. Never use `$$ ... $$`.
  - Numbered: Use `\begin{equation} ... \end{equation}`.
  - Multi-line aligned: Use `\begin{align} ... \end{align}` (or `align*`).
- **Operators & Units:**
  - Multi-letter functions must use `\operatorname{...}` or predefined operators (`\sin`, `\exp`, `\log`).
  - Units and physical quantities must use `siunitx` v3 (`\qty{25}{\meter\per\second}`, `\qtyrange{10}{20}{\kilo\gram}`).
  - Mathematical constants (differential $d$, imaginary unit $i$, Euler $e$) should be formatted consistently (e.g. `\mathrm{d}x`).
- **Punctuation:** Display math is grammatically part of the sentence. End equations with a comma or period when sentence structure dictates it.

---

## 3. Labels and Cross-Referencing
- **Prefixed Labels:** Always use standardized prefixes:
  - `chap:` for chapters (`\label{chap:fondements}`)
  - `sec:` for sections (`\label{sec:introduction}`)
  - `fig:` for figures (`\label{fig:architecture}`)
  - `ill:` for custom illustrations (`\label{ill:schema_conceptuel}`)
  - `tab:` for tables (`\label{tab:results}`)
  - `eq:` for equations (`\label{eq:loss_function}`)
  - `annexe:` for appendices (`\label{annexe:justificatifs}`)
- **Label Placement:** In floats (`figure`, `table`, `illustration`), always place `\label{...}` **after** `\caption{...}`.
- **Smart References (`cleveref`):**
  - Use `\cref{fig:my_fig}` or `\Cref{sec:my_sec}`.
  - Use `\cpageref{tab:my_tab}` to automatically generate page references ("à la page X").

---

## 4. Tables, Floats & Visual Boxes
- **Professional Tables with `booktabs` + `tabularx`:**
  - Use `\toprule`, `\midrule`, and `\bottomrule`.
  - **Never use vertical lines** (`|`).
  - Use compact lists inside cells: `\begin{itemize}[nosep, leftmargin=*]`.
- **Float Placement:**
  - Default placement: `\begin{figure}[htbp]` or `\begin{table}[htbp]`. Avoid forcing `[H]` unless absolutely necessary.
  - Custom illustrations use `\begin{illustration}[htbp]` and register into `\listofillustrations`.
- **Visual Boxes (`tcolorbox`):**
  - For image frames, use `\begin{cadreFigure} ... \end{cadreFigure}`.
  - For callouts/summaries, use `\begin{boiteSynthese}{Titre} ... \end{boiteSynthese}`.

---

## 5. Review Notes & Highlighting
- Use `\todoH{Style}{Couleur}{Commentaire}{Texte concerné}`.
  - Comments longer than 30 characters are automatically truncated in the margin with an interactive tooltip on hover.
  - Clicking highlighted text returns to `\label{table_todos}` in the frontmatter.
