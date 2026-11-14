---
name: latex-slides
description: >-
  Use this skill when creating modern, editorial 16:9 LaTeX presentations with ClasseGuillaumeSlides
  (standalone templates/template_slides/ or integrated <projet>/slides/), designing light/dark frames,
  or converting an internal ClasseGuillaume document or external .tex/.pdf into clean slides.
---

# Compétence Présentations Éditoriales Modernes (`latex-slides`)

Cette compétence encadre la conception de présentations **16:9 respirantes, éditoriales et visuellement variées** via [`ClasseGuillaumeSlides.cls`](../../../templates/template_slides/ClasseGuillaumeSlides.cls) (moteur Beamer minimal sans thème lourd + compositions TikZ / PGFPlots natives), en rupture totale avec les diapositives Beamer encadrées ou surchargées.

> **Références visuelles du dépôt :** [`templates/exemples-slides/`](../../../templates/exemples-slides/) contient 23 planches de référence illustrant l'aération, les chiffres nus sur blanc, les diagrammes vectoriels ouverts et les compositions colorées pleines.

---

## 1. Choix de l'Architecture : Autonome ou Intégrée

| Situation | Emplacement cible | Modèle source | Option clé |
| :--- | :--- | :--- | :--- |
| Diaporama autonome / externe | `projets/<nom_slides>/` | `templates/template_slides/` | *(défaut)* |
| Diaporama adossé à un rapport | `projets/<nom_projet>/slides/` | `templates/template_officiel/slides/` | `integrated` |

- **En mode `integrated` :** `latexmkrc` et `\slideasset{<chemin>}` (défini dans `config/slides-macros.sty`) résolvent automatiquement `../figures/`, `../figures/tikz/`, `../biblio/`, `../fonts/`, `../data/` et `../listings/` sans dupliquer les sources ni partager `build/`.
- **Règle d'isolation critique :** ne jamais ajouter `..` ni `../build` à `TEXINPUTS`, afin qu'un `slides/main.tex` ne charge jamais `../build/main.bbl` ou `../build/main.aux` du rapport parent.

---

## 2. Options de `ClasseGuillaumeSlides` (`v2.0`)

```latex
\documentclass[
  french,              % french (défaut) | english (adapter .chktexrc -> .chktexrc-en)
  theme=light,         % light (défaut) | dark (ardoise sombre à fort contraste)
  palette=navy,        % navy (défaut) | forest | sage | vibrant
  style=editorial,     % editorial (filet fin, défaut) | organic (ondes discrètes) | minimal
  cover=diagonal,      % diagonal (défaut) | organic | framed | editorial
  eyebrow=off,         % off (défaut léger) | on (rappel de section en haut)
  footer=minimal,      % minimal (folio seul, défaut) | full (mention + folio) | none
  progressbar=none,    % none (défaut) | foot | head | frametitle
  font=fira,           % fira (défaut) | heros | calibri | plex | libertinus
  ratio=169,           % 169 (16:9 défaut) | 1610 | 43
  sectionpage=on       % on (transition colorée 01/02, défaut) | off
  % , integrated       % partage les ressources ../ du projet parent
  % , handout          % aplatit les overlays \pause / \only pour impression/diffusion
  % , notes            % notes orateur sur second écran (pdfpc / pympress)
]{ClasseGuillaumeSlides}
```

---

## 3. Composants Graphiques & Éditoriaux (`config/slides-macros.sty`)

Privilégier d'abord les composants **ouverts et structurants** plutôt que d'enfermer chaque bloc dans une boîte :

- **Typographie ouverte & séquences :**
  - `\minimalstat[couleur]{Valeur}{Libellé}[Complément]` : chiffre clé nu sans cadre, avec soulignement d'accent.
  - `\stepitem[square|circle|ring|pill][SlideFillPrimary]{N°}{Titre}{Texte}` et `\stepitemrow[SlideFillPrimary]{\faIcon}{Titre}{Texte}` : puces géométriques colorées et items à pastille d'icône sans boîte autour du texte.
  - `railpoints[espacement]` + `\railpoint[auto|Couleur]{N°}{Titre}{Texte}` : rail vertical numéroté relié par un trait fin.
- **Diagrammes natifs TikZ (`16:9` sans débordement) :**
  - `processline[Étiquette]` + `\processstep[auto|Couleur]{N°}{Titre}{Texte}` : frise horizontale d'étapes numérotées reliées par connecteurs.
  - `timelineflow` + `\timelineevent[auto|top|bottom][auto|Couleur]{Date}{Titre}{Texte}` : chronologie horizontale alternée haut/bas.
  - `funnelchart[largeur-haut]` + `\funnellevel[auto|Couleur]{N°}{Titre}{Texte}` : entonnoir trapézoïdal aligné sur fiches explicatives.
  - `cyclechart[rayon]{Titre centre}` + `\cyclestep[auto|Couleur]{N°}{Titre}{Texte}` : boucle circulaire annotée en couronne.
- **Graphiques `pgfplots` :** style `\begin{axis}[ClasseGuillaumeAxis, ...]` (ajouter `area legend` après `ybar=...`, ou `line legend` pour des courbes).
- **Mises en scène & accrochages visuels :**
  - `\floatingcard[Couleur][largeur]{Badge}{Titre}{Contenu}` : carte flottante aérée à ombre douce et pastille supérieure chevauchante.
  - `\tiltframe[angle][padding]{Visuel}` : cadre incliné avec ombre portée douce pour captures ou schémas TikZ.
  - `\diagonalpanel[largeur][hauteur]{Visuel}` et `\circlebadgevisual[diamètre]{Visuel}` : bande latérale oblique et médaillon circulaire bordé.
  - `\usebandcanvas[Couleur][hauteur-haut][arrondi]` et `\userailcanvas[Couleur][largeur]` : fonds structurels à appeler avant `\begin{frame}` dans un groupe `{ ... }`.
- **Cartes sobres (à réserver à la hiérarchie forte) & portabilité `ClasseGuillaume` :**
  - `slidecard{Titre}`, `alertcard{Titre}`, `\metriccard`, `\kpibadge`, `\takeaway`, `\sourcenote`, `\standoutslide`, `\covervisual{...}`.
  - Environnements & macros partagés avec `ClasseGuillaume` : `callout`, `attentionbox`, `boiteSynthese`, `cadreFigure`, `\slideasset{chemin}`, `\term`, `\code`, `\vect`, `\mat`, `\setR`, `\abs`, `\norm`, `\diff`, `\argmin`/`\argmax`, `\trace`, `\diag`.

---

## 4. Règles d'Or Visuelles & Anti-Beamer-Classique

1. **Ne pas tout encadrer :** au moins 50 % des diapositives doivent reposer sur une mise en page ouverte (`\minimalstat`, `railpoints`, `processline`, `timelineflow`, `funnelchart`, `cyclechart`, `\stepitemrow`, graphique nu). Réserver `slidecard` / `floatingcard` aux comparaisons contrastées ou synthèses ciblées.
2. **Une idée et ~30–45 mots max par diapositive :** titre d'assertion actif sur 1 ligne ; `\framesubtitle` porte uniquement le contexte ou chemin source.
3. **Alterner les rythmes visuels :** ne jamais enchaîner deux diapositives ayant exactement la même grille ; jouer avec `\usebandcanvas`, `\userailcanvas`, `\tiltframe`, les diagrammes horizontaux et `\standoutslide` (2 à 3 fois par jeu).
4. **Hauteur maîtrisée & `listings` :** garder les schémas et graphiques sous `4.0 cm–4.4 cm` de haut, limiter les tableaux `booktabs` à `<= 5` lignes, passer `[fragile]` dès qu'il y a un `lstlisting`, et renvoyer preuves/paramètres longs dans `sections/99-backup.tex`.
5. **Conflits Beamer & FontAwesome5 :** ne jamais charger `geometry`, `enumitem`, `caption` ou `subcaption` ; utiliser des noms d'icônes valides en TeX Live 2026 (`\faSync`, `\faPalette`, `\faLayerGroup`, `\faCheckDouble`, `\faCheckCircle`, `\faDatabase` — éviter `\faSyncAlt`).

---

## 5. Compilation, Contrôle Qualité & Alternatives Hors LaTeX

- **Contrôle systématique :** lancer `compile.ps1 -ProjectDir "<dossier>"` puis `lint-latex.ps1 -TargetDir "<dossier>" -RunChkTeX` (ajouter `-Language english` si option `english`). Exiger **0 erreur**, **0 avertissement**, **0 `Overfull \hbox`/`\vbox`**, **0 avertissement `ChkTeX`**, puis **inspecter visuellement** les PNG (`pdftoppm -png -r 150`).
- **Rétro-portage :** maintenir `ClasseGuillaumeSlides.cls`, `config/slides-packages.sty`, `config/slides-macros.sty`, `.chktexrc` et `.chktexrc-en` strictement identiques entre `templates/template_slides/` et `templates/template_officiel/slides/`.
- **Guides associés :**
  - [`references/design-patterns.md`](./references/design-patterns.md) : patrons visuels `v2.0` sans boîtes lourdes, mode `theme=dark` et comparatif (`ltx-talk`, `Typst + Touying`, `Quarto`).
  - [`references/document-to-slides-guide.md`](./references/document-to-slides-guide.md) : distillation d'un rapport `ClasseGuillaume` ou d'un document externe (`.tex` / `.pdf`) en diaporama.
