# Workflow: LaTeX Build, Verification & Diagnostics

This runbook describes the standard procedure for building a LaTeX document from source, verifying output quality, and diagnosing errors.

---

## Prerequisites
- A TeX distribution installed and accessible in the system PATH (`latexmk`, `lualatex`).
- Standard bibliography engine (`biber`).

---

## Procedure

### Step 1: Clean Temporary Build Cache (Optional)
If facing persistent cache corruption or font cache anomalies, purge the `build/` directory:
```powershell
latexmk -c -outdir=build
```

### Step 2: Execute Primary Compilation
Run `latexmk` targeting the master document with LuaLaTeX:
```powershell
latexmk -lualatex -outdir=build -interaction=nonstopmode -synctex=1 main.tex
```
*(Or run `.\scripts\compile.ps1` if using `templates/rapport-memoire/`)*.

### Step 3: Check Return Status & Log
- If compilation exits with code 0:
  - Verify that `build/main.pdf` exists and is non-empty.
  - Check `build/main.log` for any `LaTeX Warning:` lines regarding undefined references, missing figures, or citations.
- If compilation exits with a non-zero code:
  - Execute diagnostics (Step 4).

### Step 4: Diagnostic Triage
1. Read the last 50 lines of `build/main.log` to find the fatal error (`!`).
2. Identify the source file and line number:
   - Match `l.<number>` in the log file.
3. Check common culprits:
   - Unescaped `%`, `_`, `&`, or `#`.
   - Math symbol outside math mode (`\rightarrow` instead of `$\rightarrow$`).
   - Missing `luacolor` for `lua-ul`.
   - Font loading error in `fontspec`.
   - Missing `\end{...}` closing tag.
4. Apply the fix and re-run Step 2.
