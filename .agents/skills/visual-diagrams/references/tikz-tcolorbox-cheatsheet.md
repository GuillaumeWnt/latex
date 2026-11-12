# Aide-Mémoire TikZ & `tcolorbox` (`mythesis.cls`)

---

## 1. Environnement `cadreFigure`

Dans `config/macros.sty`, `cadreFigure` accepte un argument **optionnel** d'options `tcolorbox` (il ne prend pas de `{Titre}` obligatoire) :

```latex
\begin{figure}[htbp]
  \centering
  \begin{cadreFigure}[width=0.88\linewidth]
    \includegraphics[width=\linewidth]{figures/tikz/schema-principe.pdf}
  \end{cadreFigure}
  \caption{Architecture modulaire du système.}
  \label{fig:architecture-systeme}
\end{figure}
```

Pour un encadré titré sans flottant, utiliser `\begin{boiteSynthese}{Titre} ... \end{boiteSynthese}`.

---

## 2. Styles TikZ Harmonisés (`ThesisPrimary` / `ThesisSecondary` / `ThesisAccent`)

```latex
\tikzset{
  base_node/.style = {
    draw=ThesisPrimary!75,
    thick,
    rounded corners=3pt,
    minimum height=1cm,
    minimum width=2.6cm,
    align=center,
    font=\small\sffamily
  },
  process/.style = {
    base_node,
    fill=ThesisPrimary!8
  },
  decision/.style = {
    diamond,
    draw=ThesisAccent!80,
    thick,
    aspect=2.1,
    fill=ThesisAccent!10,
    font=\small\sffamily,
    align=center
  },
  arrow/.style = {
    ->,
    >=Stealth,
    thick,
    draw=ThesisSecondary!85
  }
}
```

### Positionnement relatif (`positioning`)

```latex
\node[process] (start) {Étape initiale};
\node[process, below=1.0cm of start] (step1) {Traitement principal};
\node[decision, below=1.0cm of step1] (test) {Condition validée ?};
\node[process, right=1.5cm of test] (alt) {Branche alternative};
\node[process, below=1.0cm of test] (end) {Finalisation};

\draw[arrow] (start) -- (step1);
\draw[arrow] (step1) -- (test);
\draw[arrow] (test) -- node[left, font=\footnotesize\sffamily] {Oui} (end);
\draw[arrow] (test) -- node[above, font=\footnotesize\sffamily] {Non} (alt);
\draw[arrow] (alt) |- (step1);
```
