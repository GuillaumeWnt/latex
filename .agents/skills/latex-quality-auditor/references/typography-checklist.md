# Publication Typography Checklist

This checklist must be consulted before tagging, archiving, or releasing any final LaTeX document.

---

## 1. Syntax & Macros
- [ ] **No obsolete font commands:** Zero occurrences of `{\bf`, `{\it`, `{\tt`, `{\sc`, `{\sl`. Always use `\textbf{}`, `\textit{}`, `\texttt{}`, `\textsc{}`.
- [ ] **Modern Display Math:** Zero occurrences of `$$ ... $$`. Always use `\[ ... \]`, `equation`, `align`, or `gather`.
- [ ] **Semantic Line Breaks:** Text is written with one sentence or major clause per line, optimizing Git diffs.
- [ ] **Math Mode for Symbols:** Arrows (`\rightarrow`, `\Leftarrow`), Greek letters, and comparison operators are strictly inside math mode delimiters (e.g. `$\rightarrow$`).

---

## 2. Punctuation & Non-Breaking Spaces
- [ ] **Citations:** Non-breaking space `~` precedes all citations (`~\autocite{...}`, `~\cite{...}`).
- [ ] **Cross-references:** Non-breaking space `~` precedes all cross-references (`~\cref{...}`, `~\Cref{...}`).
- [ ] **Units & Numbers:** Standard spacing before units using `siunitx` macros: `\SI{25}{\celsius}`, `\qty{10}{\percent}`, `10\,\%`.
- [ ] **Quotation marks:** Proper LaTeX quotation marks (French `\og ... \fg{}` or English `\`\`...''`), never straight typewriter quotes (`"..."`).

---

## 3. Tables & Floats
- [ ] **No vertical lines:** No table contains `|` in column specifications.
- [ ] **Booktabs rules:** Every table uses `\toprule`, `\midrule`, `\bottomrule`.
- [ ] **Float positioning:** All floats use sensible placement specifiers (e.g., `[htbp]`).
- [ ] **Captions and Labels:** Every table and figure has a descriptive `\caption{}` and `\label{tab:...}` / `\label{fig:...}`.

---

## 4. Margin Notes & Review Tags
- [ ] In final publication mode, all `\todoH{...}` notes are either resolved or review mode is disabled so no draft margin notes appear in the compiled PDF.
- [ ] When review mode is active, notes do not overflow printable paper edges.

