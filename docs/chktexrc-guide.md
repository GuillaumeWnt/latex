# Guide `.chktexrc` & Avertissements Réels sur `projets/portfolio/`

> **Contexte :** Dans VS Code, l'extension **LaTeX Workshop** active ChkTeX (`"latex-workshop.linting.chktex.enabled": true` dans [`.vscode/settings.json`](../.vscode/settings.json)), tout comme le script [`lint-latex.ps1`](../.agents/skills/latex-quality-auditor/scripts/lint-latex.ps1) avec `-RunChkTeX`. ChkTeX est un **analyseur statique (linter)** qui s'exécute sur vos fichiers `.tex`, indépendamment du compilateur `LuaLaTeX`.

---

## 1. Fonctionnement général de `.chktexrc` et différence avec `.chktexrc-en`

ChkTeX charge d'abord sa configuration système globale (`chktexrc` de TeX Live), puis applique le fichier local [`.chktexrc`](../projets/portfolio/.chktexrc) du projet :
- **Avec `=` (`TabSize = 2`) :** remplace la valeur précédente.
- **Sans `=` (`CmdLine { ... }`, `Linker { ... }`, `Silent { ... }`, `WipeArg { ... }`) :** **ajoute** les éléments à la liste globale existante sans écraser ceux fournis par TeX Live.
- **Accolades `{ ... }` vs crochets `[ ... ]` :** les listes entre `{ ... }` sont sensibles à la casse ; celles entre `[ ... ]` servent aux motifs insensibles à la casse ou expressions régulières (selon la directive).
- **Différence entre `.chktexrc` et [`.chktexrc-en`](../projets/portfolio/.chktexrc-en) :** `.chktexrc` inclut `-n26` pour autoriser l'espace avant la ponctuation double française (`:`, `;`, `?`, `!`), alors que `.chktexrc-en` retire `-n26` afin de signaler ces espaces comme fautives dans les projets rédigés en anglais (sélection automatique dans `lint-latex.ps1` si `english` figure dans `\documentclass[...]`).

---

## 2. Explication des arguments déclarés dans `.chktexrc`

### 2.1 `TabSize = 2`
Définit la largeur d'une tabulation (`2` espaces au lieu de `8` par défaut) pour aligner correctement les numéros de colonne dans les messages d'erreur et l'indicateur de positionnement. Aligné sur `.editorconfig` et `.vscode/settings.json`.

### 2.2 `CmdLine { -n1 -n12 -n24 -n26 -n36 -n46 }`
Injecte par défaut des options CLI ChkTeX (`-n<num>` = *nowarn*, désactive l'avertissement numéro `<num>`) :

| Option | Avertissement désactivé | Raison dans ce dépôt |
| :--- | :--- | :--- |
| `-n1` | *Command terminated with space* | Évite les faux positifs sur les macros de mise en page ou macros personnalisées sans argument (`\geometrieWord`, `\toprule`, etc.). |
| `-n12` | *Interword spacing (`\ `) should perhaps be used* | Règle héritée de la typographie anglaise (espace normale après abréviation type `etc.`) ; inutile sous `babel` français (`\frenchspacing`). |
| `-n24` | *Delete this space to maintain correct pagereferences* | Règle stricte interdisant tout espace ou saut de ligne avant `\label` / `\index` ; dans nos flottants, `\label{...}` est souvent écrit à la ligne après `\caption{...}`. |
| `-n26` | *You ought to remove spaces in front of punctuation* | **Essentiel en français** (absent de `.chktexrc-en`) : autorise l'espace avant `:`, `;`, `?`, `!`. Sans `-n26`, ChkTeX émet **162 faux positifs** sur `portfolio`. |
| `-n36` | *You should put a space in front of parenthesis* | Évite de signaler des formes françaises courantes comme `Quelle(s) question(s)` ou des macros suivies d'une parenthèse. |
| `-n46` | *Use `\( ... \)` instead of `$ ... $`* | Désactive l'obligation stricte d'écrire les maths en ligne uniquement avec `\(...\)`, afin de tolérer `$...$` dans les fichiers existants. |

### 2.3 `Linker { ... }`
Déclare les commandes qui doivent être **précédées d'une espace insécable `~`** (déclenche l'avertissement **ID `2`** si un espace normal précède l'appel) :
- S'ajoute aux valeurs globales TeX Live (`\ref`, `\vref`, `\pageref`, `\eqref`, `\cite`).
- Commandes ajoutées dans `.chktexrc` : `\autocite`, `\parencite`, `\supercite` (BibLaTeX) et `\cref`, `\Cref`, `\cpageref` (`cleveref`).
- Note : `\textcite` n'y figure volontairement pas car il agit souvent comme sujet grammatical (*« selon `\textcite{...}` »*).

### 2.4 `Silent { ... }`
Liste les commandes qui peuvent être suivies d'une espace sans déclencher l'avertissement **ID `1`** (*Command terminated with space*, utile si l'utilisateur réactive `-w1`) :
- Logos (`\LaTeX`, `\LuaLaTeX`, `\TeX`),
- Coupes structurelles (`\frontmatter`, `\mainmatter`, `\backmatter`, `\tableofcontents`, `\listoffigures`, `\listoftables`, `\printbibliography`),
- Tableaux `booktabs` et géométrie (`\toprule`, `\midrule`, `\bottomrule`, `\addlinespace`, `\syncKomaGeometry`).

### 2.5 `WipeArg { ... }`
Demande à ChkTeX de **neutraliser** (remplacer par un caractère neutre avant analyse) les arguments de macros contenant du texte littéral, des URLs, des chemins de fichiers ou des notes collaboratives, afin d'éviter des faux positifs à l'intérieur :
- **`{}`** : argument obligatoire (`\code:{}`, `\term:{}`, `\url:{}`, `\nolinkurl:{}`).
- **`[]`** : argument optionnel (`\lstinline:[]{}`, `\noteMarge:[]{}`, `\includestandalone:[]{}`).
- **Double crochets / accolades (`\todoH:[][]{}{}`) :** neutralise les deux options `[Profil][Couleur]` et les deux arguments `{Commentaire}{Texte}` pour éviter par exemple les fausses détections de guillemets ou de tirets dans les notes de relecture `\todoH`.
- **`\href:{}{}` :** neutralise l'URL et le libellé du lien.

---

## 3. Les avertissements réellement rencontrés sur `projets/portfolio/`

Il faut bien distinguer **trois sources** d'avertissements sur `portfolio` :

### 3.1 Avertissements `LuaLaTeX` à la compilation (`build/main.log` / `compile.ps1`)
La compilation réelle produit **0 erreur**, **0 `Overfull \hbox`** et seulement **2 avertissements** préexistants :
- `LaTeX Warning: Marginpar on page 16 moved.`
- `LaTeX Warning: Marginpar on page 18 moved.`

**Signification :** deux notes marginales `\todoH` placées sur la même zone verticale (pages 16 et 18) étaient trop proches l'une de l'autre ; LaTeX a simplement décalé l'une d'elles verticalement dans la marge pour éviter qu'elles ne se chevauchent.

---

### 3.2 Avertissements ChkTeX actifs sur `portfolio` (avec `.chktexrc` : **79** au total, **8** codes distincts)

Mesure exacte obtenue par `chktex -q -v0 -l .chktexrc main.tex` dans `projets/portfolio/` :

| Code | Nb | Message ChkTeX | Exemple concret dans `portfolio` | Action recommandée |
| :--- | :---: | :--- | :--- | :--- |
| **`2`** | 7 | ``Non-breaking space (`~') should have been used.`` | `\parencite{circusbaobab_site}` (`01-resume-activite.tex:L8`), `en \cref{...}` (`01-rapport-synthetique.tex:L98`) | **À corriger :** mettre `~` avant `\parencite`, `\cref`, `\cpageref`, etc. (règle `Linker`). |
| **`8`** | 6 | `Wrong length of dash may have been used.` | `\caption{Biologie - résultats}` (`resultat-examens-complementaires.tex:L3`) | **À corriger :** remplacer `-` entre espaces par `--` ou `---` (ou supprimer les espaces si mot composé). |
| **`11`** | 1 | `You should use \ldots to achieve an ellipsis.` | `« …...in patients... »` (`01-rapport-synthetique.tex:L128`) | **À corriger :** remplacer `...` littéral par `\ldots` (ou le caractère `…`). |
| **`13`** | 16 | ``Intersentence spacing (`\@') should perhaps be used.`` | `estimé via l’AMH. Cette information...` (`01-cas-clinique.tex:L57`) | **Faux positif français :** ChkTeX applique la règle anglaise après un sigle en majuscules suivi d'un point. Ignorable (ou `-n13`). |
| **`18`** | 12 | ```Use either `` or '' as an alternative to `"'.``` | `Ce "micro-rappel" précieux` (`02-impact-personnel.tex:L10`) | **À corriger :** utiliser les guillemets typographiques français `« ... »` (ou ` ``...''`). |
| **`29`** | 4 | `$\times$ may look prettier here.` | `\qtyproduct{74 x 68 x 53}{\mm}` (`01-cas-clinique.tex:L24`) | **Faux positif `siunitx` :** `x` est la syntaxe native de `\qtyproduct{...}`. Ignorable (ou ajouter `\qtyproduct:[]{}{}` à `WipeArg`). |
| **`37`** | 1 | `You should avoid spaces in front of parenthesis.` | `AND ("Heart Failure"[Mesh] )` (`01-rapport-synthetique.tex:L116`) | **À corriger :** supprimer l'espace parasite avant `)`. |
| **`44`** | 32 | `User Regex: -2:...` | `-2:Vertical rules in tables are ugly.` (`x2`, `les-hypotheses-diagnostiques.tex:L11`) et `-2:Use \toprule, \midrule, or \bottomrule from booktabs.` (`x30`) | **À corriger** sur les tableaux actifs (retirer les filets verticaux et `\hline`, utiliser `booktabs`) ; provient des expressions `UserWarnRegex` du `chktexrc` global TeX Live. |

---

### 3.3 Avertissements ChkTeX masqués par `.chktexrc` sur `portfolio` (**222** évités sur **294**)

Sans les protections de `.chktexrc` (`217` désactivés via `CmdLine` et `5` via `WipeArg` ; `+7` ajoutés par `Linker`, soit `294 - 222 + 7 = 79`), les types supplémentaires suivants apparaissent sur `portfolio` :
- **ID `26` (`162` occurrences) :** `You ought to remove spaces in front of punctuation.` — déclenché sur presque toutes les ponctuations doubles françaises (` :`, ` ;`, ` ?`, ` !`), par ex. `01-cas-clinique.tex:L13`. C'est cet avertissement qui apparaît si `.chktexrc-en` est utilisé à la place de `.chktexrc`.
- **ID `1` (`20` occurrences) :** `Command terminated with space.` — ex. `\geometrieWord` (`main.tex:L37`).
- **ID `46` (`16` occurrences) :** `Use \( ... \) instead of $ ... $.` — ex. `les-hypotheses-diagnostiques.tex:L22`.
- **ID `24` (`10` occurrences) :** `Delete this space to maintain correct pagereferences.` — `\label{...}` placé sur la ligne suivant `\caption{...}` (`les-hypotheses-diagnostiques.tex:L10`).
- **ID `36` (`5` occurrences) :** `You should put a space in front of parenthesis.` — ex. `Quelle(s) question(s)` (`03-approche-reflexive.tex:L14`).
- **ID `12` (`4` occurrences) :** ``Interword spacing (`\ ') should perhaps be used.`` — abréviation suivie d'un point (`01-cas-clinique.tex:L83`).
- **`WipeArg` (`5` faux positifs internes évités) :** empêche `1` alerte `8`, `2` alertes `18` et `2` alertes `32` (``Use ` to begin quotation, not '.``) dans les arguments de macros comme `\todoH[TestStyle]` (`01-cas-clinique.tex:L83`).

---

### 3.4 Avertissements propres à `lint-latex.ps1` (audit statique hors ChkTeX)

En plus de ChkTeX, [`lint-latex.ps1`](../.agents/skills/latex-quality-auditor/scripts/lint-latex.ps1) vérifie des règles syntaxiques propres au dépôt :
- `[PARAGRAPHE \\]` : usage de `\\` en fin de paragraphe au lieu d'une ligne vide (ex. `01-cas-clinique.tex:L56`, `01-rapport-synthetique.tex:L115-L117`).
- `[~ MANQUANT AVANT CITE]` / `[~ MANQUANT AVANT REF]` : espace simple avant citation/renvoi.
- `[\hline OBSOLÈTE]` / `[FILET VERTICAL |]` : redondant avec l'ID `44` de ChkTeX, couvrant aussi les fichiers d'archives dans `content/tables/`.
- `[\ref MANUEL]` : emploi de `\ref{...}` au lieu de `\cref{...}` / `\Cref{...}`.
