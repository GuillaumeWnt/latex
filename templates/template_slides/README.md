# `template_slides` — Modèle Officiel de Présentations LaTeX Modernes

> **Rôle :** Modèle officiel pour toutes les présentations LaTeX (`projets/<nom_slides>/` en mode autonome, ou `projets/<nom_projet>/slides/` en mode intégré), harmonisé avec `ClasseGuillaume` (`templates/template_officiel/`).

---

## 1. Positionnement : Beamer/Moloch vs alternatives modernes

| Solution | Rendu moderne | Forces | Limites / Choix ici |
| :--- | :---: | :--- | :--- |
| **`ClasseGuillaumeSlides` (Beamer + Moloch v2.1)** | Élevé (style éditorial plat) | Compatibilité totale TikZ, `pgfplots`, `siunitx`, `biblatex`, `\includestandalone`, réutilisation directe de `ClasseGuillaume` | **Retenu comme standard LaTeX** (0 chrome daté, prêt en TeX Live 2026) |
| **`ltx-talk`** (v0.6.3) | Élevé | Nouvelle classe LaTeX3 orientée accessibilité PDF | Encore en `0.x` (écosystème et compatibilité paquets plus jeunes) |
| **Typst + Touying / Polylux** | Très élevé | Syntaxe ultra-rapide, compilation instantanée | Hors LaTeX ; pas d'import direct de macros/TikZ/biblio `ClasseGuillaume` |
| **Quarto / Reveal.js** | Web / interactif | Export HTML + PDF depuis Markdown | Pile Node/Pandoc/Quarto externe, moins précise typographiquement |

---

## 2. Options de classe (`\documentclass[...]{ClasseGuillaumeSlides}`)

| Option | Valeurs | Défaut | Effet |
| :--- | :--- | :--- | :--- |
| Langue | `french`, `english` | `french` | Configure `babel`, `siunitx` v3 et libellés |
| Thème | `theme=light`, `theme=dark` | `light` | Bascule toile blanche / ardoise sombre (les `cadreFigure` restent à fond blanc lisible) |
| Police | `font=fira`, `heros`, `calibri`, `plex`, `libertinus` | `fira` | Sans-serif moderne avec repli automatique vers `fonts/texgyreheros-*.otf` |
| Format | `ratio=169`, `ratio=1610`, `ratio=43` | `169` | Écran large 16:9 (16 × 9 cm) |
| Progression | `progressbar=foot`, `head`, `frametitle`, `none` | `foot` | Position de la barre de progression fine |
| Transitions | `sectionpage=on`, `sectionpage=off` | `on` | Diapositive de section automatique à chaque `\section{...}` |
| Sous-projet lié | `integrated` | désactivé | Partage automatiquement `../figures/`, `../biblio/`, `../fonts/`, `../data/`, `../listings/` |
| Projection / PDF | `handout`, `notes` | — | Version imprimable sans overlays ou notes orateur sur second écran |

---

## 3. Composants et macros disponibles

- **Compatibles `ClasseGuillaume` :** `\term{}`, `\code{}`, `\vect`, `\mat`, `\setR`, `\abs`, `\norm`, `\diff`, `callout`, `attentionbox`, `boiteSynthese`, `cadreFigure`.
- **Composants dédiés slides :**
  - `slidecard{Titre}` et `alertcard{Titre}` (cartes éditoriales minimalistes)
  - `\metriccard[largeur]{Valeur}{Libellé}[Tendance]` (cartes KPI à fort contraste)
  - `\kpibadge[couleur]{Texte}` (pastilles de statut)
  - `\takeaway{Message}` et `\sourcenote{Source}`
  - `\standoutslide{Texte}` ou `\begin{frame}[standout] ... \end{frame}`
  - `\category{}`, `\event{}`, `\location{}`, `\footertext{}`, `\afficherLogoSlides`

---

## 4. Compilation et audit qualité

Depuis `templates/template_slides/` (ou votre projet dérivé) :

```powershell
# Compilation LuaLaTeX + Biber (sortie isolée dans build/)
..\..\.agents\skills\latex-document-manager\scripts\compile.ps1 -ProjectDir .

# Audit statique + ChkTeX + contrôle du log
..\..\.agents\skills\latex-quality-auditor\scripts\lint-latex.ps1 -TargetDir . -RunChkTeX
```
