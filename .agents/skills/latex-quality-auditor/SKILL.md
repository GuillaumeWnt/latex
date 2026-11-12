---
name: latex-quality-auditor
description: >-
  Utiliser ce skill pour auditer la qualité typographique LaTeX, moderniser les tableaux
  (booktabs/tabularx), exécuter ChkTeX / lint-latex.ps1 et vérifier le log de compilation.
---

# Skill : Audit Typographique & Qualité LaTeX

Boîte à outils pour vérifier la conformité des sources `.tex` aux standards du dépôt et réduire erreurs et avertissements au minimum.

---

## 1. Contrôle Automatisé (`lint-latex.ps1` + `chktex`)

```powershell
# Audit statique seul :
.\.agents\skills\latex-quality-auditor\scripts\lint-latex.ps1 -TargetDir "projets\<nom_projet>"

# Audit statique + ChkTeX (utilise le .chktexrc du projet) :
.\.agents\skills\latex-quality-auditor\scripts\lint-latex.ps1 -TargetDir "projets\<nom_projet>" -RunChkTeX
```

Le script détecte :
- Commandes de police obsolètes (`{\bf`, `{\it`, `{\tt}`, etc.) et maths `$$ ... $$`.
- Filets verticaux `|` et `\hline` dans les tableaux.
- Oublis d'espace insécable `~` avant les citations (`\parencite`, `\textcite`, `\cite`, etc.) et renvois (`\cref`, `\Cref`, `\cpageref`).
- Usage manuel de `\ref{}` au lieu de `\cref{}` / `\Cref{}`.
- Sauts de paragraphe via `\\` hors environnements tabulaires/mathématiques.
- `\caption{...}` sans `\label{...}` associé.

---

## 2. Documentation de Référence

- **[Liste de Contrôle Typographique](./references/typography-checklist.md) :** Points de vérification avant livraison (syntaxe, `~`, `siunitx` v3, flottants, notes `\todoH` et zéro avertissement).
- **[Guide de Conversion de Tableaux](./references/table-conversion-guide.md) :** Recettes avant/après vers `booktabs` + `tabularx` (`L`, `C`, `R`, `Y`).
