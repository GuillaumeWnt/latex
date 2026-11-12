---
name: markdown-to-latex
description: >-
  Use this skill when converting Markdown notes, drafts, or AI-generated technical text into enriched,
  publication-grade LaTeX following templates/template_officiel macros, semantic boxes, booktabs tables,
  and zero-error LuaLaTeX compilation standards.
---

# Compétence Conversion Markdown → LaTeX Enrichi (`markdown-to-latex`)

Cette compétence permet de transformer un document ou brouillon **Markdown** (rédigé rapidement par l'utilisateur ou généré par une IA) en **LaTeX structuré, sémantique et typographiquement irréprochable**, exploitant nativement l'écosystème de `templates/template_officiel/`.

> **Principe directeur :** Ne pas produire un LaTeX « plat » de type convertisseur automatique basique. Il faut **enrichir sémantiquement** le contenu (boîtes `tcolorbox`, macros métier, tableaux `booktabs` + `tabularx`, typographie française, `siunitx`, citations BibLaTeX et figures vectorielles) tout en garantissant **0 erreur et un minimum d'avertissements** à la compilation.

---

## 1. Prérequis & Cible

1. Identifier le projet cible sous `projets/<nom_projet>/` (conforme à `templates/template_officiel/`). S'il n'existe pas encore, suivre le workflow [`new-project.md`](../../workflows/new-project.md).
2. Déterminer le niveau d'insertion :
   - **Chapitre autonome :** `projets/<nom_projet>/content/XX-titre.tex` (commençant par `\chapter{...}` + `\label{ch:...}`, inclus par `\include{...}` dans `main.tex`).
   - **Sous-partie modulaire :** `projets/<nom_projet>/content/<sous-fichier>.tex` (commençant par `\section{...}` + `\label{sec:...}`, inclus par `\input{...}`).
   - **Annexe :** `projets/<nom_projet>/backmatter/appendix-x.tex`.

---

## 2. Protocole de Conversion en 6 Étapes

### Étape 1 — Découpage structurel & ancres (`\label`)
- Mapper la hiérarchie Markdown (`#` → `\chapter` ou `\section` selon le fichier cible ; `##` → `\section` ; `###` → `\subsection` ; `####` → `\subsubsection` ; `#####` → `\paragraph`).
- Ajouter systématiquement un `\label{...}` normalisé sous chaque titre (`ch:`, `sec:`, `subsec:`) en minuscules ASCII sans accents ni espaces.

### Étape 2 — Enrichissement inline & typographie française
- Consulter la table complète dans [`references/mapping-syntaxe.md`](./references/mapping-syntaxe.md).
- Distinguer l'emphase simple (`\emph{...}`) des notions clés à indexer visuellement (`\term{...}`), du code inline (`\code{...}` ou `\texttt{...}`) et des citations textuelles (`\enquote{...}`).
- Transformer systématiquement les valeurs chiffrées et grandeurs physiques (`15 km`, `98,5 %`, `10 à 20 ms`) via `\qty{15}{\kilo\metre}`, `\qty{98.5}{\percent}`, `\qtyrange{10}{20}{\milli\second}` ou `\num{...}`.
- Protéger les espaces insécables `~` devant les appels de citations `~\parencite{...}` et références `~\cref{...}` (sauf `\textcite{...}` et `\Cref{...}` intégrés en sujet).
- Échapper les caractères réservés (`%`, `&`, `#`, `_`, `$`) dans le texte courant ; vérifier lors de la compilation qu'aucun `_` non échappé ne provoque d'erreur mathématique.

### Étape 3 — Transformation des encadrés, alertes et synthèses
Convertir les blocs d'alerte GitHub (`> [!NOTE]`, `> [!TIP]`, `> [!WARNING]`, `> [!CAUTION]`, `> [!IMPORTANT]`) et paragraphes encadrés en environnements `tcolorbox` de `config/macros.sty` :
- Remarques / Notes → `\begin{callout}[Titre] ... \end{callout}`
- Points critiques / Pièges → `\begin{attentionbox}[Titre] ... \end{attentionbox}`
- Définitions / Hypothèses structurantes → `\begin{definitionbox}[Titre] ... \end{definitionbox}` ou `\begin{hypothesis}[Titre] ... \end{hypothesis}` (avec `\label{def:...}` / `\label{hyp:...}` dans le corps)
- Encadrés récapitulatifs / À retenir → `\begin{boiteSynthese}{Titre obligatoire} ... \end{boiteSynthese}`
- Citations simples `> Texte` → `\begin{quote} ... \end{quote}`.

### Étape 4 — Mathématiques, Tableaux, Code & Diagrammes
- **Mathématiques :** convertir strictement `$$ ... $$` en `\[ ... \]` (hors numérotation) ou `\begin{equation}...\label{eq:...}\end{equation}` / `align` (si référencée). Utiliser `\vect{}`, `\mat{}`, `\setR`, `\abs{}`, `\norm{}`, `\diff`, etc.
- **Tableaux Markdown :** convertir en `\begin{table}[htbp]` + `\caption{...}` **au-dessus** + `\label{tab:...}` + `\begin{tabularx}{\textwidth}{...}` + `booktabs` (`\toprule`, `\midrule`, `\bottomrule`, `\addlinespace`), colonnes `L{w}`, `C{w}`, `R{w}`, `Y`, `S` (`siunitx`). **Aucun filet vertical `|`.**
- **Blocs de code :** convertir en `lstlisting` (style `mythesiscode`, avec `language`, `caption`, `label={lst:...}`). Externaliser dans `listings/` via `\lstinputlisting` si > 35 lignes.
- **Diagrammes Mermaid / ASCII :** convertir vers **TikZ natif** (`figures/tikz/<nom>.tex`) ou **Draw.io** (`figures/<nom>.drawio` + export `.pdf`), encapsulé dans `\begin{figure}[htbp]` + `\begin{cadreFigure}[width=...] ... \end{cadreFigure}` + `\caption{...}\label{fig:...}` (voir skill `visual-diagrams`).
- **Images :** placer les fichiers dans `figures/` et utiliser `\includegraphics` dans une `figure` (avec `cadreFigure` si bordure souhaitée).

### Étape 5 — Références, Notes éditoriales & Mise en forme Git
- Convertir les mentions `[Voir sec. X]` / `[Figure 2]` en `~\cref{...}` / `\Cref{...}`.
- Convertir les citations `[@cle]` en `~\parencite{cle}` ou `\textcite{cle}`, et vérifier la présence des clés dans `biblio/references.bib`.
- Transformer les commentaires de brouillon (`TODO:`, `NOTE auteur:`) en `\todoH{commentaire}{texte}` ou `\noteMarge{note}`.
- Formater avec **sauts de ligne sémantiques** (une phrase/clause par ligne) et **indentation à 2 espaces**.

### Étape 6 — Intégration, Compilation & Zéro Erreur / Min Avertissements
1. Vérifier que le fichier créé est bien raccordé dans `main.tex` (`\include` ou `\input`).
2. Exécuter :
   ```powershell
   .\.agents\skills\latex-quality-auditor\scripts\lint-latex.ps1 -TargetDir "projets/<nom_projet>" -RunChkTeX
   .\.agents\skills\latex-document-manager\scripts\compile.ps1 -ProjectDir "projets/<nom_projet>"
   ```
3. Résorber toutes les erreurs, les avertissements `chktex`/`Biber`/`scrlayer-scrpage` et les boîtes `Overfull \hbox` dans `build/main.log`.
4. Si une macro ou adaptation manquante a dû être ajoutée dans `config/macros.sty`, proposer/effectuer son rétro-portage vers `templates/template_officiel/`.

---

## 3. Référence associée
- **[Table de correspondance Markdown → LaTeX (`mapping-syntaxe.md`)](./references/mapping-syntaxe.md)** : syntaxe exhaustive des macros et exemples avant/après.
