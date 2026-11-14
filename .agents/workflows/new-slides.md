---
description: Créer une nouvelle présentation LaTeX moderne (16:9) à partir de templates/template_slides/ ou dans le sous-dossier intégré slides/ d'un projet existant.
---

# Workflow : Initialiser une Présentation (`ClasseGuillaumeSlides`)

Ce workflow permet de démarrer un jeu de diapositives propre, qu'il soit autonome ou lié à un document `ClasseGuillaume`.

---

## Étapes d'exécution

1. **Choisir le mode d'organisation adapté :**
   - **Mode A — Présentation autonome :** copier intégralement le contenu de `templates/template_slides/` (sans `build/`) vers `projets/<nom_slides>/`.
   - **Mode B — Présentation liée à un rapport existant :** travailler directement dans `projets/<nom_projet>/slides/` (déjà présent dans tout projet créé depuis `templates/template_officiel/`, ou à copier depuis `templates/template_officiel/slides/` sans `build/`). Vérifier que l'option `integrated` est active dans `main.tex`.

2. **Configurer `main.tex` et les options de classe :**
   - Ajuster `\documentclass[...]{ClasseGuillaumeSlides}` :
     - Langue : `french` (défaut) ou `english` (dans ce dernier cas, remplacer `.chktexrc` par `.chktexrc-en`).
     - Thème : `theme=light` (défaut éditorial clair) ou `theme=dark` (fond anthracite sombre).
     - Format, police et barre : `ratio=169`, `font=fira`, `progressbar=foot`, `sectionpage=on` (ou `off`).
   - Renseigner `\title`, `\subtitle`, `\author`, `\institute`, `\date` et les métadonnées `hypersetup`.

3. **Organiser le contenu dans `sections/` :**
   - Structurer les diapositives en fichiers thématiques (`sections/01-*.tex`, `02-*.tex`, ..., `99-backup.tex`) et utiliser les macros de `config/slides-macros.sty` (`slidecard`, `alertcard`, `\metriccard`, `\kpibadge`, `\takeaway`, `\sourcenote`, `\standoutslide`, `\slideasset`).
   - Respecter la sobriété éditoriale définie dans [`.agents/skills/latex-slides/SKILL.md`](../skills/latex-slides/SKILL.md).

4. **Compiler et vérifier la qualité :**
   - Suivre [`.agents/workflows/build-and-verify.md`](./build-and-verify.md) sur le dossier du diaporama (`templates/template_slides` ou `projets/<nom_projet>/slides`).
   - Exiger `0` erreur, `0` `Overfull \hbox`/`\vbox` et inspecter le PDF rendu (`pdftoppm` sur les slides denses ou graphiques).

5. **Rétro-portage :**
   - Toute amélioration générique apportée à `ClasseGuillaumeSlides.cls`, `config/slides-*.sty`, `latexmkrc` ou `.chktexrc*` doit être répercutée dans `templates/template_slides/` **et** synchronisée dans `templates/template_officiel/slides/`.
