# Patrons Visuels 16:9 (`v2.0`) & Alternatives Modernes

Ce document regroupe les patrons graphiques recommandés pour `ClasseGuillaumeSlides v2.0`, conçus pour obtenir des présentations légères, variées et sans empilement de boîtes grises.

---

## 1. Gabarits de Diapositives Modernes (`v2.0`)

### Patron A — Métrique nue + Courbe `pgfplots` (`ClasseGuillaumeAxis`)
Préférer `\minimalstat` + `\stepitemrow` à droite plutôt qu'un empilement de deux boîtes superposées :

```latex
\begin{frame}{Exploitation directe des données expérimentales}
  \framesubtitle{Traçage vectoriel depuis \code{\slideasset{data/benchmark-results.csv}}}

  \begin{columns}[c, totalwidth=\textwidth]
    \begin{column}{0.61\textwidth}
      \begin{tikzpicture}
        \begin{axis}[ClasseGuillaumeAxis, line legend, width=8.2cm, height=4.7cm,
          xlabel={Itération}, ylabel={Précision (\%)}, ymin=55, ymax=103]
          \addplot+[very thick, SlidePrimary, mark=*] table[x=iteration, y=accuracy_proposed]{\slideasset{data/benchmark-results.csv}};
          \addlegendentry{Approche proposée}
          \addplot+[thick, dashed, SlideAccent, mark=none] table[x=iteration, y=accuracy_baseline]{\slideasset{data/benchmark-results.csv}};
          \addlegendentry{Référence}
        \end{axis}
      \end{tikzpicture}
    \end{column}
    \begin{column}{0.36\textwidth}
      \minimalstat[SlideAccent]{99,7\,\%}{Précision finale}[Gain de +17,0 pts vs référence.]
      \vspace*{0.28cm}
      \stepitemrow[SlideFillPrimary]{\faDatabase}{Traçabilité CSV}{%
        Séries issues du même fichier brut que le rapport.%
      }
    \end{column}
  \end{columns}
\end{frame}
```

### Patron B — Visuel incliné (`\tiltframe`) + Rail vertical (`railpoints`)
```latex
\begin{frame}{Source unique de vérité entre mémoire et diapositives}
  \begin{columns}[c, totalwidth=\textwidth]
    \begin{column}{0.55\textwidth}
      \centering
      \tiltframe[-2.2]{\resizebox{6.9cm}{!}{\includestandalone{\slideasset{figures/tikz/schema-principe}}}}
    \end{column}
    \begin{column}{0.42\textwidth}
      \begin{railpoints}[1.36cm]
        \railpoint[SlideFillPrimary]{01}{Figures parentes}{Lecture directe dans \code{../figures/}.}
        \railpoint[SlideFillSecondary]{02}{Bibliographie unique}{Synchronisée sur \code{../biblio/}~\autocite{kohm2024koma}.}
        \railpoint[SlideFillAccent]{03}{Compilation isolée}{Auxiliaires séparés dans \code{slides/build/}.}
      \end{railpoints}
    \end{column}
  \end{columns}
\end{frame}
```

### Patron C — Chaîne horizontale (`processline`) ou frise (`timelineflow`) + chiffres nus
```latex
\begin{frame}{Chaîne de synchronisation en trois étapes}
  \begin{processline}[Workflow]
    \processstep[SlideFillPrimary]{01}{Visuels}{Lecture directe des TikZ dans \code{../figures/}.}
    \processstep[SlideFillSecondary]{02}{Données}{Courbes tracées sur les CSV de \code{../data/}.}
    \processstep[SlideFillAccent]{03}{Code source}{Extraits ciblés dans \code{../listings/}.}
  \end{processline}
  \vspace*{0.35cm}
  \begin{columns}[T, totalwidth=\textwidth]
    \begin{column}{0.31\textwidth}\minimalstat[SlidePrimary]{16:9}{Format natif}\end{column}
    \begin{column}{0.31\textwidth}\minimalstat[SlideSecondary]{4}{Palettes complètes}\end{column}
    \begin{column}{0.31\textwidth}\minimalstat[SlideAccent]{0}{Boîte imposée}\end{column}
  \end{columns}
\end{frame}
```

### Patron D — Fond bandeau bas (`\usebandcanvas` / `\userailcanvas`) + cartes flottantes (`\floatingcard`)
Encapsuler `\usebandcanvas` (avant `\begin{frame}`) dans des accolades `{ ... }` pour limiter son effet à la diapositive courante (le jeton `SlideTextInverted` sert aussi pour tout titre posé sur un bloc ou une bande sombre) :

```latex
{
  \usebandcanvas[SlideFillPrimary][3.70cm][1.20cm]
  \begin{frame}{Trois piliers architecturaux}
    \vspace*{0.40cm}
    \begin{columns}[T, totalwidth=\textwidth]
      \begin{column}{0.31\textwidth}
        \floatingcard[SlideFillPrimary]{01}{Modèle unique}{Un socle partagé clair et sombre.}
      \end{column}
      \begin{column}{0.31\textwidth}
        \floatingcard[SlideFillSecondary]{02}{Rythme ouvert}{Zéro accumulation de cadres.}
      \end{column}
      \begin{column}{0.31\textwidth}
        \floatingcard[SlideFillAccent]{03}{Zéro dérive}{Compilation stricte + contrôle PNG.}
      \end{column}
    \end{columns}
  \end{frame}
}
```

### Patron E — Diagrammes `funnelchart`, `cyclechart` & mode sombre (`theme=dark`)
- Utiliser `funnelchart` + `\funnellevel` pour les processus de filtrage/qualification et `cyclechart` + `\cyclestep` pour les boucles d'itération (`PDCA`, validation continue).
- En `theme=dark` + `palette=vibrant`/`navy`/`forest`/`sage`, les couleurs sémantiques `SlideFillPrimary`, `SlideFillSecondary`, `SlideFillAccent`, `SlideCardSurface`, `SlideBg` et `SlideInk` s'adaptent automatiquement tout en gardant `cadreFigure` sur fond blanc lorsque nécessaire pour des TikZ conçus pour le papier.
- Pour les `slidecard`, `\metriccard`, `callout` et `attentionbox`, la syntaxe reste rétrocompatible lorsque la comparaison ou l'avertissement exige un encadrement net.

---

## 2. Hauteurs Recommandées sur Format 16:9 (`16 cm × 9 cm`)

| Zone | Hauteur / taille sûre | Remarque |
| :--- | :--- | :--- |
| Figure ou graphique principal (`pgfplots`, TikZ) | `4.0 cm` à `4.7 cm` | Laisser de l'air sous le `frametitle` et au-dessus du pied |
| `processline` / `timelineflow` / `cyclechart` | `<= 4.8 cm` hors titre | Adapter `espacement` ou rayon si > 4 items |
| Listing `lstlisting` (`[fragile]`) | 8 à 12 lignes max | Découper avec `firstline`/`lastline` au lieu de rétrécir sous `\scriptsize` |
| Tableau `booktabs` | 4 à 6 lignes max | Renvoyer les matrices exhaustives dans `sections/99-backup.tex` |

---

## 3. Comparatif des Alternatives Modernes à Beamer Classique

| Solution | Moteur / Langage | Atouts principaux | Limites actuelles | Quand l'utiliser |
| :--- | :--- | :--- | :--- | :--- |
| **`ClasseGuillaumeSlides v2.0`** (`beamer` sans chrome + TikZ/PGFPlots) | LuaLaTeX / TeX | Zéro réécriture de macros `ClasseGuillaume`, TikZ/PGFPlots/BibLaTeX natifs, mode `integrated`, palettes `light`/`dark`, compositions graphiques variées | Syntaxe Beamer (`frame`, `[fragile]`) | **Choix par défaut** pour tout projet du dépôt et présentations scientifiques/techniques LaTeX |
| **`ltx-talk`** | LaTeX3 / `expl3` (CTAN récent) | Classe LaTeX moderne conçue *from scratch* pour remplacer `beamer` | Écosystème jeune, compatibilité thèmes encore en évolution | Veille technique ou prototypes LaTeX expérimentaux hors contraintes de rétrocompatibilité |
| **`Typst` + `Touying` / `Polylux`** | Typst (Rust) | Compilation quasi instantanée, syntaxe proche Markdown, design web/éditorial fluide | Pas d'import direct des `.tex`/TikZ/`biblatex` `ClasseGuillaume` | Présentations autonomes rapides ne nécessitant ni TikZ complexe ni couplage LaTeX |
| **`Quarto` + `Reveal.js`** | Markdown + Pandoc + HTML/CSS | Transitions web, widgets JS, génération depuis notebooks Jupyter | Rendu dépendant d'un navigateur, export PDF moins fin pour TikZ | Démonstrations data-science interactives en HTML ou supports web |
