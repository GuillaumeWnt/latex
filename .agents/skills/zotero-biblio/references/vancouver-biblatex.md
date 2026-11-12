# Guide BibLaTeX : Style `custom-style` & Option `vancouver`

Ce guide décrit l'intégration BibLaTeX/Biber dans `templates/template_officiel/` et ses déclinaisons.

---

## 1. Configuration par défaut dans `template_officiel`

Dans `config/packages.sty`, BibLaTeX est configuré avec `backend=biber` et s'appuie sur les fichiers locaux :
- `biblio/custom-style.bbx` (formatage de la bibliographie auteur-année)
- `biblio/custom-style.cbx` (formatage des citations `\parencite` et `\textcite`)
- `\addbibresource{biblio/references.bib}`

### Variante numérique (style Vancouver)
Si un livrable exige des citations numériques séquentielles, adapter le chargement dans `config/packages.sty` du projet (et documenter si pertinent dans `template_officiel` via une option de classe) :

```latex
\usepackage[
  backend=biber,
  style=vancouver,
  sorting=none,
  giveninits=true,
  maxcitenames=2,
  maxbibnames=6,
  doi=true,
  url=true,
  isbn=false
]{biblatex}
\addbibresource{biblio/references.bib}
```

---

## 2. Syntaxe de citation dans le texte

| Commande | Rendu `custom-style` (défaut) | Exemple d'usage |
| :--- | :--- | :--- |
| `~\parencite{cle}` | `(Dupont, 2024)` | `La méthode converge rapidement~\parencite{dupont2024}.` |
| `\textcite{cle}` | `Dupont (2024)` | `Comme le montre \textcite{dupont2024}, le modèle...` |
| `~\parencite[p.~12]{cle}` | `(Dupont, 2024, p. 12)` | `Voir la démonstration complète~\parencite[p.~12]{dupont2024}.` |
| `~\autocite{cle}` *(vancouver)* | `[1]` ou `(1)` | `Des travaux récents~\autocite{dupont2024} confirment...` |

> **Typographie :** toujours placer une espace insécable `~` devant `\parencite` et `\autocite` en milieu/fin de phrase. Ne pas insérer d'espace avant une ponctuation forte si le style la place déjà, mais en français la citation parenthétique précède le point final : `... résultat~\parencite{cle}.`.

---

## 3. Normes de rédaction des entrées `.bib`

```bibtex
@article{smith2024deep,
  author       = {Smith, John and Doe, Jane},
  title        = {Deep Learning for Technical Document Analysis: A Systematic Review},
  journaltitle = {Journal of Computational Typography},
  date         = {2024-03},
  volume       = {12},
  number       = {3},
  pages        = {145--162},
  doi          = {10.1016/j.jct.2024.01.015},
  urldate      = {2024-05-10}
}
```

### Règles Biber essentielles
1. **Casse des acronymes et noms propres :** entourer d'accolades (`{LaTeX}`, `{IEEE}`, `{PID}`, `{France}`).
2. **Noms d'auteurs :** toujours utiliser `Nom, Prénom and Nom2, Prénom2` (séparateur `and`, jamais `&` ou `,`).
3. **DOI sans préfixe URL :** écrire `10.1016/...` sans `https://doi.org/`.
4. **Dates ISO :** préférer `date = {YYYY-MM-DD}` ou `year = {YYYY}` ; éviter les dates textuelles non parsables par Biber.
5. **Plages de pages :** utiliser le double tiret `--` (`145--162`).
6. **Échappement des caractères réservés :** protéger `%`, `&`, `#`, `_` dans les titres/résumés (hors champs `url` et `doi` gérés nativement par BibLaTeX).
