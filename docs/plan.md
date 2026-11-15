# Plan d'Exécution — Option 1 sur les listes à puces (`portefolio_2` uniquement)

- [x] Auditer les emplacements exacts des 28 listes `\begin{itemize}` actives et vérifier l'absence de rétroportage ou de modification rédactionnelle
- [x] Configurer l'Option 1 dans `projets/portefolio_2/config/portefolio-style.sty` (retrait du `\singlespacing` global par défaut et ajout de la clé `enumitem` `compact`)
- [x] Appliquer `[compact]` aux listes courtes ciblées dans `projets/portefolio_2/content/` en conservant l'intégralité du texte intact
- [x] Compiler `projets/portefolio_2/` (`latexmk`), vérifier `0` erreur / `Overfull` / `Underfull` et exécuter `chktex` + inspection visuelle (listes courtes vs longues)
- [x] Mettre à jour la documentation (`questions-typographie-et-latex.md` § 12 et `docs/historique.md`) avec le résultat vérifié
