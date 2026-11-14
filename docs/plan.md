# Plan d'Exécution — Demande Courante

- [x] Enrichir proprement le socle générique de `templates/template_officiel/` (`ClasseGuillaume.cls`, `config/packages.sty`, `config/macros.sty`, `README.md`, `backmatter/appendix-a.tex`) : options `bibstyle`, `spacing`, paquets `rotating`/`xltabular`, repli local `Calibri`/`Asap`/`ComicSansMS` et garde `\todoH` sans modifier le rendu par défaut
- [x] Créer l'arborescence propre de `projets/portefolio_2/` depuis `templates/template_officiel/` (racine stricte) et y rapatrier 100 % des ressources, polices, pages de garde, médias et fichiers orphelins de `projets/portefolio_1/`
- [x] Implémenter `config/portefolio-style.sty` et `main.tex` dans `projets/portefolio_2/` pour reproduire à 100 % le rendu visuel de `portefolio_1` avec une cohabitation KOMA-Script + `geometry` propre et sans conflit de paquets
- [x] Migrer les pages de garde, chapitres, tableaux et annexes vers `frontmatter/`, `content/`, `content/tables/` et `backmatter/` sans modifier un seul mot du contenu rédactionnel, en corrigeant uniquement les erreurs techniques LaTeX
- [x] Compiler `projets/portefolio_2/` à froid (`latexmk`), auditer `build/main.log` + `lint-latex.ps1` / `chktex` et contrôler visuellement les pages PNG comparées à `portefolio_1`
- [x] Vérifier la non-régression à froid de `templates/template_officiel/` et mettre à jour `docs/historique.md`
