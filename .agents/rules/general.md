# Règles LaTeX Générales : KOMA-Script, Packages & Typographie

## 1. Architecture Hybride KOMA-Script (`scrbook`) + `geometry`

`ClasseGuillaume.cls` repose sur `scrbook` combiné à `geometry` :
1. **Options `typearea` avant `\LoadClass` :** Passer `twoside`, `open`, `BCOR`, `DIV` avant `\LoadClass{scrbook}`, puis activer `usegeometry=true` (évite les recalculs multiples et les avertissements `Bad type area settings`).
2. **Synchronisation automatique :** Tout appel à `\newgeometry` ou `\restoregeometry` déclenche `\syncKomaGeometry` (`\par@updaterelative` + `headwidth=text, footwidth=text`).
3. **Dimensions d'en-tête/pied obligatoires :** Dans toute nouvelle géométrie (`\newgeometry`), conserver `headheight=20pt` (ou plus si en-tête multiligne) et `footskip=26pt` à `30pt` pour éviter les avertissements `scrlayer-scrpage` et `Overfull \vbox`.
4. **Saut de page préalable :** Préfixer tout changement de géométrie (`\geometrieWord`, `\geometrieLarge`, `\geometrieStandard`, `\geometrieLibre`, `pageDesign`) par `\cleardoublepage` (déjà intégré dans les macros de `config/macros.sty`).

---

## 2. Moteur, Ordre de Chargement & Packages Bannis

- **Moteur requis :** **LuaLaTeX** (`fontspec`, `luacolor`, `lua-ul`).
- **Ordre critique des packages dans `config/packages.sty` :**
  `scrhack` $\rightarrow$ `xcolor` $\rightarrow$ `fontspec` $\rightarrow$ `babel` (`[english, french]` par défaut ou `[french, english]` avec l'option `english`) $\rightarrow$ `csquotes` $\rightarrow$ `amsmath`/`mathtools` $\rightarrow$ `siunitx` $\rightarrow$ `biblatex` $\rightarrow$ `xurl` $\rightarrow$ `hyperref` $\rightarrow$ `bookmark` $\rightarrow$ `cleveref`.
- **Packages/commandes bannis :**
  - Jamais `soul` sous LuaLaTeX pour surligner $\rightarrow$ utiliser `luacolor` + `lua-ul` (`\highLight`).
  - Jamais `fancyhdr` avec KOMA-Script $\rightarrow$ utiliser `scrlayer-scrpage`.
  - Jamais `subfig` ni `subfigure` $\rightarrow$ utiliser `subcaption`.
  - Jamais `\frenchbsetup` $\rightarrow$ utiliser `\frenchsetup{StandardLists=true, TocPartNameFull=false, SuppressWarning=true}`.

---

## 3. Standards Typographiques (Français par Défaut / Anglais via `[english]`)

- **Langue du projet :** `ClasseGuillaume` utilise le français par défaut (`french`). L'option `\documentclass[english]{ClasseGuillaume}` bascule automatiquement `babel`, `siunitx` (`locale = US`, `range-phrase = { to }`), `cleveref`, les titres des boîtes, la liste des illustrations et `todonotes` en anglais (utiliser alors `.chktexrc-en` sans `-n26`).
- **Guillemets :** Utiliser `\enquote{...}` (`csquotes`, option `autostyle=true` adaptée à la langue active), jamais de guillemets droits `"..."`.
- **Tirets :** `-` (trait d'union), `--` (plages numériques `12--15`), `---` (incises).
- **Espaces insécables (`~`) :** Recommandées avant les citations en ligne (`~\autocite{...}`, `~\parencite{...}`, `~\cite{...}`, `~\supercite{...}` ; inutile devant `\textcite{...}` utilisé comme sujet), obligatoires avant les renvois croisés (`~\cref{...}`, `~\Cref{...}`, `~\cpageref{...}`), et gérées automatiquement entre nombres et unités par `\qty{...}{...}`.
- **Pureté du mode mathématique :** Tout symbole mathématique (`\rightarrow`, `\approx`, `\times`, lettres grecques) doit être encadré par `$...$` pour éviter les erreurs `Missing character` des polices OpenType textuelles.
