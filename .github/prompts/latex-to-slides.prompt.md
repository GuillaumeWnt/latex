---
mode: agent
description: Générer un diaporama LaTeX moderne (ClasseGuillaumeSlides) à partir d'un projet LaTeX interne ou d'un document .tex/.pdf externe.
---

Génère une présentation LaTeX moderne, éditoriale et synthétique (format 16:9) à partir du document source indiqué.

Applique strictement :
1. Les règles visuelles, options de classe et macros de [`.agents/skills/latex-slides/SKILL.md`](../../.agents/skills/latex-slides/SKILL.md) ainsi que le guide [`document-to-slides-guide.md`](../../.agents/skills/latex-slides/references/document-to-slides-guide.md).
2. Le placement adéquat :
   - Document interne `projets/<nom_projet>/` → travailler dans `projets/<nom_projet>/slides/` (mode `integrated`, réutilisation directe via `\slideasset{...}`).
   - Document externe (`.tex` ou `.pdf`) ou sujet indépendant → initialiser `projets/<nom_slides>/` depuis `templates/template_slides/` via [`.agents/workflows/new-slides.md`](../../.agents/workflows/new-slides.md).
3. Les étapes du workflow [`.agents/workflows/latex-to-slides.md`](../../.agents/workflows/latex-to-slides.md) et le contrôle complet [`.agents/workflows/build-and-verify.md`](../../.agents/workflows/build-and-verify.md) (`0` erreur, `0` débordement horizontal ou vertical, contrôle visuel PDF).
4. Si une amélioration générique du socle de présentation est apportée, la rétro-porter dans `templates/template_slides/` et `templates/template_officiel/slides/`.
