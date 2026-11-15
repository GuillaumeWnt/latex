# Plan d'exécution — Nettoyage des 2 MCP LaTeX et harmonisation globale/locale

- [x] Déplacer `io.draw/mcp` et `brave-search` vers le chef global `C:\Users\guill\.agents\mcp_config.json` (sans aucun MCP LaTeX) et créer/brancher `sync-mcp-global.ps1` dans `deploy-and-sync-global.ps1`
- [x] Supprimer `latex-compiler` et `latex-workshop-assistant` (et retirer `io.draw/mcp` + `brave-search`) de `.agents/mcp_config.json` local, mettre à jour `.agents/subagents/compiler-debugger.md` et exécuter `.agents/scripts/sync-mcp.ps1`
- [x] Mettre à jour `docs/compte-rendu-et-reponses.md` et `docs/historique.md` avec la nouvelle séparation MCP global vs local
- [x] Vérifier par script l'alignement strict de tous les fichiers MCP globaux et locaux, le statut Git et les liens
