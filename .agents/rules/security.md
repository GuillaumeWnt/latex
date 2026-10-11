# LaTeX Security & Hygiene Guidelines

## 1. Shell Escape Policy (`-shell-escape`)
- **Default Rule:** Never execute LaTeX with `-shell-escape` enabled by default.
  - `-shell-escape` allows arbitrary system commands to be executed during compilation.
  - If a package strictly requires external tools (e.g. `minted` for Pygments or `tikz-externalize`):
    1. Prefer safer alternatives whenever possible (e.g., `listings` or `fvextra` without shell-escape).
    2. If required, use `-shell-restricted` instead of unrestricted `-shell-escape`.

---

## 2. Input Sanitization & Special Characters
When generating LaTeX code dynamically or importing external text, always ensure the following 10 reserved characters are properly escaped or handled:

| Character | Escape in Text | Purpose in LaTeX |
| :---: | :---: | :--- |
| `%` | `\%` | Line comment |
| `&` | `\&` | Table alignment |
| `_` | `\_` | Math subscript |
| `$` | `\$` | Math mode toggle |
| `#` | `\#` | Macro parameter |
| `{` `}` | `\{` `\}` | Grouping delimiter |
| `~` | `\textasciitilde{}` | Non-breaking space |
| `^` | `\textasciicircum{}` | Math superscript |
| `\` | `\textbackslash{}` | Macro escape symbol |

---

## 3. Sensitive Data & Bibliography Hygiene
- **No API keys or credentials in comments:** Do not put credentials, private tokens, or confidential reviewer notes in `%` comments. They can remain exposed in `.tex` or leak into PDF metadata.
- **Deduplicate `.bib` files:** Verify that private institutional fields (e.g., internal URLs, confidential preprint notes) are purged before sharing or publishing.
- **Sanitize PDF Metadata:** When configuring `hyperref`, check that author names, affiliations, and subjects in `\hypersetup{pdftitle=..., pdfauthor=...}` do not leak unwanted metadata.

