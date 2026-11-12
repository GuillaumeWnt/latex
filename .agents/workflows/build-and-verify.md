---
description: Compiler un projet LaTeX avec latexmk (LuaLaTeX), auditer le log et ChkTeX pour garantir zéro erreur et le minimum d'avertissements.
---

# Workflow : Compilation & Contrôle Zéro Erreur

À exécuter systématiquement après tout ajout ou modification significative de code LaTeX.

---

## Étapes d'exécution

1. **Audit syntaxique et typographique préalable :**
   ```powershell
   .\.agents\skills\latex-quality-auditor\scripts\lint-latex.ps1 -TargetDir "projets/<nom_projet>" -RunChkTeX
   ```
   - Corriger toute syntaxe obsolète (`{\bf}`, `$$`, filet vertical `|`, `\hline` brut) et traiter les avertissements `chktex` pertinents.

2. **Compilation complète (`latexmk` LuaLaTeX) :**
   ```powershell
   .\.agents\skills\latex-document-manager\scripts\compile.ps1 -ProjectDir "projets/<nom_projet>"
   ```

3. **Inspection rigoureuse de `build/main.log` :**
   - Vérifier **0 erreur fatale** (code de retour `0`, aucune ligne `! ...`).
   - Inspecter le résumé et rechercher les avertissements résiduels :
     - `Warning` (`scrlayer-scrpage`, `geometry`, `biblatex`, `hyperref`, `LaTeX Warning: Reference ... undefined`)
     - `WARN - ...` (Biber)
     - `Overfull \hbox` / `Overfull \vbox`
   - Corriger les causes racines jusqu'à obtenir un log propre (et **aucune** référence/citation indéfinie).

4. **Vérification de rétro-portage :**
   - Si un avertissement ou bug corrigé provenait d'un fichier socle (`mythesis.cls`, `config/*.sty`, `latexmkrc`, `.chktexrc`), appliquer aussi le correctif dans `templates/template_officiel/` et re-tester.
