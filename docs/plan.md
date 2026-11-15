# Plan d'exécution — Correction `audit-bib.ps1`, renommage `portfolio` et diagnostic MCP

- [x] Corriger le chemin par défaut dans `.agents/skills/zotero-biblio/scripts/audit-bib.ps1` (`bib/references.bib` -> `biblio/references.bib`) et valider son exécution
- [x] Recenser toutes les occurrences de `portefolio_2` dans le dépôt, renommer `projets/portefolio_2` en `projets/portfolio` et mettre à jour les références associées
- [x] Recompiler `projets/portfolio` (`clean.ps1 -All` + `compile.ps1`), vérifier `build/main.log` (0 erreur) et exécuter `lint-latex.ps1`
- [x] Diagnostiquer pourquoi les MCP `latex-compiler` et `latex-workshop-assistant` ne sont pas disponibles et capitaliser l'analyse dans `docs/`
