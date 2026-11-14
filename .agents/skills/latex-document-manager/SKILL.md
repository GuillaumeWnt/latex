---
name: latex-document-manager
description: >-
  Utiliser ce skill pour créer un projet depuis templates/template_officiel/, structurer ou compiler
  des documents LaTeX sous LuaLaTeX, gérer KOMA-Script + geometry et rétroporter les améliorations.
---

# Skill : Gestionnaire de Documents LaTeX (`template_officiel`)

Workflow opérationnel pour initialiser, configurer, compiler et déboguer des projets LaTeX modulaires basés sur [`templates/template_officiel/`](../../../templates/template_officiel/README.md).

---

## 1. Initialisation & Rétroportage

1. **Créer un projet :** Copier [`templates/template_officiel/`](../../../templates/template_officiel/) (sans `build/`) vers `projets/<nom_projet>/`.
2. **Rétroportage :** Toute amélioration générique (`ClasseGuillaume.cls`, `.clo`, `config/packages.sty`, `config/macros.sty`, `latexmkrc`, `.chktexrc`) ou correction de bug réalisée dans un projet doit également être reportée dans `templates/template_officiel/`.

---

## 2. Scripts Rapides (`scripts/`)

- [`scripts/compile.ps1`](./scripts/compile.ps1) : Compile un document via `latexmk` (LuaLaTeX + `build/`) et résume les erreurs et avertissements du `.log`.
  ```powershell
  .\.agents\skills\latex-document-manager\scripts\compile.ps1 -ProjectDir "projets\<nom_projet>"
  ```
- [`scripts/clean.ps1`](./scripts/clean.ps1) : Nettoie les fichiers intermédiaires jetables dans `build/` tout en **préservant le `.pdf` généré ainsi que `.synctex.gz`, `.log`, `.blg`, `.fdb_latexmk` et `.fls`** (`-All` pour une purge complète avant compilation à froid).

---

## 3. Documentation de Référence

- **[Guide KOMA-Script & Geometry](./references/koma-geometry-guide.md) :** Synchronisation `scrbook` + `geometry`, gestion de `\ClasseGuillaume@bcor`, `pageDesign` et profils de marges.
- **[Guide des Packages Modernes](./references/packages-guide.md) :** Inventaire aligné sur `config/packages.sty` (`fontspec`, `lua-ul`, `siunitx` v3, `biblatex`, `cleveref`, `ocgx2`).
- **[Erreurs Courantes & Diagnostics](./references/common-errors.md) :** Résolution rapide des erreurs LuaLaTeX, `fontspec`, `headheight`, `siunitx` et Biber.
- **[Exemples Prêts à l'Emploi](./examples/snippets.tex) :** Tableaux `booktabs`/`tabularx`, équations `align` et figures `tcolorbox`.
