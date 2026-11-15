# Plan d'exécution — Passage aux liens relatifs, préparation migration `latex/` et vérifications

- [x] Convertir les liens internes absolus en liens relatifs dans `AGENTS.md`, `docs/historique.md` et `docs/compte-rendu-et-reponses.md` (et mettre à jour le titre de `docs/historique.md`)
- [x] Renommer le projet dans `pyproject.toml` (`general` -> `latex`), mettre à jour `uv.lock` via `uv lock` et actualiser `docs/migration-racine-latex.md`
- [x] Vérifier l'intégrité des liens relatifs, la synchronisation MCP (`.agents/scripts/sync-mcp.ps1`) et l'absence de références résiduelles à `latex/general`
- [x] Compiler `projets/portefolio_2` (`latexmk`), vérifier `build/main.log` et exécuter `lint-latex.ps1 -RunChkTeX`
- [x] Documenter les commandes finales à exécuter après fermeture d'Antigravity et VS Code pour finaliser le déplacement physique vers `c:\Users\guill\dev\perso\latex`
