# Guide de migration du dépôt `latex/general` vers `latex/`

Ce guide détaille comment remonter proprement le projet actuellement situé dans `c:\Users\guill\dev\perso\latex\general` directement à la racine `c:\Users\guill\dev\perso\latex`, sans casser Git, l'environnement virtuel `uv`, ni perdre le rattachement du projet et des discussions Antigravity.

---

## 1. État des lieux vérifié sur ce poste

| Composant | État actuel constaté | Impact lors du déplacement vers `latex\` |
| :--- | :--- | :--- |
| **Arborescence disque** | `c:\Users\guill\dev\perso\latex\` ne contient que le dossier `general\` | Aucun conflit de nom lors de la remontée des fichiers d'un niveau |
| **Dépôt Git** | `.git\` se trouve dans `general\`, avec `origin = git@github.com:GuillaumeWnt/latex.git` | Le dépôt distant porte déjà le nom `latex` ; déplacer `.git\` conserve tout l'historique |
| **Arbre Git courant** | **128 suppressions non commitées** (`D` sur `plan.md`, `projets/portefolio_0/`, `projets/portefolio_1/`) | À statuer **avant** la migration (commit, `git restore` ou `git stash`) pour ne rien mélanger |
| **Python / `uv`** | `pyproject.toml` (`name = "general"`), `uv.lock`, `.venv/` (ignorée par `.gitignore`) | `.venv/` code en dur `...\latex\general\.venv` dans `activate*`, `pyvenv.cfg` (`prompt = general`) et les shebangs des `.exe` (`Scripts\f2py.exe`, etc.) : il faut **supprimer `.venv/` et la recréer via `uv sync`** |
| **Configs outils / MCP** | `.vscode/tasks.json`, `.vscode/mcp.json`, `.mcp.json`, `.claude/mcp.json`, `.gemini/mcp_config.json`, `.agents/scripts/sync-mcp.ps1` | Utilisent déjà `${workspaceFolder}` ou des chemins relatifs : rien à modifier |
| **Liens Markdown dans le dépôt** | **27 liens absolus** `file:///c:/Users/guill/dev/perso/latex/general/...` répartis dans **3 fichiers** | À mettre à jour dans `AGENTS.md` (13), `docs/historique.md` (7 + titre) et `docs/compte-rendu-et-reponses.md` (7) |
| **Antigravity (Projet)** | `C:\Users\guill\.gemini\config\projects\f700c676-4f3f-40ce-9ad9-920f5eb12cd0.json` (`name: "general"`, `folderUri: "file:///c%3A/Users/guill/dev/perso/latex/general"`, permissions mémorisées) | Sans mise à jour, Antigravity créera un nouveau projet vide pour `latex\` sans les permissions ni les 16 discussions liées |
| **Antigravity (Discussions)** | `C:\Users\guill\.gemini\antigravity\conversation_summaries.db` (16 discussions liées à `project_id = f700c676-...` et `workspace_uris`), 18 `.db` dans `conversations\`, et `agyhub_summaries_proto.pb` | Les URI sont stockées en SQLite et en Protobuf (longueurs préfixées en varint) ; une édition texte brute des blobs binaires les corromprait |
| **VS Code** | `AppData\Roaming\Code\User\globalStorage\storage.json` | Contient déjà `file:///c%3A/Users/guill/dev/perso/latex` sous `__default__profile__` |

> [!WARNING]
> **Ne pas créer de jonction NTFS `latex\general -> latex` :** comme `general` serait un sous-dossier direct de sa propre cible `latex`, une jonction créerait une boucle infinie (`latex\general\general\...`) qui bloquerait `Get-ChildItem -Recurse`, `latexmk`, les recherches de fichiers et les outils IA.

---

## 2. Procédure de migration propre (pas à pas)

### Étape 0 — Prérequis, tri Git et sauvegardes

1. **Régler l'état Git en cours :** décider si les 128 suppressions actuelles (`plan.md`, `projets/portefolio_0/`, `projets/portefolio_1/`) doivent être commitées ou restaurées avant de déplacer le dossier.
2. **Sauvegarder les données Antigravity** avant toute manipulation :
   ```powershell
   $backup = "C:\Users\guill\Desktop\backup_antigravity_gemini_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
   Copy-Item -Path "$env:USERPROFILE\.gemini\antigravity" -Destination "$backup\antigravity" -Recurse
   Copy-Item -Path "$env:USERPROFILE\.gemini\config\projects" -Destination "$backup\projects" -Recurse
   ```
3. **Fermer toutes les applications ouvertes sur le projet :**
   - Quitter complètement **Antigravity** (vérifier qu'aucun processus en arrière-plan ne maintient les fichiers `conversation_summaries.db-wal` / `-shm` ouverts).
   - Fermer **VS Code**, tout terminal PowerShell positionné dans `latex\general`, et tout processus Python ou serveur MCP actif.

---

### Étape 1 — Remonter les fichiers de `latex\general\` vers `latex\`

Dans un nouveau terminal PowerShell ouvert **en dehors** du dossier `latex` (par exemple dans `C:\Users\guill`) :

```powershell
$root = "C:\Users\guill\dev\perso\latex"
$old  = Join-Path $root "general"

# 1. Supprimer l'ancien .venv (inutile de le déplacer, il contient des chemins codés en dur)
if (Test-Path (Join-Path $old ".venv")) {
    Remove-Item -Path (Join-Path $old ".venv") -Recurse -Force
}

# 2. Déplacer tous les éléments (y compris cachés : .git, .agents, .vscode, etc.)
Get-ChildItem -Path $old -Force | ForEach-Object {
    Move-Item -Path $_.FullName -Destination $root -Force
}

# 3. Supprimer le dossier general devenu vide
Remove-Item -Path $old -Force

# 4. Vérifier que Git fonctionne depuis la nouvelle racine
git -C $root status -sb
git -C $root remote -v
```

---

### Étape 2 — Recréer proprement la `.venv` avec `uv`

Ne jamais déplacer ni éditer à la main `.venv/` (les scripts `activate`, `Activate.ps1`, `activate.bat`, `pyvenv.cfg` et les `.exe` dans `.venv\Scripts\` embarquent l'ancien chemin absolu).

Depuis `C:\Users\guill\dev\perso\latex` :

1. *(Recommandé)* Renommer le projet dans `pyproject.toml` (`name = "general"` → `name = "latex"`).
2. Mettre à jour `uv.lock` proprement via `uv` (ne jamais éditer `uv.lock` à la main) et recréer `.venv` :
   ```powershell
   cd C:\Users\guill\dev\perso\latex
   uv lock
   uv sync
   ```
3. Vérifier l'environnement :
   ```powershell
   uv run python -c "import sys, matplotlib, numpy; print(sys.executable)"
   ```
   Le chemin affiché doit être `C:\Users\guill\dev\perso\latex\.venv\Scripts\python.exe` et l'invite du prompt virtuel devient `(latex)`.

---

### Étape 3 — Mettre à jour les liens internes du dépôt

Corriger les 27 liens absolus `file:///c:/Users/guill/dev/perso/latex/general` → `file:///c:/Users/guill/dev/perso/latex` dans les 3 fichiers suivants :

- `AGENTS.md` (lignes 10–12, 43, 45, 53–60)
- `docs/historique.md` (titre ligne 1 + lignes 24, 29, 30, 35–38)
- `docs/compte-rendu-et-reponses.md` (lignes 12, 13, 20, 29–31, 49)

---

### Étape 4 — Gérer le projet et les discussions Antigravity

Deux stratégies sont possibles selon votre priorité entre **zéro risque sur les bases internes** et **rattachement complet des 16 discussions existantes**.

#### Option A — La plus sûre (JSON du projet seul, ou nouveau projet + `docs/historique.md`)

1. Ouvrir `C:\Users\guill\.gemini\config\projects\f700c676-4f3f-40ce-9ad9-920f5eb12cd0.json` (Antigravity fermé).
2. Mettre à jour uniquement ces deux champs JSON :
   - `"name": "general"` → `"name": "latex"`
   - `"folderUri": "file:///c%3A/Users/guill/dev/perso/latex/general"` → `"folderUri": "file:///c%3A/Users/guill/dev/perso/latex"`
3. Rouvrir Antigravity sur `C:\Users\guill\dev\perso\latex`.
   - **Avantage :** fichier JSON standard, aucun binaire ni base SQLite modifié ; vos `permissionGrants` (commandes autorisées) et le `project_id` (`f700c676-4f3f-40ce-9ad9-920f5eb12cd0`) sont conservés.
   - **Limite :** les anciennes discussions conservent l'ancien `workspace_uris` dans `conversation_summaries.db` et leurs métadonnées internes (`conversations/<id>.db`), même si elles restent liées au même `project_id`. Si l'UI ne les rattache pas correctement ou signale le dossier disparu, vous pouvez aussi ouvrir `latex\` comme projet neuf et vous appuyer sur `docs/historique.md` pour poursuivre avec tout le contexte technique.

*(Note : le projet orphelin `2a02392c-3242-4526-be42-40ae1b0dd94d.json` nommé `mon-projet` et pointant vers `.../latex/general/mon-projet` correspond à un ancien sous-dossier déjà supprimé.)*

#### Option B — Migration complète des bases SQLite / Protobuf (avancée, non documentée officiellement)

> [!CAUTION]
> Cette approche agit sur les fichiers internes d'Antigravity (hors API officielle). Ne l'exécuter **qu'après la sauvegarde de l'étape 0** et avec **Antigravity complètement fermé**. Ne **jamais** faire un chercher/remplacer texte brut sur `raw_summary`, `trajectory_metadata_blob` ou `agyhub_summaries_proto.pb` : dans ces blobs Protobuf, la chaîne `file:///c:/Users/guill/dev/perso/latex/general` (46 octets, préfixe `0x2E`) et ses messages englobants sont préfixés par des varints de longueur qu'il faut impérativement recalculer.

Pour migrer intégralement les 16 discussions vers `latex\` :

1. Mettre à jour `C:\Users\guill\.gemini\config\projects\f700c676-4f3f-40ce-9ad9-920f5eb12cd0.json` comme dans l'Option A.
2. Dans `C:\Users\guill\.gemini\antigravity\conversation_summaries.db` :
   - Mettre à jour `workspace_uris` (`["file:///c%3A/Users/guill/dev/perso/latex/general"]` → `["file:///c%3A/Users/guill/dev/perso/latex"]`) pour les lignes de `project_id = 'f700c676-4f3f-40ce-9ad9-920f5eb12cd0'`.
   - Mettre à jour la table FTS `conversations_fts` (`workspace = 'latex'`, `project = 'latex'`).
   - Ré-encoder proprement le champ Protobuf `raw_summary` (mise à jour de la chaîne URI + recalcul des varints de longueur des sous-messages parents).
3. Dans chacun des fichiers `C:\Users\guill\.gemini\antigravity\conversations\<id>.db` associés à ce projet :
   - Ré-encoder proprement `trajectory_metadata_blob` (`id = 'main'`) en ajustant les varints de longueur Protobuf pour les champs contenant `file:///c:/Users/guill/dev/perso/latex/general`.
4. Mettre à jour `C:\Users\guill\.gemini\antigravity\agyhub_summaries_proto.pb` de la même façon (ou vérifier sa reconstruction depuis `conversation_summaries.db`).

*(Sur demande, un script Python `uv` dédié avec parseur/ré-encodeur Protobuf wire-format peut être généré et vérifié avant exécution pour automatiser l'Option B proprement et sans risque de troncature varint.)*

---

### Étape 5 — Contrôle final après réouverture

1. Ouvrir `C:\Users\guill\dev\perso\latex` dans Antigravity (et/ou VS Code).
2. Vérifier que vos règles locales (`AGENTS.md`, `.agents/rules/`) et vos discussions s'affichent bien.
3. Si vous utilisez VS Code, vérifier la synchronisation MCP :
   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File .\.agents\scripts\sync-mcp.ps1
   ```
4. Une fois sûr que tout fonctionne pendant quelques jours, vous pourrez supprimer le dossier de sauvegarde sur le Bureau.
