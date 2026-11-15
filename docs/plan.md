# Plan d'exécution — Liens retour Annexe A, couleurs des hyperliens, note `cp/j` et numéros de sous-sections

- [x] Ajouter les ancres de retour dans le texte (Chap. III § 1.9, Chap. V § 1.2, Chap. VI temporaire) et corriger le renvoi de la p. 50 vers la page 2 de `ExamenParacliniqueCasM2.pdf`
- [x] Implémenter le lien de retour en pied de page sur les 4 pages de l'Annexe A (`portefolio-style.sty` & `backmatter/appendix-a.tex`, avec note de marge verte `guillaume` + commentaire LaTeX sur la page 4)
- [x] Aligner la couleur du numéro `\subsectionformat` sur celle du titre (`CoverPlum`) dans `config/portefolio-style.sty`
- [x] Ajouter la note de bas de page explicative pour `cp/j` à la page 24 (`content/03-cas-therapeutique/01-cas-clinique.tex`)
- [x] Définir une palette éditoriale sobre de liens hypertexte en mode `screen` (`config/portefolio-style.sty`) et protéger la TOC/LOF/LOT ainsi que les surlignages `\todoH` (`config/macros.sty` + rétroportage du garde-fou `\todoH` dans `templates/template_officiel`)
- [x] Capitaliser les explications détaillées (bonnes pratiques couleurs de liens & liens bidirectionnels d'annexe) dans `projets/portefolio_2/docs/questions-typographie-et-latex.md` et mettre à jour `docs/historique.md`
- [x] Compiler `portefolio_2` (`latexmk`), vérifier `build/main.log`, exécuter `chktex` / `lint-latex.ps1` et contrôler visuellement les PNGs (TOC, p. 24, p. 50, p. 59, Annexe A p. 61–64, `\todoH`) et la non-régression de `templates/template_officiel`
