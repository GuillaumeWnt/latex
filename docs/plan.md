# Plan d'Exécution — Réponses Techniques, Interligne, Unités & Notes `guillaume` (`portefolio_2`)

- [x] Auditer dans `projets/portefolio_2/` : métriques exactes d'interligne (Word vs `setspace`/Calibri + listes `\singlespacing`), tous les nombres `$...$` et unités dans `content/` & `tables/`, et les emplacements de citation de `siep_formation_524` et `lagedamon2025accompagnement`
- [x] Mettre à jour `projets/portefolio_2/config/portefolio-style.sty` et `main.tex` : rétablir un vrai double interligne cohérent avec les consignes, forcer `\singlespacing` dans les listes `itemize`/`enumerate`, et définir un style vert dédié `author=guillaume` pour `\todoH`
- [x] Moderniser conformément aux bonnes pratiques LaTeX (sans modifier aucun mot) tous les nombres entourés de `$...$`, grandeurs et unités (`siunitx` `\qty` / `\qtyproduct` / `\num`, texte courant) et vérifier `mode=match` pour garder la police Calibri
- [x] Ajouter les deux notes de marge vertes (`author=guillaume`) signalant les données manquantes de `siep_formation_524` et `lagedamon2025accompagnement`
- [x] Compiler à froid `projets/portefolio_2/`, contrôler le rendu PNG (listes, interligne, chiffres/unités en Calibri, notes vertes `guillaume`, zéro erreur / zéro `Overfull \hbox`), enrichir la documentation `.md` dans `projets/portefolio_2/docs/` et mettre à jour `docs/historique.md`
