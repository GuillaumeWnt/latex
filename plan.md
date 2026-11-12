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
