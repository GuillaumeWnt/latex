# Guide BibLaTeX : Styles Libres & Bonnes Pratiques `.bib`

Ce guide présente l'architecture **BibLaTeX + Biber** de `templates/template_officiel/` tout en laissant le choix du style bibliographique et des commandes de citation totalement libre selon les besoins de chaque document.

---

## 1. Configuration modulable dans `config/packages.sty`

Par défaut, `templates/template_officiel/config/packages.sty` charge `biblatex` avec `backend=biber` et pointe vers les fichiers `biblio/custom-style.bbx`/`.cbx` à titre d'exemple prêt à compiler (`biblio/references.bib`).

Rien n'est figé : dans tout projet, tu peux conserver cette base ou la remplacer par le style standard de ton choix (`authoryear`, `numeric`, `ieee`, `vancouver`, `alphabetic`, etc.), par exemple :

```latex
\usepackage[
  backend=biber,
  style=numeric,    % ou authoryear, ieee, vancouver, alphabetic...
  sorting=none,
  giveninits=true,
  doi=true,
  url=true,
  isbn=false
]{biblatex}
\addbibresource{biblio/references.bib}
```

---

## 2. Commandes de citation courantes (souples selon le style)

| Commande | Usage typique | Exemple d'usage |
| :--- | :--- | :--- |
| `~\autocite{cle}` | Commande polyvalente (s'adapte au style actif) | `La méthode converge rapidement~\autocite{dupont2024}.` |
| `~\parencite{cle}` | Citation entre parenthèses (auteur-année / parenthétique) | `Voir la démonstration complète~\parencite[p.~12]{dupont2024}.` |
| `\textcite{cle}` | Citation narrative intégrée comme sujet/nom | `Comme le montre \textcite{dupont2024}, le modèle...` |
| `~\cite{cle}` | Appel direct (utile en style numérique ou libre) | `Des travaux récents~\cite{dupont2024} confirment...` |
| `~\supercite{cle}` | Appel en exposant (si souhaité) | `Résultat connu~\supercite{dupont2024}.` |

> **Bonnes pratiques typographiques :** placer une espace insécable `~` devant les appels en ligne (`\autocite`, `\parencite`, `\cite`, `\supercite`) pour éviter une coupure de ligne orpheline, et conserver `\textcite{...}` sans `~` lorsqu'il ouvre un groupe nominal. En français, la citation précède généralement le point final (`... résultat~\autocite{cle}.`).

---

## 3. Bonnes pratiques de rédaction des entrées `.bib`

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

### Hygiène Biber recommandée (indépendante du style)
1. **Format de clé libre :** conserver les clés Zotero existantes ou adopter un schéma lisible (`auteur2024mot`) — éviter simplement les doublons, espaces et accents.
2. **Casse des acronymes et noms propres :** entourer d'accolades (`{LaTeX}`, `{IEEE}`, `{PID}`, `{France}`).
3. **Noms d'auteurs :** utiliser `Nom, Prénom and Nom2, Prénom2` (séparateur `and`).
4. **DOI sans préfixe URL :** écrire `10.1016/...` sans `https://doi.org/` afin que BibLaTeX construise le lien proprement.
5. **Dates ISO :** préférer `date = {YYYY-MM-DD}` (ou `YYYY-MM`, `year = {YYYY}`).
6. **Plages de pages :** utiliser le double tiret `--` (`145--162`).
7. **Échappement des caractères réservés :** protéger `%`, `&`, `#`, `_` dans les titres/résumés (hors champs `url` et `doi` gérés nativement par BibLaTeX).
