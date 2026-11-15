# Compte-rendu & Réponses Techniques — Phase 10 (`ClasseGuillaumeSlides v2.0`)

Ce document capitalise les décisions, évolutions et réponses techniques issues de la refonte visuelle des présentations LaTeX et de l'évaluation des serveurs MCP associés.

---

## 1. Règle Globale `docs/plan.md` Éphémère & `docs/historique.md` Validée

- La proposition issue de la phase précédente a été approuvée puis ajustée dans la Source Unique de Vérité globale :
  - [`C:\Users\guill\.agents\AGENTS.md`](file:///C:/Users/guill/.agents/AGENTS.md) (**Règle 2**) et [`C:\Users\guill\.agents\rules\01-git-et-planification.md`](file:///C:/Users/guill/.agents/rules/01-git-et-planification.md).
  - Propagation exécutée et vérifiée via `deploy-and-sync-global.ps1` vers les configurations des assistants IA.
- **Principe actif :** [`docs/plan.md`](plan.md) est réinitialisé dans `docs/` pour chaque demande multi-étapes (avec cochage au fil de l'eau), tandis que [`docs/historique.md`](historique.md) maintient la mémoire synthétique transversale du dépôt sur 3 horizons (*Socle Ancien*, *Évolution Récente*, *Session Courante*).
- **Choix `.gitignore` pour les exemples visuels :** plutôt que d'exclure `*.png` globalement (ce qui empêcherait Git de versionner les vraies figures, logos et schémas exportés dans `figures/` des projets LaTeX), seul le dossier [`templates/exemples-slides/`](../templates/exemples-slides) est exclu dans [`.gitignore`](../.gitignore) — tout en restant accessible aux assistants IA (non exclu dans `.aiexclude`/`.claudeignore`/`.geminiignore`).

---

## 2. Analyse des Références Visuelles & Refonte `ClasseGuillaumeSlides v2.0`

### 2.1 Archivage des exemples de référence
Les 23 diapositives d'exemple fournies ont été inspectées visuellement et classées dans [`templates/exemples-slides/`](../templates/exemples-slides) (`exemple1/`, `exemple2/`, `exemple3/`, ignoré par Git via `.gitignore` sans masquer les `*.png` des projets) ; le dossier temporaire `exemple/` a été supprimé.

Quatre principes esthétiques majeurs en ont guidé la refonte :
1. **Aération et contenu ouvert sans boîtes répétées :** remplacer l'empilement de `slidecard` par des chiffres nus soulignés (`\minimalstat`), des listes à pastilles (`\stepitemrow`, `\stepitem`), et un trait fin d'accompagnement.
2. **Diversité structurelle forte :** alterner grilles libres, diagrammes vectoriels dédiés (`railpoints`, `processline`, `timelineflow`, `funnelchart`, `cyclechart`), visuels inclinés (`\tiltframe`), bandeaux/rails de fond (`\usebandcanvas`, `\userailcanvas`) avec cartes flottantes à pastille (`\floatingcard`), et diapositives plein écran (`\standoutslide`).
3. **Couvertures expressives (`\maketitle`) :** 4 gabarits sélectionnables (`cover=diagonal`, `organic`, `framed`, `editorial`) et prise en charge de `\covervisual{...}`.
4. **Harmonie chromatique multi-palettes clair/sombre :** 4 palettes (`navy`, `forest`, `sage`, `vibrant`) déclinées en `theme=light` et `theme=dark`, plus `style=editorial|organic|minimal`, `eyebrow=off|on`, `footer=minimal|full|none` et `progressbar=none|foot|head|frametitle`.

### 2.2 Fichiers du socle & synchronisation
- Socle autonome : [`templates/template_slides/`](../templates/template_slides/README.md) (`ClasseGuillaumeSlides.cls`, `config/slides-macros.sty`, `.chktexrc`, `.chktexrc-en`, `figures/tikz/apercu-studio.tex`, `figures/tikz/architecture-slides.tex`, `main.tex`, `sections/*.tex`).
- Socle intégré : [`templates/template_officiel/slides/`](../templates/template_officiel/slides/main.tex) synchronisé à l'identique sur les 5 fichiers cœur (`ClasseGuillaumeSlides.cls`, `slides-packages.sty`, `slides-macros.sty`, `.chktexrc`, `.chktexrc-en`) et démonstrations mises à jour.
- Documentation & skill IA : [`latex-slides`](../.agents/skills/latex-slides/SKILL.md), [`design-patterns.md`](../.agents/skills/latex-slides/references/design-patterns.md), [`document-to-slides-guide.md`](../.agents/skills/latex-slides/references/document-to-slides-guide.md) et [`appendix-a.tex`](../templates/template_officiel/backmatter/appendix-a.tex).

---

## 3. Existe-t-il un serveur MCP utile pour créer de belles slides LaTeX ?

### 3.1 État des lieux (Marketplace Antigravity & GitHub)
1. **Marketplace officiel Antigravity :**
   - Une recherche (`beamer`, `slides`, `presentation`) ne remonte **aucun plugin ou MCP dédié à LaTeX Beamer**. Le seul plugin de présentation présent est `antigravity-plugins-official/plugin/gslides` (**Google Slides** : lecture/édition/export Google Slides).
2. **Projets MCP communautaires identifiés sur GitHub :**
   - [`context-machine-lab/Beamer-MCP`](https://github.com/context-machine-lab/Beamer-MCP) : serveur MCP ciblant la génération de diapositives et posters académiques en Beamer + compilation PDF.
   - [`RobertoDure/mcp-latex-server`](https://github.com/RobertoDure/mcp-latex-server) / `Yeok-c/latex-mcp-server` : serveurs MCP génériques pour éditer et compiler des projets LaTeX (articles, rapports, Beamer).
   - [`masaki39/marp-mcp`](https://github.com/masaki39/marp-mcp) : présentation en Markdown via **Marp** (hors LaTeX/TikZ).
   - [`GongRzhe/Office-PowerPoint-MCP-Server`](https://github.com/GongRzhe/Office-PowerPoint-MCP-Server) : création et modification de fichiers PowerPoint `.pptx` via `python-pptx` (hors LaTeX).
   - [`edward-lcl/typst-mcp`](https://github.com/edward-lcl/typst-mcp) : compilation et navigation structurée centrées sur **Typst**.

### 3.2 Recommandation pour votre environnement
- **Inutile d'installer `Beamer-MCP` ou un serveur LaTeX générique :** votre espace possède déjà une chaîne locale supérieure et 100 % sur mesure :
  1. Le socle typographique **`ClasseGuillaumeSlides v2.0`** et le skill [`latex-slides`](../.agents/skills/latex-slides/SKILL.md) (avec nos 23 planches visuelles de référence).
  2. Le serveur **`io.draw/mcp`** déjà actif pour générer des schémas Draw.io complexes lorsque TikZ ne suffit pas.
  3. Les scripts PowerShell locaux (`compile.ps1`, `lint-latex.ps1 -RunChkTeX`) couplés à **`pdftoppm`** + inspection PNG directe par l'IA pour valider l'esthétique réelle page par page.
- **Seule exception utile :** installer le plugin Marketplace **`antigravity-plugins-official/plugin/gslides`** (ou `GongRzhe/Office-PowerPoint-MCP-Server`) uniquement si vous devez produire/modifier des présentations **Google Slides** ou **PowerPoint (`.pptx`)** collaboratives hors LaTeX.

---

## 4. Diagnostic MCP : pourquoi `latex-compiler` et `latex-workshop-assistant` ne sont pas accessibles

### 4.1 Constat de découverte côté Antigravity
- Dans le dépôt, les deux serveurs sont déclarés dans [`.agents/mcp_config.json`](../.agents/mcp_config.json) via `uvx` (lignes 8 à 28).
- Côté Antigravity, les schémas MCP actifs sont stockés dans le répertoire global `C:\Users\guill\.gemini\antigravity\mcp\` (`arxiv-latex`, `brave-search`, `io.draw`, `kicad-suite_jlc-parts`, `kicad-suite_konnect`, `zotero-citations`, etc.). Aucun dossier `latex-compiler` ou `latex-workshop-assistant` n'y figure.
- Par ailleurs, les configurations globales `C:\Users\guill\.agents\mcp_config.json` et `C:\Users\guill\.gemini\config\mcp_config.json` sont vides (`{"mcpServers": {}}`) et `C:\Users\guill\.gemini\antigravity\mcp_config.json` n'existe pas. Antigravity n'expose donc pas automatiquement les entrées déclarées uniquement dans le fichier `.agents/mcp_config.json` / `.gemini/mcp_config.json` du workspace.

### 4.2 Diagnostic détaillé des deux serveurs

| Serveur (`.agents/mcp_config.json`) | Paquet GitHub visé | Résultat du test direct via `uvx` | Causes identifiées |
| :--- | :--- | :--- | :--- |
| `latex-compiler` | `RobertoDure/mcp-latex-server` | Échec (code `1`) | **1.** Nom d'exécutable erroné dans la config (`latex-server` au lieu de `mcp-latex-server.exe`).<br>**2.** Paquet amont cassé : même avec `mcp-latex-server --help`, le point d'entrée échoue sur `ModuleNotFoundError: No module named 'latex_server'`. |
| `latex-workshop-assistant` | `Yeok-c/latex-mcp-server` | Démarre sur chemin réel (`0`), plante sur `${workspaceFolder}` (`1`) | **1.** Hors VS Code (ou sans interpolation de `${workspaceFolder}`), `--workspace "${workspaceFolder}"` échoue au démarrage avec `Workspace does not exist: C:\Users\guill\dev\perso\latex\${workspaceFolder}`.<br>**2.** Avec un chemin résolu, le serveur (`latex-mcp-server` v`0.1.0`) répond en JSON-RPC et expose 9 outils (`compile_latex`, `download_bibliography`, `extract_bibliography`, `list_tex_files`, `read_file`, `read_pdf`, `read_pdf_from_citation`, `suggest_bib_key`, `summarize_text`), mais `compile_latex` cible `pdflatex`/`xelatex` via `latexmk` plutôt que la chaîne locale LuaLaTeX + `chktex`. |

### 4.3 Pistes d'action recommandées (sur accord préalable)
1. **Supprimer `latex-compiler` de `.agents/mcp_config.json`** : le dépôt amont `RobertoDure/mcp-latex-server` ne fonctionne pas en l'état (`ModuleNotFoundError`).
2. **Pour `latex-workshop-assistant` :**
   - soit le **retirer** de `.agents/mcp_config.json` puisque les outils locaux ([`compile.ps1`](../.agents/skills/latex-document-manager/scripts/compile.ps1), [`lint-latex.ps1`](../.agents/skills/latex-quality-auditor/scripts/lint-latex.ps1)) gèrent déjà LuaLaTeX, Biber et `chktex` ;
   - soit remplacer `--workspace "${workspaceFolder}"` par `--workspace "."` (si le répertoire courant du client MCP est déjà la racine du projet) et l'enregistrer côté configuration MCP globale Antigravity si vous souhaitez disposer de ses outils auxiliaires (`list_tex_files`, `suggest_bib_key`, etc.).

