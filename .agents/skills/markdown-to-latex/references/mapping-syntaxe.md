# Table de Correspondance Complète : Markdown → LaTeX (`template_officiel`)

Cette référence liste les équivalences exactes à appliquer avec les macros de `templates/template_officiel/config/macros.sty` et `config/packages.sty`.

---

## 1. Structure & Mise en forme du texte

| Élément Markdown | Équivalent LaTeX enrichi (`template_officiel`) | Remarques |
| :--- | :--- | :--- |
| `# Titre` | `\chapter{Titre}\label{ch:titre}` *(ou `\section`)* | Utiliser `\chapter` uniquement dans les chapitres de niveau racine `content/XX-*.tex`. |
| `## Sous-titre` | `\section{Sous-titre}\label{sec:sous-titre}` | — |
| `### Sous-sous-titre` | `\subsection{...}\label{subsec:...}` | — |
| `#### Niveau 4` | `\subsubsection{...}` | Limiter la profondeur si la TDM (`tocdepth`) s'arrête à `subsection`. |
| `**concept clé**` | `\term{concept clé}` | Réserver `\textbf{...}` à l'emphase forte non terminologique. |
| `*emphase*` | `\emph{emphase}` | Jamais `{\it ...}`. |
| `` `commande` `` | `\code{commande}` | Échapper `_`, `%`, `&`, `#` si nécessaire (`\code{mon\_fichier}`) ; utiliser `\lstinline!...!` pour expressions complexes. |
| `"citation courte"` | `\enquote{citation courte}` | Guillemets typographiques français gérés automatiquement par `csquotes`. |
| `12,5 ms` / `45 %` | `\qty{12.5}{\milli\second}` / `\qty{45}{\percent}` | Espace insécable fine et police droite automatiques (`siunitx`). |
| `10 à 20 V` | `\qtyrange{10}{20}{\volt}` | Syntaxe standard `siunitx` v3. |
| `1 500 000` | `\num{1500000}` | Formatage automatique des séparateurs de milliers. |
| Listes `- item` / `1. item` | `\begin{itemize}` / `\begin{enumerate}` | Indentation **2 espaces** pour `\item ...`. |
| Listes de définitions (`Terme : def`) | `\begin{description}` avec `\item[Terme]` | Plus sémantique qu'une liste à puces avec gras manuel. |
| Notes de bas de page `[^1]` | `\footnote{Texte de la note.}` | Placer avant le point ou selon la règle de ponctuation retenue dans le document. |

---

## 2. Encadrés sémantiques (`tcolorbox` dans `config/macros.sty`)

> **Attention aux accolades vs crochets :**
> - `callout`, `attentionbox`, `definitionbox`, `hypothesis` prennent un titre **optionnel entre crochets** `[Titre]`.
> - `boiteSynthese` prend des options `tcolorbox` **optionnelles entre crochets** `[...]` et un titre **obligatoire entre accolades** `{Titre}`.

| Markdown (GFM / Note) | Environnement LaTeX | Exemple |
| :--- | :--- | :--- |
| `> [!NOTE]` ou `> [!INFO]` | `callout` | `\begin{callout}[Remarque méthodologique]` ... `\end{callout}` |
| `> [!WARNING]` ou `> [!CAUTION]` | `attentionbox` | `\begin{attentionbox}[Point de vigilance]` ... `\end{attentionbox}` |
| `> [!IMPORTANT]` (définition) | `definitionbox` | `\begin{definitionbox}[Nom]\label{def:nom}` ... `\end{definitionbox}` |
| Hypothèse numérotée | `hypothesis` | `\begin{hypothesis}[H1]\label{hyp:h1}` ... `\end{hypothesis}` |
| `> [!TIP]` ou encadré bilan | `boiteSynthese` | `\begin{boiteSynthese}{Points clés à retenir}` ... `\end{boiteSynthese}` |
| Citation simple `> ...` | `quote` | `\begin{quote}...\end{quote}` |
| Commentaire marge / `TODO` | `\noteMarge{...}` ou `\todoH{note}{cible}` | `\todoH{À valider par mesure}{valeur estimée}` |

---

## 3. Mathématiques (`amsmath` + macros de `config/macros.sty`)

| Markdown | LaTeX (`template_officiel`) |
| :--- | :--- |
| `$x \in \mathbb{R}^n$` | `$x \in \setR^n$` |
| `$\mathbf{v}$, $\mathbf{M}$` | `$\vect{v}$, $\mat{M}$` |
| `$\|x\|_2$, $|a|$, $\langle u, v \rangle$` | `$\norm{x}_2$, $\abs{a}$, $\scal{u}{v}$` |
| `$\frac{df}{dt}$` (droit) | `$\frac{\diff f}{\diff t}$` |
| `$$\sum_{i=1}^n x_i$$` | `\[ \sum_{i=1}^n x_i \]` (ou `\begin{equation}...\label{eq:...}\end{equation}`) |
| Équations alignées multi-lignes | `\begin{align} ... \end{align}` (jamais `$$ ... $$`) |

---

## 4. Tableaux Markdown → `tabularx` + `booktabs`

Un tableau Markdown tel que :
```markdown
| Paramètre | Symbole | Valeur | Remarque |
| :--- | :---: | ---: | :--- |
| Gain | $K_p$ | 2,5 | Réglage nominal |
```
doit être converti en (avec `\caption` **au-dessus** du tableau, suivi de `\label{tab:...}`) :

```latex
\begin{table}[htbp]
  \centering
  \caption{Paramètres nominaux du régulateur.}
  \label{tab:parametres-nominaux}
  \begin{tabularx}{\textwidth}{L{3.5cm} C{2cm} S[table-format=1.1] Y}
    \toprule
    \textbf{Paramètre} & \textbf{Symbole} & {\textbf{Valeur}} & \textbf{Remarque} \\
    \midrule
    Gain & $K_p$ & 2.5 & Réglage nominal \\
    \bottomrule
  \end{tabularx}
\end{table}
```

- Types de colonnes disponibles dans `template_officiel` : `L{largeur}` (gauche), `C{largeur}` (centré), `R{largeur}` (droite), `Y` (`X` aligné à gauche), `S` (`siunitx` aligné sur la décimale — entourer l'en-tête textuel d'accolades `{En-tête}`).
- En cas de tableau long sur plusieurs pages, préférer `longtable` / `xltabular` avec `\endhead` + `\toprule` / `\bottomrule`.

---

## 5. Blocs de code, Images & Mermaid

### Code source
````markdown
```python
def gain(kp: float) -> float:
    return kp * 1.5
```
````
devient :
```latex
\begin{lstlisting}[language=Python, caption={Calcul du gain ajusté.}, label={lst:calcul-gain}]
def gain(kp: float) -> float:
    return kp * 1.5
\end{lstlisting}
```
*(Si le bloc dépasse ~35 lignes : enregistrer dans `listings/<nom>.py` et utiliser `\lstinputlisting[language=Python, caption={...}, label={lst:...}]{listings/<nom>.py}`.)*

### Figures & Diagrammes (`cadreFigure`)
`cadreFigure` n'accepte pas d'argument titre obligatoire : le placer **à l'intérieur** de `\begin{figure}[htbp]` avec `\caption{...}` en dessous :

```latex
\begin{figure}[htbp]
  \centering
  \begin{cadreFigure}[width=0.9\textwidth]
    \centering
    \input{figures/tikz/architecture-systeme.tex}
  \end{cadreFigure}
  \caption{Architecture générale du système étudié.}
  \label{fig:architecture-systeme}
\end{figure}
```

---

## 6. Citations & Renvois croisés

| Markdown | LaTeX (`template_officiel`) |
| :--- | :--- |
| `(Dupont, 2024)` / `[@dupont2024]` | `~\parencite{dupont2024}` |
| `Dupont (2024) montre...` | `\textcite{dupont2024} montre...` |
| `voir figure 3` / `tableau 1` | `voir~\cref{fig:schema}` / `~\cref{tab:resultats}` |
| `La figure 3 montre...` *(début de phrase)* | `\Cref{fig:schema} montre...` |
| `voir page 14` | `voir~\cpageref{sec:methode}` |
