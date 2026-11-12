# Liste de Contrôle Typographique avant Livraison

---

## 1. Syntaxe & Structure
- [ ] Aucune commande obsolète (`{\bf}`, `{\it}`, `{\tt}`, `{\sc}`, `{\sl}`).
- [ ] Aucun bloc `$$ ... $$` (utiliser `\[ ... \]`, `equation` ou `align`).
- [ ] Sauts de ligne sémantiques (une phrase par ligne) et indentation à 2 espaces.
- [ ] Symboles mathématiques (`\rightarrow`, `\approx`, `\times`, grec) strictement en mode math (`$ ... $`).

---

## 2. Ponctuation, Citations & Unités
- [ ] Espace insécable `~` avant toute citation (`~\parencite{...}`, `~\cite{...}`, `~\textcite{...}`).
- [ ] Espace insécable `~` avant tout renvoi (`~\cref{...}`, `~\Cref{...}`, `~\cpageref{...}`).
- [ ] Unités et nombres via `siunitx` v3 (`\qty{25}{\celsius}`, `\qtyrange{10}{20}{\kilo\gram}`, `\qty{10}{\percent}`).
- [ ] Guillemets via `\enquote{...}` (`csquotes`), jamais de guillemets droits `"..."`.

---

## 3. Tableaux, Flottants & Notes
- [ ] Zéro filet vertical `|` et zéro `\hline` (utiliser `\toprule`, `\midrule`, `\bottomrule` et `tabularx`).
- [ ] Chaque `figure`, `table` et `illustration` possède un `\caption{...}` et un `\label{...}` placé après la légende (et avant les données pour les tableaux).
- [ ] En livraison finale : option `todos` retirée de `\documentclass` ou toutes les notes `\todoH` traitées, et compilation `latexmk` à **0 erreur** et minimum d'avertissements (`Overfull \hbox`, `chktex`).
