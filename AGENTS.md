# AGENTS.md — Directives Locales du Workspace LaTeX

> **Portée :** Ce fichier complète les directives globales (`C:\Users\guill\.agents\AGENTS.md`) pour l'écosystème LaTeX modulaire de ce dépôt. Les règles déjà définies globalement (langue française, commits Conventional Commits, suivi `plan.md`, `uv`, capitalisation `.md`, gouvernance `.agents/`, économie de tokens) ne sont pas répétées ici.

---

## 1. Cycle de Vie des Projets & Rétroportage (`templates/template_officiel/`)

1. **Modèle unique pour tout nouveau projet :**
   - Tout nouveau projet doit être créé sous `projets/<nom_projet>/` en reprenant intégralement la structure, la classe (`mythesis.cls`, `mythesis-screen.clo`, `mythesis-print.clo`), la configuration (`config/packages.sty`, `config/macros.sty`) et l'outillage (`latexmkrc`, `.chktexrc`, `.editorconfig`, `.gitignore`) de [`templates/template_officiel/`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_officiel/README.md).
   - Les autres modèles présents dans [`templates/`](file:///c:/Users/guill/dev/perso/latex/general/templates) (`template_principal/`, `BE_mecanique/`, `labo_PID/`, etc.) sont conservés comme archives ou références ponctuelles ; ne jamais répliquer leurs pratiques obsolètes.
2. **Rétroportage systématique vers `template_officiel` :**
   - Toute nouvelle fonctionnalité, macro générique, amélioration typographique/architecturale ou correction de bug développée sur un projet dérivé **doit également être rétroportée dans `templates/template_officiel/`** (de façon neutre et réutilisable, sans y importer de contenu propre au projet).
   - Mettre à jour `templates/template_officiel/README.md` ou `backmatter/appendix-a.tex` si une macro ou option publique est ajoutée ou modifiée.

---

## 2. Contrôle Post-Édition : Zéro Erreur & Avertissements Minimaux

À l'issue de **chaque ajout ou modification significative de code LaTeX** :
1. **Compiler systématiquement** avec `latexmk` (LuaLaTeX + Biber dans `build/`).
2. **Exiger 0 erreur fatale** (code de sortie `0`, PDF généré dans `build/`).
3. **Inspecter le fichier `.log`** (`build/main.log`) et exécuter **`chktex`** (via `.chktexrc`) et/ou `lint-latex.ps1` afin d'éliminer les avertissements évitables (`Overfull \hbox`, références/citations indéfinies, `Missing character`, avertissements `scrlayer-scrpage` ou `chktex`) et n'en conserver que le strict minimum justifié.

---

## 3. Standards LaTeX du Workspace

1. **Séparation stricte contenu / présentation :**
   - Contenu rédactionnel pur dans `content/`, `frontmatter/`, `backmatter/` ; aucune configuration de géométrie, de police ou de package dans les chapitres.
   - Packages et macros métier centralisés dans `config/packages.sty`, `config/macros.sty` et `mythesis.cls`.
2. **Syntaxe moderne obligatoire :**
   - Commandes sémantiques (`\textbf`, `\emph`, `\code`, `\term`) et jamais `{\bf}`, `{\it}`, `{\tt}`.
   - Maths AMS (`\[ ... \]`, `equation`, `align`), jamais `$$ ... $$`.
   - Tableaux avec `booktabs` (`\toprule`, `\midrule`, `\bottomrule`) et `tabularx`, **sans jamais de filets verticaux `|` ni de `\hline`**.
   - Références croisées via `cleveref` (`~\cref{}`, `\Cref{}`, `~\cpageref{}`) et citations BibLaTeX/Biber (`~\parencite{}`, `\textcite{}`) précédées d'une espace insécable `~`.
   - Unités via `siunitx` v3 (`\qty`, `\qtyrange`, `\num`).
3. **Formatage Git-friendly :**
   - Sauts de ligne sémantiques (une phrase ou clause par ligne) et indentation à 2 espaces.
   - Ne jamais commiter ni éditer les artefacts de `build/`.
4. **Rédaction rapide Markdown $\rightarrow$ LaTeX enrichi :**
   - Lorsqu'un brouillon est rédigé en Markdown puis transcrit en LaTeX, appliquer systématiquement le skill [`markdown-to-latex`](file:///c:/Users/guill/dev/perso/latex/general/.agents/skills/markdown-to-latex/SKILL.md) et le workflow [`markdown-to-latex.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/workflows/markdown-to-latex.md).

---

## 4. Navigation dans `.agents/`

| Ressource | Rôle |
| :--- | :--- |
| [`.agents/rules/architecture.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/architecture.md) | Arborescence `template_officiel`, règle de rétroportage et inclusions |
| [`.agents/rules/general.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/general.md) | Philosophie modulaire, KOMA-Script + `geometry`, ordre des packages, typographie |
| [`.agents/rules/coding-style.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/coding-style.md) | Syntaxe LaTeX, maths, tableaux, boîtes `tcolorbox`, labels et annotations |
| [`.agents/rules/testing.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/testing.md) | Compilation LuaLaTeX, contrôle 0 erreur / avertissements minimaux, `chktex` |
| [`.agents/rules/security.md`](file:///c:/Users/guill/dev/perso/latex/general/.agents/rules/security.md) | Restriction `-shell-escape` et hygiène des métadonnées / `.bib` |
| [`.agents/workflows/`](file:///c:/Users/guill/dev/perso/latex/general/.agents/workflows) | Procédures (`new-project.md`, `markdown-to-latex.md`, `build-and-verify.md`) |
| [`.agents/skills/`](file:///c:/Users/guill/dev/perso/latex/general/.agents/skills) | Skills spécialisés (`markdown-to-latex`, `latex-document-manager`, `latex-quality-auditor`, `visual-diagrams`, `zotero-biblio`, `project-memory`) |
| [`.agents/subagents/`](file:///c:/Users/guill/dev/perso/latex/general/.agents/subagents) | Sous-agents spécialisés (compilateur, QA, diagrammes, biblio, mémoire) |
