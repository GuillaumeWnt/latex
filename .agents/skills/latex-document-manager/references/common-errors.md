# Erreurs Courantes & Diagnostics LuaLaTeX

---

## 1. Erreurs de Syntaxe & Caractères

### `! Undefined control sequence`
- **Cause :** Macro inconnue (faute de frappe ou package absent de `config/packages.sty`).
- **Correctif :** Inspecter la ligne `l.<num>` dans `build/main.log` et vérifier le nom ou le package.

### `Missing character: There is no → (U+2192) in font ...`
- **Cause :** Symbole mathématique (`\rightarrow`, `\alpha`, `\approx`) placé en mode texte hors `$ ... $`.
- **Correctif :** Toujours encadrer en mode mathématique (`$\rightarrow$`).

### `! Package lua-ul Error: Color support in lua-ul requires luacolor.`
- **Cause :** `lua-ul` appelé sans `luacolor` préalable.
- **Correctif :** Charger `\RequirePackage{luacolor}` avant `lua-ul` et compiler sous LuaLaTeX.

### `! Missing number, treated as zero. <to be read again> \group_end:`
- **Cause :** Compteur interne TeX (comme `\year`) passé en unité à `siunitx` (`\qtyrange{18}{65}{\year}`).
- **Correctif :** Utiliser une unité SI valide ou du texte avec espace insécable (`de 18 à 65~ans`).

---

## 2. Mise en Page, Polices & Bibliographie

### `Package scrlayer-scrpage Warning: \headheight to low`
- **Cause :** `\newgeometry` a omis `headheight` ou `footskip`.
- **Correctif :** Préciser `headheight=20pt, footskip=28pt` dans `\newgeometry`, ou utiliser `\geometrieWord`, `\geometrieLarge`, `\geometrieLibre`.

### `fontspec` : fichier de police introuvable
- **Cause :** Chemin `fonts/` absent ou option `font=...` pointant vers une police non installée.
- **Correctif :** Vérifier la présence des `.otf` dans `fonts/` ou basculer vers `font=heros` / `font=libertinus` dans `main.tex`.

### `Overfull \hbox (XXpt too wide)`
- **Cause :** Mot ou tableau dépassant `\linewidth`.
- **Correctif :** Reformuler, insérer `\-`, charger `xurl` pour les URL, ou utiliser les colonnes `Y` / `L{...}` de `tabularx`.

### `LaTeX Warning: Citation '...' undefined` ou `There were undefined references`
- **Cause :** Clé absente de `biblio/references.bib` ou passe Biber / LuaLaTeX manquante.
- **Correctif :** Vérifier la clé dans `biblio/references.bib` et relancer `latexmk`.
