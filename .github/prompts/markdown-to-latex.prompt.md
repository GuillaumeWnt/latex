---
mode: agent
description: Convertir un document ou extrait Markdown en fichier LaTeX enrichi conforme à templates/template_officiel/ et vérifier zéro erreur de compilation.
---

Convertis le contenu Markdown demandé en LaTeX enrichi et prêt pour la compilation LuaLaTeX dans ce workspace.

Applique strictement :
1. Les instructions du skill [`.agents/skills/markdown-to-latex/SKILL.md`](../../.agents/skills/markdown-to-latex/SKILL.md) et sa table [`mapping-syntaxe.md`](../../.agents/skills/markdown-to-latex/references/mapping-syntaxe.md).
2. L'arborescence obligatoire de `templates/template_officiel/` sous `projets/<nom_projet>/` (si c'est un nouveau document, initialiser d'abord la structure complète `main.tex`, `ClasseGuillaume.cls`, `ClasseGuillaume-*.clo`, `config/`, `content/`, `frontmatter/`, `backmatter/`, `biblio/`, `figures/`, `listings/`, `fonts/`, `latexmkrc`, `.chktexrc`, `.editorconfig`, `.gitignore` via `new-project.md`).
3. Les étapes du workflow [`.agents/workflows/markdown-to-latex.md`](../../.agents/workflows/markdown-to-latex.md) et le contrôle post-édition [`.agents/workflows/build-and-verify.md`](../../.agents/workflows/build-and-verify.md) (zéro erreur, avertissements minimaux).
4. Si une amélioration générique de macro ou de socle est créée pendant la conversion, pense à la rétro-porter dans `templates/template_officiel/`.
