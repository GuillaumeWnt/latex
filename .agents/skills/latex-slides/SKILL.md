---
name: latex-slides
description: >-
  Use this skill when creating modern, editorial 16:9 LaTeX presentations with ClasseGuillaumeSlides
  (standalone templates/template_slides/ or integrated <projet>/slides/), designing light/dark frames,
  or converting an internal ClasseGuillaume document or external .tex/.pdf into clean slides.
---

# Compétence Présentations Éditoriales Modernes (`latex-slides`)

Cette compétence encadre la conception de présentations **16:9 aérées, lisibles et contemporaines** via [`ClasseGuillaumeSlides.cls`](../../../templates/template_slides/ClasseGuillaumeSlides.cls) (moteur minimal `moloch` sur Beamer + palette typographique `ClasseGuillaume`), en rupture totale avec le rendu Beamer daté par défaut.

---

## 1. Choix de l'Architecture : Autonome ou Intégrée

| Situation | Emplacement cible | Modèle source | Option clé |
| :--- | :--- | :--- | :--- |
| Diaporama autonome / externe | `projets/<nom_slides>/` | `templates/template_slides/` | *(défaut)* |
| Diaporama adossé à un rapport | `projets/<nom_projet>/slides/` | `templates/template_officiel/slides/` | `integrated` |

- **En mode `integrated` :** `latexmkrc` et `\slideasset{<chemin>}` (défini dans `config/slides-macros.sty`) résolvent automatiquement `../figures/`, `../figures/tikz/`, `../biblio/`, `../fonts/`, `../data/` et `../listings/` sans dupliquer les sources ni partager `build/`.
- **Règle d'isolation critique :** ne jamais ajouter `..` ni `../build` à `TEXINPUTS`, afin qu'un `slides/main.tex` ne charge jamais `../build/main.bbl` ou `../build/main.aux` du rapport parent.

---

## 2. Options de `ClasseGuillaumeSlides`

```latex
\documentclass[
  french,           % french (défaut) | english (adapter .chktexrc -> .chktexrc-en)
  theme=light,      % light (éditorial clair, défaut) | dark (anthracite sombre)
  font=fira,        % fira (défaut) | heros | calibri | plex | libertinus
  ratio=169,        % 169 (16:9 défaut) | 1610 | 43
  progressbar=foot, % foot (défaut) | head | frametitle | none
  sectionpage=on    % on (transition numérotée, défaut) | off
  % , integrated    % partage les ressources ../ du projet parent
  % , handout       % aplatit les overlays \pause / \only pour impression/diffusion
  % , notes         % notes orateur sur second écran (pdfpc / pympress)
]{ClasseGuillaumeSlides}
```

---

## 3. Composants Éditoriaux (`config/slides-macros.sty`)

- **Cartes modernes (sans lourdes boîtes Beamer criardes) :**
  - `slidecard[options]{Titre}` : carte éditoriale neutre avec filet supérieur bleu marine.
  - `alertcard[options]{Titre}` : carte d'accentuation terracotta pour risques, limites ou points critiques.
  - `\metriccard[largeur]{Valeur}{Libellé}[Tendance]` : carte KPI à chiffre clé fort.
  - `\kpibadge[Couleur]{Texte}` : pastille inline concise (`SlideSecondary`, `SlideAccent`, `SlidePrimary`).
- **Ancrages & transitions :**
  - `\takeaway{Message clé}` : bandeau de synthèse en bas de diapositive.
  - `\sourcenote{Source}` : mention discrète alignée au pied du contenu.
  - `\standoutslide[options]{Message fort}` : diapositive plein cadre d'ouverture, rupture ou conclusion.
- **Portabilité directe depuis un document `ClasseGuillaume` :**
  - `callout`, `attentionbox`, `boiteSynthese` et `cadreFigure` fonctionnent avec la même syntaxe que dans les rapports (et `cadreFigure` force un fond blanc même en `theme=dark` pour préserver les schémas TikZ).
  - Macros partagées : `\LuaLaTeX`, `\term`, `\code`, `\vect`, `\mat`, `\setR`/`\setN`/`\setZ`/`\setC`, `\abs`, `\norm`, `\scal`, `\diff`, `\argmin`/`\argmax`, `\trace`, `\diag`.
  - `\slideasset{chemin}` : macro développable obligatoire dans `\addplot table {\slideasset{data/...}}` ou `\lstinputlisting{\slideasset{listings/...}}` *(inutile pour `\input{mon-tikz}`, `\includegraphics` et `\addbibresource` déjà résolus par `TEXINPUTS`/`BIBINPUTS` et `chktex`)*.

---

## 4. Règles d'Or Visuelles & Anti-Beamer-Classique

1. **Une idée par diapositive, ~35–50 mots max** hors code ou graphique ; préférer 2 colonnes aérées (`columns` + `slidecard`) ou une figure large à un bloc de texte dense.
2. **Titre d'assertion sur une seule ligne :** le `frametitle` formule le message principal ; `\framesubtitle` porte le contexte technique ou le chemin source.
3. **Zéro surcharge :** conserver les marges généreuses, garder les tableaux `booktabs` sous ~5 lignes × 4 colonnes, et renvoyer preuves longues ou paramètres détaillés dans `sections/99-backup.tex` après `\appendix`.
4. **Listings & verbatim :** toujours passer `[fragile]` à `\begin{frame}[fragile]` dès qu'un environnement `lstlisting` ou verbatim est présent.
5. **Conflits Beamer connus :** ne jamais charger `geometry`, `enumitem`, `caption` ou `subcaption` dans un projet slides ; `french` force déjà `Tableau` pour les légendes.

---

## 5. Compilation, Contrôle Qualité & Alternatives Hors LaTeX

- **Contrôle systématique :** lancer `lint-latex.ps1 -TargetDir "<dossier>" -RunChkTeX` (utiliser `.chktexrc-en` si option `english`) puis `compile.ps1 -ProjectDir "<dossier>"`. Exiger **0 erreur**, **0 `Overfull \hbox`**, **0 `Overfull \vbox`** et inspecter visuellement les diapositives critiques (`pdftoppm -png -r 150`).
- **Rétro-portage :** reporter toute amélioration du socle simultanément dans `templates/template_slides/` et `templates/template_officiel/slides/`.
- **Guides associés :**
  - [`references/design-patterns.md`](./references/design-patterns.md) : patrons de composition 16:9, thème sombre et comparatif des alternatives modernes (`ltx-talk`, `Typst + Touying`, `Quarto`).
  - [`references/document-to-slides-guide.md`](./references/document-to-slides-guide.md) : méthode complète pour transformer un rapport interne `ClasseGuillaume` ou un document externe (`.tex` ou `.pdf`) en diaporama.
