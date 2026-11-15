# Guide de migration du dépôt `latex/general` vers `latex/`

Ce guide synthétise l'état préparé avant bascule et la procédure finale pour remonter le projet de `c:\Users\guill\dev\perso\latex\general` vers `c:\Users\guill\dev\perso\latex` avec un environnement `uv` neuf et un nouvel espace de travail Antigravity.

---

## 1. Travaux préparatoires déjà réalisés dans le dépôt

| Élément | Ce qui a été fait | Intérêt |
| :--- | :--- | :--- |
| **Liens Markdown internes** | Conversion des 27 liens absolus (`file:///.../latex/general/...`) en **liens relatifs** dans [`AGENTS.md`](../AGENTS.md), [`docs/historique.md`](historique.md) et [`docs/compte-rendu-et-reponses.md`](compte-rendu-et-reponses.md) | Portabilité totale (déplacement de dossier, clones Git, worktrees, affichage GitHub) |
| **Identité projet (`uv` & docs)** | Renommage `name = "latex"` dans [`pyproject.toml`](../pyproject.toml), mise à jour de `uv.lock` via `uv lock` et titre de [`docs/historique.md`](historique.md) | La nouvelle `.venv` créée dans `latex\` aura directement le nom `(latex)` |
| **Configurations outils / MCP** | Vérification de [`.vscode/tasks.json`](../.vscode/tasks.json), [`.agents/mcp_config.json`](../.agents/mcp_config.json) et [`.agents/scripts/sync-mcp.ps1`](../.agents/scripts/sync-mcp.ps1) | Tout repose déjà sur `${workspaceFolder}` ou des chemins relatifs |
| **Antigravity** | Choix utilisateur de repartir sur un historique neuf (`docs/historique.md` sert de mémoire inter-sessions) | Aucune manipulation des bases internes `conversation_summaries.db` / `conversations/*.db` nécessaire |

---

## 2. Pourquoi la bascule physique se fait juste après fermeture

Tant qu'Antigravity (`agy.exe --add-dir=...\latex\general`) et VS Code (`Code.exe`, `pet.exe`, `pylance`) sont ouverts sur `general\`, ils maintiennent des verrous de fichiers Windows et le répertoire de travail courant (`cwd`) de l'agent pointe sur `general\`. Le déplacement du dossier et la recréation finale de `.venv` doivent donc être lancés dans un PowerShell externe une fois ces deux applications fermées.

> [!WARNING]
> **Ne pas utiliser de jonction NTFS `latex\general -> latex` :** créer une jonction vers son propre dossier parent provoquerait une boucle infinie (`latex\general\general\...`).

---

## 3. Commandes finales à exécuter (Antigravity & VS Code fermés)

1. Commiter les derniers changements dans `general\` (liens relatifs, `pyproject.toml`, `uv.lock`, `docs/`).
2. **Fermer complètement Antigravity et VS Code**.
3. Ouvrir un terminal PowerShell dans `C:\Users\guill` et exécuter :

```powershell
$root = "C:\Users\guill\dev\perso\latex"
$old  = Join-Path $root "general"

# 1. Supprimer l'ancienne .venv (ses scripts activate et .exe codent l'ancien chemin en dur)
if (Test-Path (Join-Path $old ".venv")) {
    Remove-Item -Path (Join-Path $old ".venv") -Recurse -Force
}

# 2. Déplacer tout le contenu (dont .git, .agents, .vscode, .gitignore, etc.) vers latex\
Get-ChildItem -Path $old -Force | ForEach-Object {
    Move-Item -Path $_.FullName -Destination $root -Force
}

# 3. Supprimer le dossier general devenu vide
Remove-Item -Path $old -Force

# 4. Recréer la .venv avec uv et vérifier Git + Python + MCP
Set-Location $root
uv sync
uv run python -c "import sys, matplotlib, numpy; print(sys.executable)"
powershell -NoProfile -ExecutionPolicy Bypass -File .\.agents\scripts\sync-mcp.ps1
git status -sb
```

4. Rouvrir Antigravity (et/ou VS Code) directement sur **`C:\Users\guill\dev\perso\latex`** et vérifier dans cette nouvelle session le chargement des MCP et la compilation de `projets/portefolio_2` (`latexmk`).
