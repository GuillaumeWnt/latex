---
description: Convertir un fichier ou brouillon Markdown en LaTeX enrichi conforme à templates/template_officiel/ puis compiler et vérifier zéro erreur.
---

# Workflow : Conversion Markdown → LaTeX Enrichi

Ce workflow orchestre la transformation d'un brouillon Markdown rapide (notes, plan rédigé par IA, rapport `.md`) en chapitre ou section LaTeX de qualité éditoriale sous `templates/template_officiel/`.

---

## Étapes d'exécution

1. **Charger la compétence de référence :**
   - Lire [`.agents/skills/markdown-to-latex/SKILL.md`](../skills/markdown-to-latex/SKILL.md) et [`mapping-syntaxe.md`](../skills/markdown-to-latex/references/mapping-syntaxe.md).

2. **Identifier la source Markdown et la cible LaTeX :**
   - Localiser le brouillon `.md` (ou le texte fourni par l'utilisateur).
   - Vérifier le projet cible dans `projets/<nom_projet>/` (conforme à `templates/template_officiel/`). S'il n'existe pas, exécuter d'abord [`new-project.md`](./new-project.md).
   - Déterminer le fichier de destination (`content/XX-titre.tex`, sous-fichier `\input{...}`, ou `backmatter/appendix-x.tex`).

3. **Convertir et enrichir sémantiquement :**
   - Structurer avec `\chapter` / `\section` / `\subsection` et `\label{...}` normalisés.
   - Appliquer les macros sémantiques de `config/macros.sty` (`\term`, `\code`, `\enquote`, `\qty`/`\num`, `\vect`/`\mat`/`\setR`, etc.).
   - Transformer alertes et encadrés Markdown (`> [!NOTE]`, `> [!WARNING]`, `> [!TIP]`, `> [!IMPORTANT]`) en boîtes `callout`, `attentionbox`, `boiteSynthese`, `definitionbox`, `hypothesis`.
   - Convertir les tableaux Markdown en `table` + `\caption` au-dessus + `tabularx` + `booktabs` (`L`, `C`, `R`, `Y`, `S`), sans aucun filet vertical `|`.
   - Convertir les blocs de code en `lstlisting` (`listings/` + `\lstinputlisting` au-delà de ~35 lignes) et les blocs Mermaid en TikZ (`figures/tikz/`) ou Draw.io encapsulés dans `figure` + `cadreFigure`.
   - Remplacer les citations `[@cle]` par `~\parencite{cle}` ou `\textcite{cle}`, et les renvois par `~\cref{...}` / `\Cref{...}`.
   - Respecter les sauts de ligne sémantiques (une phrase par ligne) et l'indentation de 2 espaces.

4. **Raccorder et compiler sans erreur :**
   - Vérifier l'inclusion (`\include{...}` ou `\input{...}`) dans `main.tex`.
   - Lancer l'audit et la compilation complète via [`build-and-verify.md`](./build-and-verify.md).
   - Corriger **toute erreur** et résorber un maximum d'avertissements (`chktex`, Biber, `Overfull \hbox`, `scrlayer-scrpage`).

5. **Rétro-portage vers `template_officiel` (si applicable) :**
   - Si la conversion a nécessité l'ajout d'une macro utile ou la correction d'un environnement dans `config/macros.sty` / `config/packages.sty`, appliquer l'amélioration dans `templates/template_officiel/`.
