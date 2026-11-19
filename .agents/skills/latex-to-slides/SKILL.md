---
name: latex-to-slides
description: >-
  Générer un diaporama LaTeX moderne et synthétique à partir d'un document LaTeX existant (projet interne du dépôt ou document .tex/.pdf externe).
---

# Skill : Document LaTeX / PDF → Diaporama Moderne (`ClasseGuillaumeSlides`)

Ce skill transforme un document long (rapport, thèse, article, support interne ou externe) en une présentation 16:9 aérée, sans jamais copier-coller des paragraphes bruts.

---

## Étapes d'exécution

1. **Charger la compétence et le guide de transformation :**
   - Lire [`latex-slides/SKILL.md`](../latex-slides/SKILL.md) et [`references/document-to-slides-guide.md`](../latex-slides/references/document-to-slides-guide.md).

2. **Choisir l'implantation et préparer le socle :**
   - **Document interne (`projets/<nom_projet>/`) :** utiliser `projets/<nom_projet>/slides/` (mode `integrated`) afin de réutiliser sans duplication `../figures/`, `../biblio/`, `../fonts/`, `../data/` et `../listings/` via `\slideasset{...}`.
   - **Document externe (`.tex` ou `.pdf`) :** initialiser `projets/<nom_slides>/` depuis `templates/template_slides/` via [`new-slides`](../new-slides/SKILL.md) et centraliser les éventuels médias/données réutilisés dans ses dossiers `figures/`, `data/`, `biblio/`, `listings/`.

3. **Extraire la colonne vertébrale narrative :**
   - Dégager la problématique, 3 à 5 sections clés, les résultats quantitatifs majeurs, les schémas décisifs et la conclusion.
   - Placer les développements longs, démonstrations complètes et tableaux exhaustifs dans les diapositives de réserve (`sections/99-backup.tex` après `\appendix`).

4. **Rédiger des diapositives éditoriales (jamais de « mur de texte ») :**
   - Formuler des titres d'assertion synthétiques sur une ligne ; utiliser `\framesubtitle` pour le contexte secondaire.
   - Limiter chaque frame à une idée directrice (~35–50 mots hors code/graphique) en alternant cartes (`slidecard`, `\metriccard`), figures vectorielles (`cadreFigure`), tableaux `booktabs` épurés et bandeaux `\takeaway`.
   - Ajouter `[fragile]` sur toute frame contenant un listing ou du verbatim ; préférer `\lstinputlisting[firstline=...,lastline=...]{\slideasset{...}}`.

5. **Compiler, auditer et inspecter visuellement :**
   - Exécuter [`build-and-verify`](../build-and-verify/SKILL.md) : `lint-latex.ps1 -RunChkTeX` puis `compile.ps1`.
   - Vérifier **0 erreur fatale**, **0 `Overfull \hbox` / `Overfull \vbox`** et aucune référence Biber manquante.
   - Rendre quelques pages critiques en PNG (`pdftoppm -png -r 150`) pour contrôler visuellement les marges, alignements et contrastes.

6. **Rétro-portage :**
   - Si une nouvelle macro de diapositive ou correction de style s'avère réutilisable, la rétro-porter dans `templates/template_slides/` et `templates/template_officiel/slides/`.
