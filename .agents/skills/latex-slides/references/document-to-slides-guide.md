# Guide : Transformer un Document LaTeX ou PDF en Présentation

Ce guide détaille la méthode de distillation éditoriale pour passer d'un document long à un jeu de diapositives percutant avec `ClasseGuillaumeSlides`.

---

## 1. Identifier le Cas de Figure

### Cas A — Projet interne basé sur `templates/template_officiel/`
- Travailler directement dans `projets/<nom_projet>/slides/`.
- Vérifier que `\documentclass[french, integrated]{ClasseGuillaumeSlides}` est activé.
- **Ne jamais dupliquer** les figures, schémas TikZ, tableaux CSV, listings Python ou fichiers `.bib` : les référencer en place via `\slideasset{figures/...}`, `\slideasset{data/...}`, `\slideasset{listings/...}`, ou directement par nom dans `\input{schema-principe.tex}` (grâce au `TEXINPUTS` ciblé de `latexmkrc`).
- Pour les schémas TikZ déjà intégrés dans un chapitre du rapport (`content/*.tex`) plutôt qu'externalisés, extraire le bloc `tikzpicture` dans `figures/tikz/<nom>.tex` et l'inclure par `\input` des deux côtés (rapport et slides).

### Cas B — Document LaTeX externe (`.tex` ou dossier source)
1. Initialiser un deck autonome dans `projets/<nom_slides>/` à partir de `templates/template_slides/` (sans `build/`).
2. Inspecter le document source pour repérer :
   - la structure (`\part`, `\chapter`, `\section`) et le `\title` / `\author` ;
   - le `.bib` source (à fusionner dans `biblio/references.bib`) ;
   - les macros personnalisées indispensables (à reporter dans `config/slides-macros.sty` ou à normaliser vers `\vect`, `\qty`, `\term`, `\code`) ;
   - les figures (`\includegraphics`), graphiques `pgfplots`/CSV et figures TikZ réutilisables (à copier dans `figures/`, `figures/tikz/`, `data/`).
3. **Adaptation des figures TikZ :** si un schéma du document externe dépasse ~4 cm de haut ou contient du texte minuscule en `\tiny`, adapter son `scale`/largeur ou en créer une version simplifiée dédiée dans `figures/tikz/` afin de garantir sa lisibilité en projection.

### Cas C — Document PDF externe sans sources `.tex`
1. Lire l'architecture du PDF (table des matières, titres, graphiques, conclusions, encadrés de synthèse) — jamais de transcription mot à mot.
2. Initialiser `projets/<nom_slides>/` depuis `templates/template_slides/`.
3. Extraire les idées maîtresses et reconstruire les schémas structurants en TikZ natif ou Draw.io (`cadreFigure`), et les tableaux clés en `booktabs` synthétiques (<= 5 lignes).

---

## 2. Règles de Compression Éditoriale (Rapport → Diapositives)

| Élément du document source | Transformation dans les diapositives |
| :--- | :--- |
| Chapitre ou grande partie | `1` section Beamer (`\section{...}`) |
| Paragraphe explicatif (100–250 mots) | `1` diapositive : titre d'assertion + 2 à 4 points courts ou 2 cartes `slidecard` (~35–50 mots) |
| Démonstration mathématique multi-lignes | Conserver l'hypothèse et le résultat encadré sur la slide ; déplacer la preuve complète dans `sections/99-backup.tex` |
| Grand tableau (> 6 lignes ou > 4 colonnes) | Mettre en avant les 3–4 lignes décisives + `\metriccard` ; mettre le tableau complet en annexe backup |
| Encadrés `callout` / `definitionbox` / `boiteSynthese` | Conserver ou convertir en `slidecard`, `alertcard` ou `\takeaway` |
| Bloc de code long (> 15 lignes) | Pointer sur les lignes essentielles avec `[fragile]` + `\lstinputlisting[firstline=...,lastline=...]` |
| Citations bibliographiques (`\autocite`, `\cite`, `\textcite`) | Préserver les clés essentielles dans `\sourcenote{...}` ou en ligne ; vérifier la compilation Biber |

---

## 3. Séquence de Découpage Type (Soutenance / Revue Technique)

1. **Ouverture (`01-contexte.tex`) :** titre + question centrale + enjeu (`\metriccard` ou `\alertcard`).
2. **Méthode / Architecture (`02-methode.tex`) :** schéma bloc (`cadreFigure`) + hypothèses structurantes.
3. **Résultats & Validation (`03-resultats.tex`) :** graphiques clés, comparaison chiffrée vs référence, limites honnêtes.
4. **Conclusion (`04-conclusion.tex`) :** apports majeurs + perspectives + `\standoutslide` final (merci / questions).
5. **Réserve (`99-backup.tex` sous `\appendix`) :** démonstrations, jeux de paramètres, tableaux exhaustifs (non comptés dans le total `/ N` affiché en pied de page grâce à `appendixnumberbeamer`).
