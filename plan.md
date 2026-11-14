# Plan de Refonte — `.agents/`, `AGENTS.md` et `.vscode/`

## Phase 1 — Nettoyage & Refonte de `AGENTS.md` et `.agents/rules/`
- [x] Supprimer les fichiers obsolètes, boilerplate et redondants (`.agents/plugins/sample-plugin/`, `.agents/workflows/sample-workflow.md`, `.agents/rules/gemini.md`, JSON vides dans `.agents/`, `.github/prompts/sample.prompt.md`, `.github/instructions.md`, fichiers vides `.claude/rules/general.md` et `.gemini/rules/general.md`)
- [x] Réécrire `AGENTS.md` en français, sans doublons avec `C:\Users\guill\.agents\AGENTS.md`, en intégrant les règles `template_officiel` + rétroportage, contrôle compilation zéro erreur / minimum d'avertissements et workflow Markdown $\rightarrow$ LaTeX
- [x] Refactoriser `.agents/rules/architecture.md` sur `templates/template_officiel/` et `projets/<nom>/` avec règle de rétroportage
- [x] Refactoriser `.agents/rules/general.md` et `.agents/rules/coding-style.md` (suppression des redondances, alignement sur `mythesis.cls` et `config/`)
- [x] Mettre à jour `.agents/rules/testing.md` (contrôle obligatoire post-édition : 0 erreur, minimum d'avertissements, `chktex`, `lint-latex.ps1`)
- [x] Épurer `.agents/rules/security.md` (suppression du tutoriel élémentaire, conservation des règles `-shell-escape` et hygiène)

## Phase 2 — Modernisation des Skills, Sous-agents et Scripts MCP (`.agents/`)
- [x] Moderniser `.agents/skills/latex-document-manager/` (`SKILL.md`, `scripts/compile.ps1`, `scripts/clean.ps1`, `references/`, suppression du modèle `article-template.tex` `pdflatex` obsolète)
- [x] Moderniser `.agents/skills/latex-quality-auditor/` (`SKILL.md`, `references/typography-checklist.md`, `scripts/lint-latex.ps1` enrichi avec `chktex` et contrôle des avertissements)
- [x] Corriger et aligner `.agents/skills/visual-diagrams/` (`SKILL.md`, `references/`, `examples/sample-cadre-figure.tex` corrigé sur l'API `[width=...]` de `cadreFigure`)
- [x] Mettre à jour `.agents/skills/zotero-biblio/` et `.agents/skills/project-memory/` (`biblio/`, `mythesis.cls`, `headheight=20pt`)
- [x] Mettre à jour les 5 sous-agents dans `.agents/subagents/` (suppression des redondances, alignement sur `template_officiel` et contrôle d'avertissements)
- [x] Nettoyer `.agents/mcp_config.json` (suppression de `memory` et `workspace-filesystem`), corriger `.agents/scripts/sync-mcp.ps1` (UTF-8 sans BOM) et exécuter la synchronisation

## Phase 3 — Création du Skill et des Workflows `markdown-to-latex`
- [x] Créer le skill `.agents/skills/markdown-to-latex/SKILL.md` et sa référence `.agents/skills/markdown-to-latex/references/mapping-syntaxe.md`
- [x] Créer les workflows opérationnels `.agents/workflows/markdown-to-latex.md`, `.agents/workflows/new-project.md` et `.agents/workflows/build-and-verify.md` (+ prompt routeur `.github/prompts/markdown-to-latex.prompt.md`)

## Phase 4 — Vérification, Complétude et Déduplication de `.vscode/` & Routeurs
- [x] Mettre à jour `.vscode/extensions.json` avec les extensions adaptées au socle LaTeX/Python/IA
- [x] Nettoyer et compléter `.vscode/settings.json` (héritage global de `files.exclude`/`search.exclude`, suppression de l'instruction Copilot obsolète, ajout ChkTeX, `latexindent`, indentation 2 espaces, `clean.subfolder.enabled`)
- [x] Vérifier et optimiser `.vscode/tasks.json` et les routeurs `.claude/`, `.gemini/`, `.github/`

## Phase 5 — Validation Technique et Contrôle Qualité Final
- [x] Valider la syntaxe JSON et l'encodage UTF-8 sans BOM de tous les fichiers de configuration
- [x] Tester les scripts PowerShell (`sync-mcp.ps1`, `lint-latex.ps1`, `audit-bib.ps1`)
- [x] Compiler `templates/template_officiel/main.tex` via `latexmk` et vérifier l'absence d'erreurs et la maîtrise des avertissements (`chktex`, `.log`)

## Phase 6 — Ajustements Post-Revue (`ClasseGuillaume.cls`), Citations, `clean.ps1`, `memory` et FAQ
- [x] Renommer `mythesis.cls` / `mythesis-*.clo` en `ClasseGuillaume.cls` / `ClasseGuillaume-*.clo` dans `templates/template_officiel/`, `AGENTS.md`, `.agents/` et `explication-changements.md`
- [x] Préciser l'arborescence obligatoire conforme à `templates/template_officiel/` dans le workflow et le skill `markdown-to-latex`
- [x] Assouplir les règles, options et skills de citation (conserver les bonnes pratiques BibLaTeX/Biber sans imposer de style ni de commande rigide)
- [x] Mettre à jour `clean.ps1` et `templates/template_officiel/latexmkrc` pour préserver le `.pdf` généré ainsi que les fichiers de compilation/débogage (`.synctex.gz`, `.log`, `.blg`, `.fdb_latexmk`, `.fls`) lors d'un nettoyage standard
- [x] Supprimer le MCP `memory` (superflu) au niveau global/local et adapter `.agents/subagents/knowledge-curator.md` (suppression de `.agents/skills/project-memory/`)
- [x] Rédiger le guide complet des réponses et explications détaillées dans `docs/faq-agents-vscode-latex.md`
- [x] Recompiler à froid `templates/template_officiel/main.tex` et relancer `lint-latex.ps1 -RunChkTeX` et `audit-bib.ps1` après renommage `ClasseGuillaume.cls` (zéro erreur fatale)

## Phase 7 — Règle Globale de Validation Visible, Audit Anglais/Extensions/Ignore & Consolidation `.md`
- [x] Inscrire la nouvelle règle globale d'amélioration/obsolescence avec mise en évidence obligatoire en tête de réponse dans `C:\Users\guill\.agents\AGENTS.md` et `C:\Users\guill\.agents\rules\04-gouvernance-et-securite.md`, puis synchroniser via `deploy-and-sync-global.ps1`
- [x] Auditer les dépendances linguistiques français/anglais dans `templates/template_officiel/`, `.chktexrc`, `lint-latex.ps1` et `.agents/`
- [x] Documenter la gestion des extensions par profil VS Code et dans le socle de base (`create-vscode-profiles.ps1`, CLI, UI)
- [x] Inspecter tous les fichiers `.ignore` / `.exclude` du dépôt (`.aiexclude`, `.claudeignore`, `.geminiignore`, `.gitignore`, `.git/info/exclude`)
- [x] Supprimer `explication-changements.md` et `docs/faq-agents-vscode-latex.md`, créer le nouveau document explicatif unique dans `docs/compte-rendu-et-reponses.md` et vérifier l'absence d'erreurs

## Phase 8 — Support bilingue `english`/`french` & Finalisation des fichiers `.ignore` (PDF accessible)
- [x] Implémenter l'option de classe `english` / `french` (défaut `french`) dans `templates/template_officiel/` (`ClasseGuillaume.cls`, `config/packages.sty`, `config/macros.sty`, `frontmatter/abstract.tex`, `.chktexrc-en`, `README.md`, `backmatter/appendix-a.tex`)
- [x] Adapter `.agents/` (`rules/general.md`, `skills/latex-quality-auditor/scripts/lint-latex.ps1`, `skills/latex-quality-auditor/SKILL.md`, `workflows/new-project.md`) pour le support natif des projets en anglais
- [x] Mettre à jour `.aiexclude`, `.claudeignore` et `.geminiignore` (et les inclure dans `templates/template_officiel/`) avec les auxiliaires LaTeX jetables tout en gardant `*.pdf`, `*.log`, `*.blg` et `*.bbl` accessibles
- [x] Enrichir `docs/compte-rendu-et-reponses.md` avec l'explication sur `**/build/*.pdf` et la documentation des changements effectués
- [x] Vérifier la compilation LuaLaTeX et le lint (`lint-latex.ps1 -RunChkTeX`) en mode `french` par défaut et en mode `english`, sans régression ni avertissement superflu
