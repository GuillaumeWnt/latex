# Plan d'Exécution — Demande Courante

- [x] Déplacer `docs/exemples-slides/` vers `templates/exemples-slides/`, exclure ce dossier dans `.gitignore` et mettre à jour les liens dans le skill `latex-slides` et `docs/compte-rendu-et-reponses.md`
- [x] Modifier la règle globale (`C:\Users\guill\.agents\AGENTS.md`, `rules/01-git-et-planification.md`, `plugin.json`) pour placer `plan.md` et `historique.md` dans `docs/`, et exécuter `deploy-and-sync-global.ps1`
- [x] Déplacer `plan.md` → `docs/plan.md` et `historique.md` → `docs/historique.md`, et mettre à jour toutes les références locales (`AGENTS.md`, `knowledge-curator.md`, `docs/compte-rendu-et-reponses.md`)
- [x] Vérifier `git status --ignored` (non-suivi des exemples tout en gardant les `*.png` des projets suivis) et valider la cohérence globale des liens/règles
