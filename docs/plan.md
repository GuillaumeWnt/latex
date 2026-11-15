# Plan d'exécution — Audit post-migration vers `latex/` et vérifications globales

- [x] Vérifier l'accès (lecture/écriture) et l'intégrité des configurations IA (`.agents/`, `.claude/`, `.gemini/`, `.github/`, `AGENTS.md`, fichiers `*ignore`/`*exclude`) et rechercher d'éventuels chemins cassés ou références résiduelles à `general`
- [x] Vérifier l'état et la configuration Git (`git status`, `git config`, remotes, `.gitignore`)
- [x] Vérifier les configurations VS Code (`.vscode/*`) et MCP (`.mcp.json`, `.agents/mcp_config.json`, `.agents/scripts/sync-mcp.ps1`, miroirs `.claude`/`.gemini`/`.vscode`)
- [x] Vérifier l'environnement Python `uv` / `.venv` (`pyproject.toml`, `uv.lock`, `uv run`, scripts utilitaires et tests d'écriture)
- [x] Compiler et contrôler les logs/lint de tous les projets (`projets/*`) et templates LaTeX (`templates/*`, y compris `slides/`)
- [x] Corriger ou signaler les anomalies détectées et synthétiser les résultats
