# `template_slides` — Modèle Officiel de Présentations LaTeX Modernes (`v2.0`)

> **Rôle :** Modèle officiel pour toutes les présentations LaTeX (`projets/<nom_slides>/` en mode autonome, ou `projets/<nom_projet>/slides/` en mode intégré), harmonisé avec `ClasseGuillaume` (`templates/template_officiel/`).

---

## 1. Positionnement : `ClasseGuillaumeSlides` vs alternatives modernes

| Solution | Rendu moderne | Forces | Limites / Choix ici |
| :--- | :---: | :--- | :--- |
| **`ClasseGuillaumeSlides v2.0` (Beamer épuré + TikZ/PGFPlots)** | Élevé (éditorial, organique ou minimal) | Compatibilité totale TikZ, `pgfplots`, `siunitx`, `biblatex`, `\includestandalone`, réutilisation directe de `ClasseGuillaume` | **Retenu comme standard LaTeX** (0 chrome daté, prêt en TeX Live 2026) |
| **`ltx-talk`** (v0.6+) | Élevé | Classe LaTeX3 orientée accessibilité PDF | Écosystème et thèmes encore jeunes |
| **Typst + Touying / Polylux** | Très élevé | Syntaxe ultra-rapide, compilation instantanée | Hors LaTeX ; pas d'import direct de macros/TikZ/biblio `ClasseGuillaume` |
| **Quarto / Reveal.js** | Web / interactif | Export HTML + PDF depuis Markdown | Pile Node/Pandoc/Quarto externe, moins fine pour TikZ |

---

## 2. Options de classe (`\documentclass[...]{ClasseGuillaumeSlides}`)

| Option | Valeurs | Défaut | Effet |
| :--- | :--- | :--- | :--- |
| Langue | `french`, `english` | `french` | Configure `babel`, `siunitx` v3 et libellés |
| Thème | `theme=light`, `theme=dark` | `light` | Bascule toile claire / ardoise sombre |
| Palette | `palette=navy`, `forest`, `sage`, `vibrant` | `navy` | Jeu de couleurs complet (clair & sombre, titres, graphiques et aplats) |
| Style visuel | `style=editorial`, `organic`, `minimal` | `editorial` | Filet de titre éditorial, courbes organiques en coins ou épure totale |
| Couverture | `cover=diagonal`, `organic`, `framed`, `editorial` | `diagonal` | Modèle graphique de `\maketitle` (`\covergraphic{...}` supporté) |
| Habillage | `eyebrow=off|on`, `footer=minimal|full|none` | `off`, `minimal` | Surtitre de section et densité du pied de page (`\footertext{...}`) |
| Progression | `progressbar=none`, `foot`, `head`, `frametitle` | `none` | Affiche ou masque la barre d'avancement |
| Police | `font=fira`, `heros`, `calibri`, `plex`, `libertinus` | `fira` | Sans-serif moderne avec repli vers `fonts/texgyreheros-*.otf` |
| Format | `ratio=169`, `ratio=1610`, `ratio=43` | `169` | Écran large 16:9 (`16 × 9 cm`) |
| Transitions | `sectionpage=on`, `sectionpage=off` | `on` | Diapositive de section automatique numérotée à chaque `\section{...}` |
| Sous-projet lié | `integrated` | désactivé | Partage `../figures/`, `../biblio/`, `../fonts/`, `../data/`, `../listings/` |
| Diffusion | `handout`, `notes` | — | Version aplatie sans overlays ou notes orateur sur second écran |

---

## 3. Composants et macros disponibles

- **Compatibles `ClasseGuillaume` :** `\term{}`, `\code{}`, `\vect`, `\mat`, `\setR`, `\abs`, `\norm`, `\diff`, `callout`, `attentionbox`, `boiteSynthese`, `cadreFigure`, `\slideasset{...}`.
- **Composants ouverts & diagrammes vectoriels (`v2.0`) :**
  - Typographie ouverte : `\minimalstat`, `\stepitem[square|circle|ring|pill]`, `\stepitemrow`
  - Diagrammes natifs : `railpoints` (`\railpoint`), `processline` (`\processstep`), `timelineflow` (`\timelineevent`), `funnelchart` (`\funnellevel`), `cyclechart` (`\cyclestep`), style `pgfplots` `ClasseGuillaumeAxis`
  - Mises en scène & fonds : `\floatingcard`, `\tiltframe`, `\diagonalpanel`, `\circlebadgevisual`, `\usebandcanvas`, `\userailcanvas`
- **Cartes sobres & structure :** `slidecard`, `alertcard`, `\metriccard`, `\kpibadge`, `\takeaway`, `\sourcenote`, `\standoutslide`, `\category{}`, `\event{}`, `\location{}`, `\covervisual{}`, `\afficherLogoSlides`.

---

## 4. Compilation et audit qualité

Depuis `templates/template_slides/` (ou votre projet dérivé) :

```powershell
# Compilation LuaLaTeX + Biber (sortie isolée dans build/)
..\..\.agents\skills\latex-document-manager\scripts\compile.ps1 -ProjectDir .

# Audit statique + ChkTeX + contrôle du log (ajouter -Language english si option english)
..\..\.agents\skills\latex-quality-auditor\scripts\lint-latex.ps1 -TargetDir . -RunChkTeX
```
