# Guide des Packages Modernes (`config/packages.sty`)

Inventaire des packages configurés par défaut dans `templates/template_officiel/config/packages.sty` :

---

## 1. Moteur, Polices & Microtypographie (LuaLaTeX)
- **`iftex` + `fontspec`** : Chargement natif des polices OpenType/TrueType locales depuis `fonts/` (`TeX Gyre Heros` avec repli système, `TeX Gyre Cursor` en chasse fixe, options `font=libertinus|heros|calibri|standard`).
- **`microtype`** : Protrusion optique des marges et expansion subtile des caractères.
- **`luacolor` + `lua-ul`** : Surlignage et soulignement compatibles UTF-8 et césures sous LuaLaTeX (remplace `soul` pour le texte courant).

## 2. Mise en Page, Langues & Géométrie
- **`scrhack`** : Corrige les incompatibilités de paquets tiers avec KOMA-Script.
- **`scrlayer-scrpage`** : En-têtes/pieds KOMA (`autooneside=false`, filets conditionnels). Remplace `fancyhdr`.
- **`geometry` + `pdflscape` + `multicol`** : Bascules de marges (`\geometrieWord`, `\geometrieLarge`), pages paysage et multi-colonnes.
- **`babel` (`[english, french]`) + `csquotes`** : Typographie française moderne (`\frenchsetup{StandardLists=true, TocPartNameFull=false, SuppressWarning=true}`) et guillemets automatiques `\enquote{...}`.

## 3. Sciences, Mathématiques & Tableaux
- **`amsmath`, `mathtools`, `amssymb`, `amsthm`** : Équations, délimiteurs extensibles (`\abs`, `\norm`, `\scal`) et théorèmes.
- **`siunitx` (v3, `locale = FR`)** : Unités et nombres formatés (`\qty{25}{\meter\per\second}`, `\qtyrange{10}{20}{\kilo\gram}`, unités personnalisées `\iter`, `\bar`).
- **`booktabs`, `tabularx`, `longtable`, `array`, `makecell`, `multirow`, `ragged2e`** : Tableaux sans filets verticaux avec colonnes prédéfinies `L{...}`, `C{...}`, `R{...}`, `Y`.
- **`enumitem`** : Listes personnalisables (`nosep`, `leftmargin=*`).

## 4. Graphiques, Encadrés & Code
- **`graphicx` + `caption` + `subcaption`** : Figures et sous-figures `(a)`, `(b)` (remplace `subfig`/`subfigure`).
- **`tikz` + `standalone` + `pgfplots` (`compat=1.18`)** : Schémas vectoriels et courbes tracées depuis `data/*.csv`.
- **`tcolorbox` (`[skins, breakable]`)** : Boîtes `callout`, `attentionbox`, `hypothesis`, `definitionbox`, `boiteSynthese`, `cadreFigure`.
- **`listings`** : Inclusion de codes sources testables depuis `listings/` via `\lstinputlisting` (style `mythesiscode`, sans `-shell-escape`).
- **`pdfpages` + `ocgx2`** : Insertion d'annexes PDF (`\includepdfpaper`) et calques interactifs écran/impression (`\ocgbutton`, `\ocgstack`).

## 5. Révisions, Bibliographie & Liens
- **`marginnote` + `todonotes` + `pdfcomment`** : Manchettes éditoriales (`\noteMarge`) et révisions collaboratives (`\todoH`).
- **`biblatex` (`backend=biber`, `style=biblio/custom-style`)** : Citations et bibliographie programmables.
- **`xurl` + `hyperref` + `bookmark` + `cleveref`** : Césure des URL, signets PDF et renvois intelligents (`\cref`, `\Cref`, `\cpageref`).
