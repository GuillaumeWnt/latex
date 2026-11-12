# Guide d'Architecture Hybride KOMA-Script & `geometry`

Ce guide documente la cohabitation entre **KOMA-Script** (`scrbook`) et **`geometry`** dans `templates/template_officiel/` (`mythesis.cls`, `mythesis-*.clo`, `config/packages.sty`, `config/macros.sty`).

---

## 1. Principes de Synchronisation Sans Avertissement

1. **Options `typearea` passées avant `\LoadClass{scrbook}` :**
   Dans `mythesis.cls`, `twoside`, `open`, `BCOR` et `DIV` sont passés via `\PassOptionsToClass` avant `\LoadClass{scrbook}`, puis `usegeometry=true` est activé via `\KOMAoptions` (avec `headheight=20pt`, `footheight=20pt`). Appeler `\recalctypearea` après `geometry` écraserait `footskip` et produirait des avertissements `Bad type area settings`.
2. **Hook automatique `\syncKomaGeometry` :**
   Dans `config/packages.sty`, `etoolbox` accroche `\syncKomaGeometry` à `\newgeometry` et `\restoregeometry` :
   ```latex
   \newcommand{\syncKomaGeometry}{%
     \csname par@updaterelative\endcsname
     \KOMAoptions{headwidth=text, footwidth=text}%
   }
   \apptocmd{\newgeometry}{\syncKomaGeometry}{}{}
   \apptocmd{\restoregeometry}{\syncKomaGeometry}{}{}
   ```
   Ainsi, la largeur des filets d'en-tête/pied `scrlayer-scrpage` et les espacements KOMA restent toujours alignés sur `\textwidth`.
3. **Préservation de `BCOR` (`\mythesis@bcor`) :**
   Les profils `mythesis-print.clo` (`10mm`) et `mythesis-screen.clo` (`0mm`) définissent `\mythesis@bcor`, automatiquement réinjecté via `bindingoffset=\mythesis@bcor` dans `\geometrieWord` et `\geometrieLarge`.
4. **Dimensions d'en-tête/pied dans `\newgeometry` :**
   Toujours conserver `headheight=20pt` et `footskip=26pt` à `30pt` pour éviter `Package scrlayer-scrpage Warning: \headheight to low`.

---

## 2. Commandes & Environnements Disponibles (`config/macros.sty`)

| Macro / Environnement | Usage | Comportement |
| :--- | :--- | :--- |
| `\geometrieStandard` | Corps canonique KOMA | `\cleardoublepage` + `\restoregeometry` (`DIV=12`) |
| `\geometrieWord` | Relecture / annotations | Marges `2.5 cm`, `marginparwidth=2.0cm`, `marginparsep=2.5mm` |
| `\geometrieLarge` | Grands tableaux / planches | Marges `1.5 cm` latérales, `2.0 cm` haut/bas, `marginparwidth=0mm` |
| `\geometrieLibre{opts}` | Géométrie ponctuelle | Applique `opts` avec `headheight=20pt, footskip=28pt` par défaut |
| `WideGeometry` / `WordGeometry` | Blocs autonomes | Active la géométrie puis restaure `\geometrieStandard` en sortie |
| `pageDesign[opts]` | Couvertures / posters | Masque en-têtes et logo (`\masquerLogo`), puis restaure automatiquement la géométrie précédente (`\currentGeometryCmd`), le logo et `scrheadings` |
