# TikZ & tcolorbox Cheatsheet

This cheatsheet covers standard practices for authoring native TikZ graphics and `tcolorbox` figure wrappers within `ClasseGuillaume.cls`.

---

## 1. The `cadreFigure` Environment

In `ClasseGuillaume.cls`, visual elements can be placed inside an elegant framed box:

```latex
\begin{cadreFigure}{Titre synthétique de l'illustration}
  \centering
  \includegraphics[width=0.85\linewidth]{images/mon_schema.pdf}
\end{cadreFigure}
```

- Adds a crisp border and styled title bar matching the document palette.
- Prevents page-break splits inside complex diagrams.

---

## 2. Best Practices for TikZ Flowcharts

### Modular TikZ Setup
Define common styles cleanly:

```latex
\tikzset{
  base_node/.style = {
    draw=black!70,
    thick,
    rounded corners=3pt,
    minimum height=1cm,
    minimum width=2.5cm,
    text centered,
    font=\small\sffamily
  },
  process/.style = {
    base_node,
    fill=blue!10
  },
  decision/.style = {
    diamond,
    draw=black!70,
    thick,
    aspect=2,
    fill=amber!15,
    font=\small\sffamily,
    text centered
  },
  arrow/.style = {
    ->,
    >=stealth,
    thick,
    draw=black!80
  }
}
```

### Relative Node Placement
Always use relative positioning (`positioning` library):
```latex
\node[process] (start) {Étape Initiale};
\node[process, below=1.2cm of start] (step1) {Traitement Principal};
\node[decision, below=1.2cm of step1] (test) {Condition Validée ?};
\node[process, right=1.5cm of test] (alt) {Branche Alternative};
\node[process, below=1.2cm of test] (end) {Finalisation};

\draw[arrow] (start) -- (step1);
\draw[arrow] (step1) -- (test);
\draw[arrow] (test) -- node[left, font=\footnotesize] {Oui} (end);
\draw[arrow] (test) -- node[above, font=\footnotesize] {Non} (alt);
\draw[arrow] (alt) |- (step1);
```

