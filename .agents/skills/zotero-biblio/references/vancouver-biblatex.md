# Vancouver BibLaTeX Reference Guide

This guide describes how Vancouver numeric citation style is implemented and maintained in this workspace.

---

## 1. Preamble Configuration

In `ClasseGuillaume.cls` (or your document preamble):

```latex
\usepackage[
  backend=biber,
  style=vancouver,        % Numeric Vancouver format
  sorting=none,           % Citations numbered in order of appearance
  giveninits=true,        % Author initials instead of full first names
  maxcitenames=2,         % Inline citation limit
  maxbibnames=6,          % Bibliography author limit before 'et al.'
  doi=true,
  url=true,
  isbn=false
]{biblatex}

\addbibresource{bib/references.bib}
```

---

## 2. In-Text Citation Syntax

Always use non-breaking spaces `~` before citation commands:

| Command | Output | Example |
| :--- | :--- | :--- |
| `~\autocite{key}` | `(1)` or `[1]` depending on style | `Des études antérieures~\autocite{smith2024deep}...` |
| `~\cite{key}` | `1` | `Comme démontré par~\cite{smith2024deep}...` |
| `~\textcite{key}` | `Smith et al. (1)` | `D'après \textcite{smith2024deep}...` |

---

## 3. Formatting Clean `.bib` Entries

```bibtex
@article{smith2024deep,
  author       = {Smith, John and Doe, Jane},
  title        = {Deep Learning for Technical Document Analysis: A Systematic Review},
  journaltitle = {Journal of Computational Typography},
  year         = {2024},
  volume       = {12},
  number       = {3},
  pages        = {145--162},
  doi          = {10.1016/j.jct.2024.01.015},
  urldate      = {2024-05-10}
}
```

### Critical Rules:
1. **Title Capitalization:** Wrap abbreviations and proper nouns in braces (e.g., `{LaTeX}`, `{DNA}`).
2. **Author Format:** Always use `Lastname, Firstname and Lastname2, Firstname2`.
3. **DOIs:** Strip any `https://doi.org/` prefix; supply only the DOI identifier itself (`10.xxxx/...`).

