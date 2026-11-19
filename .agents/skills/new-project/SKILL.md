---
name: new-project
description: >-
  Initialiser un nouveau projet LaTeX dans projets/<nom_projet>/ à partir de templates/template_officiel/ avec rétro-portage continu des améliorations.
---

# Skill : Création d'un Nouveau Projet (`template_officiel`)

Tout nouveau projet LaTeX doit dériver de [`templates/template_officiel/`](../../../templates/template_officiel) afin d'assurer homogénéité, robustesse LuaLaTeX et réutilisabilité.

---

## Étapes d'exécution

1. **Valider le nom du projet :**
   - Utiliser un nom court en minuscules/tirets ou underscores sous `projets/<nom_projet>/` (vérifier que le dossier n'existe pas déjà).

2. **Dupliquer `templates/template_officiel/` :**
   - Copier récursivement le socle `templates/template_officiel/` vers `projets/<nom_projet>/`, **en excluant** le répertoire `build/` et les fichiers temporaires de compilation éventuels.
   - Conserver l'arborescence officielle : `main.tex`, `ClasseGuillaume.cls`, `ClasseGuillaume-*.clo`, `config/`, `content/`, `frontmatter/`, `backmatter/`, `biblio/`, `figures/`, `listings/`, `fonts/`, `latexmkrc`, `.chktexrc`, `.chktexrc-en`, `.editorconfig`, `.gitignore`, `.aiexclude`, `.geminiignore`.

3. **Personnaliser les métadonnées du projet :**
   - Adapter `main.tex` (titre, sous-titre, auteur, date, langue `french`/`english`, mode `screen`/`print`, `oneside`/`twoside`).
   - **Si le document principal est en anglais :** passer l'option `english` (`\documentclass[screen, english]{ClasseGuillaume}`) et remplacer `.chktexrc` par `.chktexrc-en` (afin de contrôler l'absence d'espace devant `: ; ? !`).
   - Nettoyer ou adapter les chapitres exemples de `content/` et `frontmatter/` selon les besoins du livrable.

4. **Valider la compilation initiale :**
   - Exécuter le skill [`build-and-verify`](../build-and-verify/SKILL.md) sur `projets/<nom_projet>/` pour confirmer un premier build vierge à 0 erreur et 0 avertissement bloquant.

5. **Règle permanente de rétro-portage :**
   - Tout au long de la vie du projet, si une correction de bug (`ClasseGuillaume.cls`, `config/packages.sty`, `latexmkrc`, `.chktexrc`) ou une macro/fonctionnalité générique (`config/macros.sty`) est ajoutée dans `projets/<nom_projet>/`, **la rétro-porter immédiatement** dans `templates/template_officiel/` (en vérifiant ensuite la compilation de `template_officiel`).
