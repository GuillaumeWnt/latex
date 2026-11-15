# Plan d'Exécution — Garde de hauteur automatique (`needspace`) sur les sections (`portefolio_2` & `template_officiel`)

- [x] Inspecter `ClasseGuillaume.cls`, `config/packages.sty`, `config/portefolio-style.sty` et `templates/template_officiel/` pour choisir l'architecture neutre et les seuils optimaux
- [x] Implémenter `\RequirePackage{needspace}` et les hooks automatiques dans `projets/portefolio_2/` (sans modifier le texte rédactionnel) et rétroporter proprement dans `templates/template_officiel/` (+ `README.md`)
- [x] Compiler `projets/portefolio_2/` et `templates/template_officiel/`, vérifier `0` erreur / `Overfull` / `Underfull`, exécuter `chktex` et inspecter les rendus PNG (notamment les anciennes coupures p. 11 et p. 50 de `portefolio_2`)
- [x] Mettre à jour la documentation (`questions-typographie-et-latex.md` § 11 et `docs/historique.md`) avec les résultats observés
