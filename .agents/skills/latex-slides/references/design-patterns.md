# Patrons Éditoriaux 16:9 & Alternatives Modernes

Ce document regroupe les gabarits éprouvés pour `ClasseGuillaumeSlides` ainsi qu'un comparatif objectif des écosystèmes de présentation hors Beamer classique.

---

## 1. Gabarits de Diapositives Prêts à l'Emploi

### Patron A — Métrique clé + Graphique / Figure (`columns`)
Idéal pour exposer un résultat chiffré sans noyer la courbe dans du texte :

```latex
\begin{frame}{L'approche proposée réduit l'erreur de \qty{34}{\percent}}
  \framesubtitle{Benchmark mesuré sur \slideasset{data/benchmark-results.csv}}

  \begin{columns}[T, onlytextwidth]
    \begin{column}{0.61\textwidth}
      \begin{cadreFigure}[before skip=0pt]
        \centering
        % Graphique TikZ / pgfplots hauteur ~3.7 cm à 4.0 cm max
      \end{cadreFigure}
    \end{column}
    \begin{column}{0.35\textwidth}
      \metriccard{99,7 \%}{Précision à l'itération 20}[+17,0 pts vs Baseline]
      \vspace*{0.2cm}
      \begin{slidecard}{Ce qu'il faut retenir}
        Convergence atteinte deux fois plus vite, avec une variance divisée par trois.
      \end{slidecard}
    \end{column}
  \end{columns}
\end{frame}
```

### Patron B — Comparaison à deux cartes (`slidecard` vs `alertcard`)
```latex
\begin{frame}{Arbitrage entre architecture A et architecture B}
  \begin{columns}[T, onlytextwidth]
    \begin{column}{0.48\textwidth}
      \begin{slidecard}{Option retenue \hfill \kpibadge{Recommandée}}
        Points forts synthétiques en 2 à 3 puces courtes.
      \end{slidecard}
    \end{column}
    \begin{column}{0.48\textwidth}
      \begin{alertcard}{Limites de l'approche initiale}
        Contraintes identifiées justifiant le changement d'architecture.
      \end{alertcard}
    \end{column}
  \end{columns}
  \takeaway{Décision : adoption de l'option A dès la phase pilote.}
\end{frame}
```

### Patron C — Extrait de code ciblé (`[fragile]`)
```latex
\begin{frame}[fragile]{Implémentation modulaire du noyau de calcul}
  \framesubtitle{Extrait synchronisé depuis \code{\slideasset{listings/algorithm-pipeline.py}}}

  \begin{columns}[T, onlytextwidth]
    \begin{column}{0.61\textwidth}
      \lstinputlisting[language=Python, firstline=10, lastline=18]{\slideasset{listings/algorithm-pipeline.py}}
    \end{column}
    \begin{column}{0.35\textwidth}
      \begin{callout}[Point technique]
        Toujours limiter les extraits à ~10–14 lignes lisibles depuis le fond d'une salle.
      \end{callout}
    \end{column}
  \end{columns}
\end{frame}
```

### Patron D — Diapositive `standout` et mode sombre (`theme=dark`)
- Utiliser `\standoutslide{Question centrale ou message de clôture}` pour les ruptures fortes (2 ou 3 maximum par deck).
- En `theme=dark`, les cartes (`SlideCardBg`), la couleur `\code{...}` et `ClasseGuillaumeSlidescode` basculent automatiquement sur fond anthracite à fort contraste ; `cadreFigure` conserve volontairement un fond blanc et du texte foncé afin que les diagrammes TikZ conçus pour le rapport imprimable restent immédiatement lisibles sans retouche.

---

## 2. Hauteurs Recommandées sur Format 16:9 (`16 cm × 9 cm`)

| Zone | Hauteur sûre maximale | Remarque |
| :--- | :--- | :--- |
| Figure seule pleine largeur (`cadreFigure`) | `4.1 cm` à `4.4 cm` | Laisser de l'air sous le `frametitle` et au-dessus de la footline |
| Figure + bandeau `\takeaway` | `3.5 cm` à `3.8 cm` | Vérifier l'absence totale d'`Overfull \vbox` dans `build/main.log` |
| Listing `lstlisting` | 10 à 14 lignes max | Découper avec `firstline`/`lastline` au lieu de réduire sous `\scriptsize` |
| Tableau `booktabs` | 4 à 6 lignes max | Exporter les matrices complètes vers `sections/99-backup.tex` |

---

## 3. Comparatif des Alternatives Modernes à Beamer Classique

| Solution | Moteur / Langage | Atouts principaux | Limites actuelles | Quand l'utiliser |
| :--- | :--- | :--- | :--- | :--- |
| **`ClasseGuillaumeSlides` (`beamer` + `moloch`)** | LuaLaTeX / TeX | Zéro réécriture de macros, TikZ/pgfplots/BibLaTeX natifs, mode `integrated` direct avec les rapports `ClasseGuillaume`, très stable | Syntaxe Beamer classique (`frame`, `[fragile]`) | **Choix par défaut** pour tout projet du dépôt et présentations scientifiques/techniques LaTeX |
| **`ltx-talk`** | LaTeX3 / `expl3` (CTAN récent) | Classe LaTeX moderne conçue *from scratch* pour remplacer `beamer` avec Markdown/clés modernes | Écosystème jeune, documentation et compatibilité thèmes encore en évolution | Veille technique ou prototypes LaTeX expérimentaux hors contraintes de rétrocompatibilité |
| **`Typst` + `Touying` / `Polylux`** | Typst (Rust) | Compilation quasi instantanée, syntaxe proche Markdown, design web/éditorial très fluide | Incompatible avec le partage direct de fichiers `.tex`/TikZ/`biblatex` des rapports `ClasseGuillaume` | Présentations autonomes rapides ne nécessitant ni TikZ complexe ni couplage LaTeX |
| **`Quarto` + `Reveal.js`** | Markdown + Pandoc + HTML/CSS | Transitions web, widgets interactifs JS, génération depuis notebooks Python/Jupyter | Dépendant d'un navigateur pour le rendu natif, export PDF moins fin pour les équations/TikZ | Démonstrations data-science interactives en HTML ou supports web diffusés en ligne |
