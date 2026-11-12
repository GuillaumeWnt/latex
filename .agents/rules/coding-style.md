# Style de Code LaTeX (`templates/template_officiel/`)

## 1. Syntaxe, Indentation & Sauts de Ligne
- **Indentation :** 2 espaces dans tous les environnements (`\begin{...}` ... `\end{...}`), conforme à `.editorconfig`.
- **Sauts de ligne sémantiques :** Une phrase ou proposition logique par ligne pour des diffs Git propres.
- **Sauts de paragraphe :** Laisser une ligne vide ; ne jamais utiliser `\\` en fin de paragraphe (`\\` est réservé aux tableaux, matrices et blocs d'alignement).
- **Titres en ligne :** Utiliser `\paragraph{Critère}` pour structurer des sous-points sans alourdir la table des matières.
- **Balisage sémantique (`config/macros.sty`) :**
  - `\term{concept}` pour introduire un terme technique.
  - `\code{identifiant}` pour un nom de fichier, commande ou extrait en ligne (s'adapte automatiquement aux bandeaux sombres).

---

## 2. Mathématiques & Unités (`siunitx` v3)
- **Environnements AMS :** `\[ ... \]` (non numéroté), `equation` (numéroté), `align` / `align*` (multi-lignes). Jamais `$$ ... $$`.
- **Macros métier disponibles (`config/macros.sty`) :** `\vect{x}`, `\mat{M}`, `\setR`, `\setN`, `\setZ`, `\setC`, `\abs{x}`, `\norm{x}`, `\scal{u}{v}`, `\diff`, `\argmin`, `\argmax`, `\trace`, `\diag`.
- **Unités :** Utiliser `\qty{25}{\meter\per\second}`, `\qtyrange{10}{20}{\kilo\gram}`, `\num{10000}` (locale `FR` préconfigurée). Éviter les unités inexistantes qui provoquent une erreur (ex. écrire `65~ans`, pas `\qty{65}{\year}`).
- **Ponctuation mathématique :** Terminer les équations affichées par `,` ou `.` selon la syntaxe de la phrase.

---

## 3. Labels & Références Croisées (`cleveref`)
- **Préfixes normalisés :** `chap:`, `sec:`, `fig:`, `ill:`, `tab:`, `eq:`, `hyp:`, `def:`, `lst:`, `anx:`.
- **Placement de `\label` :**
  - Dans les flottants (`figure`, `table`, `illustration`) : toujours **après** `\caption{...}`.
  - Dans les boîtes numérotées (`hypothesis`, `definitionbox`) : à l'intérieur du corps de la boîte.
- **Appels :** Préférer `~\cref{...}`, `\Cref{...}` et `~\cpageref{...}` aux renvois manuels.

---

## 4. Tableaux, Flottants & Boîtes Visuelles
- **Tableaux (`booktabs` + `tabularx`) :**
  - Utiliser `\toprule`, `\midrule`, `\bottomrule` et `\addlinespace` ; **zéro barre verticale `|` et zéro `\hline`**.
  - Légende placée **au-dessus** du tableau (`captions=tableheading`).
  - Colonnes prédéfinies dans `config/packages.sty` : `L{largeur}` (gauche), `C{largeur}` (centré), `R{largeur}` (droite), `Y` (`X` ferré à gauche, évite les `Underfull \hbox`).
  - Listes compactes dans les cellules : `\begin{itemize}[nosep, leftmargin=*]`.
- **Flottants :** Placement `[htbp]` par défaut (éviter `[H]` sauf nécessité avérée). Utiliser `illustration` pour les planches iconographiques listées séparément.
- **Boîtes `tcolorbox` (`config/macros.sty`) :**
  - `callout` (`[Titre]`) : remarque, conseil ou explication.
  - `attentionbox` (`[Titre]`) : point critique ou mise en garde.
  - `hypothesis` (`[Titre]`) et `definitionbox` (`[Titre]`) : boîtes numérotées par chapitre, compatibles `\cref`.
  - `boiteSynthese` (`{Titre}`) : synthèse ou encadré clé (titre obligatoire).
  - `cadreFigure` (`[options tcolorbox]`) : cadre arrondi pour figures/schémas (ne prend pas d'argument `{Titre}` obligatoire).

---

## 5. Annotations Collaboratives & Notes Marginales
- **`\noteMarge[offset]{texte}` :** Note éditoriale pérenne (conservée en mode `print`).
- **`\todoH[Profil][Couleur]{Commentaire}{Texte concerné}` :** Surlignage + note marginale (actif uniquement avec l'option de classe `todos` / `todoNote` ; profils `AuthorStyle`, `DirectorStyle`, `ReviewerStyle`, `GuillaumeStyle`, `MarieStyle`, `FloraStyle`).
