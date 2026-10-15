# Plan d'Attaque : Refonte Intégrale du Contenu de `template_principal`
## Document Modèle, Guide Typographique et Tutoriel Exhaustif de `ClasseGuillaume.cls`

---

## 1. Vision et Objectifs du Projet

### 1.1. Ambition
Transformer le contenu de `templates/template_principal` en un **document de référence complet**, à la fois :
1. **Un cours magistral et tutoriel pratique** sur la rédaction académique et scientifique moderne avec LaTeX (LuaLaTeX).
2. **Une vitrine exhaustive** démontrant **100 % des fonctionnalités, commandes, environnements, styles et options** offerts par [`ClasseGuillaume.cls`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_principal/ClasseGuillaume.cls).
3. **Un modèle d'esthétique éditoriale** : mise en page aérée, charte graphique raffinée, équilibre des blancs tournants, encadrés élégants et typographie choisie avec parcimonie pour un rendu de niveau publication internationale.

### 1.2. Contraintes Fondamentales
* **Intégrité absolue de la classe :** Le fichier [`ClasseGuillaume.cls`](file:///c:/Users/guill/dev/perso/latex/general/templates/template_principal/ClasseGuillaume.cls) ne doit **subir aucune modification**. Tout le travail porte exclusivement sur la refonte des fichiers de contenu (`main.tex`, `chapters/`, `tables/`, `bib/`).
* **Exhaustivité sans omission :** Chaque macro, chaque niveau de sectionnement, chaque géométrie, chaque style d'en-tête/pied de page et chaque option de classe doit être mis en scène et expliqué.
* **Sobriété et Parcimonie Typographique :**
  - **Gras (`\textbf`)** : réservé aux notions clés et concepts pivots (jamais de phrases entières en gras).
  - **Italique (`\textit` / `\emph`)** : réservé à l'emphase sémantique fine, aux termes étrangers ou locutions latines (*a priori*, *in situ*).
  - **Code (`\texttt`)** : pour les commandes LaTeX, noms de fichiers et paramètres.
  - **Surlignage (`\highLight`)** : réservé aux annotations et mises en valeur critiques.
* **Charte Chromatique Maîtrisée :** Exposition claire de la palette de couleurs (`primaryColor`, `secondaryColor`, `accentColor`, `mdtRed`) et tutoriel montrant comment basculer d'une harmonie à une autre.
* **Standards Techniques :**
  - Respect strict des *semantic line breaks* (une phrase/clause par ligne dans les sources `.tex`).
  - Aucun tableau avec barres verticales (respect absolu du standard `booktabs`).
  - Zéro erreur de compilation, zéro débordement dans la marge (`overfull \hbox`).
  - Compilation propre et reproductible via `latexmk -lualatex -outdir=build`.

---

## 2. Inventaire Exhaustif des Fonctionnalités de `ClasseGuillaume.cls`

Le tableau ci-dessous répertorie chaque brique technique présente dans la classe et son affectation dans le futur document :

| Domaine | Élément / Macro / Environnement de `ClasseGuillaume` | Rôle et Spécificité | Chapitre de Démonstration |
| :--- | :--- | :--- | :--- |
| **Options de classe** | `todoNote` | Active ou désactive le mode révision (notes et liste des todos) | Chapitre 7 & Annexe A |
| | `font=calibri` *(défaut)* | Police Windows directe avec repli automatique `./Fonts/` (Overleaf) | Chapitre 1 & Annexe A |
| | `font=heros` | TeX Gyre Heros (Helvetica libre native TeX Live) | Chapitre 1 & Annexe A |
| | `font=libertinus` | Libertinus Serif (police académique avec empattements) | Chapitre 1 & Annexe A |
| | `font=comicsans` | Police Comic Sans MS (système ou locale) | Chapitre 1 & Annexe A |
| | `font=standard` | Latin Modern standard TeX Live | Chapitre 1 & Annexe A |
| **Structure & Titres** | `\part` | Grande page de garde de partie majestueuse KOMA-Script | Parties I, II, III, IV |
| | `\chapter` | Numérotation Romaine (`I`, `II`), centré, police Asap, couleur primaire | Tous chapitres |
| | `\addchap` / `\chapter*` | Chapitre non numéroté mais présent dans la TOC et en-têtes | Frontmatter & Backmatter |
| | `\section`, `\subsection` | Numérotation hiérarchique arabe (`I.1`, `I.1.1`), palette chromatique | Chapitre 2 |
| | `\subsubsection` | Sous-sous-section pour granularité fine | Chapitre 2 |
| | `\paragraph` | Paragraphe en ligne précédé d'une puce discrète (`\textbullet~`) | Chapitre 2 |
| | `\subparagraph` | Niveau terminal avec retrait spécifique | Chapitre 2 |
| | `\addsec` | Section non numérotée mais répertoriée dans la TOC | Chapitre 2 |
| **Couleurs & Styles** | `primaryColor`, `secondaryColor` | Palette de base (NavyBlue, TealBlue, Bittersweet, mdtRed) | Chapitre 2 & Annexe B |
| | `\colorlet{...}{...}` | Mécanisme de bascule rapide vers une nouvelle charte graphique | Chapitre 2 & Annexe B |
| | `\highLight[couleur]{...}` | Surlignage couleur sécurisé via `lua-ul` / `luacolor` | Chapitre 2 & 7 |
| **Polices & Typo** | `\setmainfont`, `\setsansfont` | Détection intelligente système vs TeX Live vs fallback `./Fonts/` | Chapitre 1 |
| | `\AsapFont` | Police dédiée pour les titres de chapitres | Chapitre 1 |
| | `\CalibriFont`, `\ComicSansMSFont` | Commandes locales pour démonstrations ou encarts spécifiques | Chapitre 1 |
| | `\onehalfspacing` vs `\setstretch{1}` | Interligne 1.5 dans le corps mais strictement simple dans les titres | Chapitre 1 |
| | Paramétrage `microtype` | Élimination des veuves/orphelines (`clubpenalty`, `widowpenalty`) | Chapitre 1 |
| **Géométries Multiples** | `\geometrieLarge` (`\geometrieExemple`) | Marges compactes (1.2 cm) pour couverture, posters, grands tableaux | Frontmatter & Chapitre 6 |
| | `\geometrieWord` | Marges 2.5 cm avec marge de notes de 2.2 cm pour relecture | Corps de texte & Chapitre 6 |
| | `\geometrieStandard` | Restauration de la géométrie KOMA-Script d'origine (`DIV=12`) | Chapitre 6 |
| | Mode Paysage (`pdflscape`) | Rotation dynamique de page pour tableaux et graphiques larges | Chapitre 4 & 6 |
| **En-têtes & Pieds** | Style `scrheadings` *(défaut)* | Ligne supérieure, numéro en gras, titre de section dynamique | Chapitre 6 |
| | Style `StyleFocus` | Style épuré sans filet, marque de section centrée | Chapitre 6 |
| | Style `StyleTest` | Mode diagnostic (`\jobname.tex`, `p. X / LastPage`, marque `[DEBUG VIEW]`) | Chapitre 6 |
| | `plain.scrheadings`, `empty` | Styles sobres pour débuts de chapitres ou pleines pages visuelles | Chapitre 6 |
| **Colonnes Multiples** | `multicol` (`2` et `3` colonnes) | Bascule dynamique locale en 2 ou 3 colonnes avec filet séparateur | Chapitre 6 |
| | Option globale `twocolumn` | Mode 2 colonnes natif de KOMA-Script pour formats type articles | Chapitre 6 |
| **Logo Dynamique** | Couche `logo.layer` (`scrlayer`) | Logo en filigrane positionné dynamiquement (`\paperwidth - 1.8cm`) | Chapitre 6 |
| | `\masquerLogo`, `\afficherLogo` | Masquage/activation du logo selon les pages (garde, annexes) | Frontmatter & Chapitre 6 |
| **Boîtes tcolorbox** | Environnement `cadreFigure` | Boîte arrondie avec contour primaire pour valoriser une figure/code | Chapitre 5 |
| | Environnement `boiteSynthese{Titre}` | Encadré coloré (`primaryColor!6`) pour synthèses, astuces, règles | Tous chapitres |
| **Flottants & Listes** | Flottant `illustration` | Nouveau type de flottant indépendant pour supports iconographiques | Chapitre 5 |
| | `\listofillustrations` | Table dédiée des illustrations (distincte de la table des figures) | Backmatter |
| | `caption` et `subcaption` | Format suspendu (`hang`), sans-serif petite, labels gras, tableheadings | Chapitres 3, 4, 5 |
| **Tableaux** | `booktabs` + `tabularx` + `longtable` | Tableaux scientifiques sans barres verticales, multipages, ajustés | Chapitre 4 |
| **Sciences & Maths** | `unicode-math` (`XITS Math`) | Typographie mathématique OpenType moderne | Chapitre 3 |
| | `siunitx` (configuration FR) | Formatage français : `\qty`, `\qtyrange`, `\unit`, `\num` | Chapitre 3 |
| **Annotations / Notes** | `\todoH{style}{couleur}{note}{texte}` | Surlignage `lua-ul`, troncature > 30 car. avec `\pdftooltip`, lien retour | Chapitre 7 |
| | Profils de relecteurs | `GuillaumeStyle`, `MarieStyle`, `FloraStyle`, `TestStyle` | Chapitre 7 |
| | `\listoftodos` & `\label{table_todos}` | Table récapitulative des tâches en début de document | Frontmatter & Chapitre 7 |
| | `\missingfigure` | Emplacement réservé pour figure en attente | Chapitre 7 |
| **Bibliographie** | `biblatex` + `biber` (Vancouver) | Style médical/scientifique numéroté, `backref`, DOI, URL | Chapitre 8 |
| | Localisation française | Gestion soignée de « consulté le » (`urldate`) et « disponible sur » | Chapitre 8 |
| | `csquotes` | Guillemets français automatiques (`« »`) avec `\enquote{...}` | Chapitre 8 |
| **Liens & Références**| `cleveref` | Référencement intelligent en français (`\cref`, `\Cref`, `\cpageref`) | Tous chapitres |
| | `xurl` | Césure irréprochable des URL longues sans dépassement | Chapitres 7 & 8 |
| | `pdfpages` | Insertion de documents PDF externes multipages en annexe | Annexe D |

---

## 3. Plan Détaillé du Nouveau Document

Le document s'intitulera :
> **« Le Guide Ultime de la Rédaction Scientifique et Académique avec LaTeX »**  
> *Manuel pratique, vitrine typographique et démonstration exhaustive de `ClasseGuillaume`*

---

### 3.1. Pré-Contenu (Frontmatter)

* **Page de titre (`chapters/00_frontmatter/titlepage.tex`) :**
  - En `\geometrieLarge` (marges 1.2 cm), `\masquerLogo`.
  - En-tête universitaire prestigieux (UCLouvain / Faculté de Médecine), titre percutant, sous-titre, métadonnées complètes, cartouche d'auteurs et superviseurs, date dynamique.
* **Tableau de Bord des Révisions (`main.tex` / `table_todos`) :**
  - `\listoftodos[Tableau de Bord des Révisions et Tâches de Rédaction]`.
  - Cible cliquable `\label{table_todos}` servant d'atterrissage pour les liens retour de chaque `\todoH`.
* **Résumé Bilingue (`chapters/00_frontmatter/abstract.tex`) :**
  - Résumé en français (objectifs du guide, paradigme LuaLaTeX, modularité).
  - Abstract en anglais (reproductibilité, microtypographie, typographie académique).
  - Mots-clés (*Keywords*) normalisés.
* **Avertissement Pédagogique et Remerciements (`chapters/00_frontmatter/acknowledgements.tex`) :**
  - Note expliquant la double nature du document (à la fois guide de lecture et code source didactique à copier-coller).
* **Table des Matières Générale :**
  - `\tableofcontents` détaillée jusqu'au niveau sous-section.

---

### 3.2. PARTIE I : FONDATIONS TYPOGRAPHIQUES, ARCHITECTURE & COULEURS
*Démontre la structure KOMA-Script `\part`, la modularité et l'identité visuelle.*

#### Chapitre 1 : Architecture Modulaire et Moteur LuaLaTeX
* **Section 1.1 : L'Architecture Modulaire Idéale d'un Projet LaTeX**
  - L'arborescence standardisée (`main.tex`, `chapters/`, `tables/`, `bib/`, `scripts/`, `build/`).
  - Les principes Git-friendly : *semantic line breaks* (une phrase par ligne pour des `git diff` lisibles).
  - Compilation automatisée via `latexmk` et script PowerShell `compile.ps1`.
* **Section 1.2 : La Révolution LuaLaTeX et la Gestion Moderne des Polices**
  - Fin des packages obsolètes (`inputenc`, `fontenc`).
  - Démonstration des modes de chargement : Polices système Windows directes (`\setmainfont{Calibri}`) vs Polices universelles TeX Live (`TeX Gyre Heros`, `Libertinus`) vs Repli local Overleaf (`./Fonts/`).
  - Présentation des options de classe (`font=calibri`, `font=heros`, `font=libertinus`, `font=comicsans`, `font=standard`).
  - Démonstration des commandes de polices locales : `\AsapFont`, `\CalibriFont`, `\ComicSansMSFont`.
* **Section 1.3 : Interlignes et Microtypographie**
  - Maîtrise de l'interligne : corps en `\onehalfspacing` (1.5) mais titres protégés en interligne simple (`\setstretch{1}`).
  - Microtypographie (`microtype`) : pénalités empêchant les lignes veuves et orphelines.

#### Chapitre 2 : Hiérarchie des Titres, Typographie Textuelle & Charte Chromatique
* **Section 2.1 : Démonstration Complète de Tous les Niveaux de Sectionnement**
  - `\part` : la grande page de garde de partie (structure KOMA-Script).
  - `\chapter` : numérotation romaine, centré, police Asap, couleur primaire.
  - `\addchap` et `\chapter*` : chapitres non numérotés avec ou sans présence dans la table des matières et en-têtes.
  - `\section` et `\addsec` : sections majeures avec numérotation arabe hiérarchique et couleur secondaire.
  - `\subsection` : sous-sections équilibrées en gris foncé.
  - `\subsubsection` : granularité fine pour analyses techniques détaillées.
  - `\paragraph` : la commande personnalisée de la classe, avec **puce en ligne colorée** (`\textbullet~`) évitant le saut de ligne inutile.
  - `\subparagraph` : niveau terminal avec indentation soignée.
* **Section 2.2 : Typographie Textuelle et Règle de Parcimonie**
  - Pourquoi le "trop de gras" tue la lisibilité : quand utiliser `\textbf{...}` (mots-clés forts uniquement).
  - L'emphase sémantique fine avec `\emph{...}` et l'italique avec `\textit{...}` (termes latins ou étrangers).
  - Le code et les identifiants avec `\texttt{...}`.
  - Le surlignage doux et non destructif avec `\highLight[couleur]{...}` (paquet `lua-ul`).
* **Section 2.3 : Charte Graphique, Théorie des Couleurs et Personnalisation**
  - La palette par défaut de `ClasseGuillaume` :
    - `primaryColor` (NavyBlue : autorité, structure, titres principaux).
    - `secondaryColor` (TealBlue : sections, sous-titres, transitions).
    - `accentColor` (Bittersweet : points d'attention, alertes).
    - `mdtRed` (red!50!black : liens URL discrets).
  - Comment changer l'ambiance du document en 4 lignes de code via `\colorlet{...}{...}`.
  - Présentation de 3 palettes professionnelles alternatives prêtes à l'emploi (Bordeaux/Or, Émeraude/Ardoise, Tech/Cobalt).

---

### 3.3. PARTIE II : SCIENCES, MATHÉMATIQUES & TABLEAUX PROFESSIONNELS
*Démontre la rigueur scientifique, les mathématiques OpenType et les tableaux booktabs.*

#### Chapitre 3 : Sciences, Typographie Mathématique et Unités Internationales
* **Section 3.1 : Mathématiques Modernes avec `unicode-math` et `mathtools`**
  - Comparatif pratique : pourquoi bannir `$$...$$` au profit de `\[ ... \]`, `equation`, `align`, `gather`, `multline`.
  - Typographie mathématique OpenType avec `XITS Math`.
  - Démonstration de formules complexes : intégrales multiples, matrices, systèmes d'équations différentielles, équations numérotées et non numérotées.
* **Section 3.2 : Gestion Rigoureuse des Grandeurs et Unités avec `siunitx`**
  - Configuration automatique en français (`locale = FR` : virgule décimale, espaces fines insécables).
  - Écriture de valeurs avec unités : `\qty{120.5}{\kilo\meter\per\hour}`, `\qty{37.2}{\degreeCelsius}`, `\qty{4.7}{\kilo\ohm}`.
  - Plages de tolérance et intervalles : `\qtyrange{10}{25}{\milli\meter}`.
  - Équations aux dimensions et unités pures : `\unit{\newton\meter}`.
  - Grands nombres et notation scientifique : `\num{1.380649e-23}`.

#### Chapitre 4 : Tableaux Scientifiques et Typographie Tabulaire
* **Section 4.1 : Les Règles d'Or de la Typographie Tabulaire**
  - Pourquoi bannir définitivement les lignes verticales (`|`).
  - Utilisation de `booktabs` : `\toprule`, `\midrule`, `\bottomrule`, `\cmidrule`.
* **Section 4.2 : Tableaux Avancés en Situation Réelle**
  - Tableau ajusté à la largeur de page (`tabularx` avec colonnes automatiques `X`).
  - Cellules fusionnées (`multirow`, `multicolumn`) et alignements verticaux soignés.
  - Grand tableau multipage avec `longtable` (répétition de l'en-tête avec mention « suite », pied de tableau).
  - Tableau pivoté en paysage (`begin{landscape}` et `sidewaystable`) pour les synthèses massives.
  - Insertion de notes et renvois méthodologiques propres sous le tableau (sans polluer les notes de bas de page).

---

### 3.4. PARTIE III : DYNAMIQUE DE PAGE, MISE EN PAGE COMPLEXE & GRAPHISME
*Démontre les changements dynamiques de géométrie, les styles de page KOMA, les colonnes multiples et les boîtes.*

#### Chapitre 5 : Figures, Illustrations et Boîtes Décoratives (`tcolorbox`)
* **Section 5.1 : Flottants Classiques vs Type d'Illustration Dédié**
  - Environnement `figure` standard et sous-figures coordonnées avec `subcaption` (`(a)`, `(b)`).
  - L'environnement sur-mesure `illustration` : pourquoi et comment isoler les schémas artistiques ou iconographiques dans une table d'illustrations dédiée (`\listofillustrations`).
* **Section 5.2 : Valorisation Graphique avec les Boîtes de la Classe**
  - L'environnement `cadreFigure` : encadrement stylisé à coins arrondis et bordure primaire pour mettre en valeur graphiques ou schémas TikZ.
  - L'environnement `boiteSynthese{Titre}` : encadré coloré avec fond teinté (`primaryColor!6`), idéal pour les résumés, remarques cruciales et théorèmes.
  - Boîte d'alerte / attention avec filet vertical (`leftbar` tcolorbox).
  - Démonstration d'un graphique vectoriel natif `TikZ` inséré au sein d'un `cadreFigure`.

#### Chapitre 6 : Géométries Multiples, Styles de Pages, Colonnes & Logo Dynamique
* **Section 6.1 : Démonstration des Changements Répétés de Géométrie**
  - Problème classique en LaTeX : comment alterner les marges sans casser le document ?
  - Bascule en direct :
    1. `\geometrieWord` : marges équilibrées 2.5 cm + marge de notes de 2.2 cm pour annotations.
    2. `\geometrieLarge` : marges compactes 1.2 cm pour maximiser l'espace utile.
    3. `\geometrieStandard` : retour immédiat au canon KOMA-Script DIV=12.
    4. Mode paysage complet avec `\begin{landscape}` (paquet `pdflscape`) avec rotation automatique du PDF.
* **Section 6.2 : Démonstration des Styles d'En-têtes et Pieds de Page (`scrlayer-scrpage`)**
  - Bascules successives en direct au cours du chapitre :
    1. Style `scrheadings` (défaut) : ligne supérieure fine, titre courant, pagination élégante.
    2. Style `StyleFocus` : style épuré sans ligne, centré, pour lectures soutenues.
    3. Style `StyleTest` : style de débogage affichant le fichier source `\jobname.tex`, `LastPage`, et le tag orange `[DEBUG VIEW]`.
    4. Styles `plain.scrheadings` et `empty`.
* **Section 6.3 : Mises en Page Multi-Colonnes (2 et 3 colonnes)**
  - Pourquoi le multi-colonnes améliore le confort de lecture sur les textes denses ou fiches techniques.
  - Démonstration locale avec `\begin{multicols}{2}` : texte sur 2 colonnes avec filet vertical fin (`\columnseprule`).
  - Démonstration locale avec `\begin{multicols}{3}` : format compact pour lexiques, nomenclatures ou paramètres techniques.
  - Titre transversal pleine largeur surmontant deux colonnes équilibrées.
  - Comparaison avec l'option globale `twocolumn` de la classe.
* **Section 6.4 : Le Filigrane Dynamique (`logo.layer`) et Documents Externes (`pdfpages`)**
  - Fonctionnement du calque `logo.layer` positionné automatiquement par rapport au bord droit (`\paperwidth - 1.8cm`).
  - Démonstration de `\masquerLogo` et `\afficherLogo`.
  - Fusion d'annexes PDF multipages via `\includepdf` de `pdfpages` avec préservation de la pagination.

---

### 3.5. PARTIE IV : COLLABORATION, RÉFÉRENCEMENT & POST-CONTENU
*Démontre les outils de relecture multi-auteurs, les liens cliquables et la bibliographie Biber.*

#### Chapitre 7 : Outils Collaboratifs, Système d'Annotation `\todoH` & Révision
* **Section 7.1 : Le Système Exclusif d'Annotations `\todoH`**
  - Les 5 prouesses techniques résolues par la classe :
    1. Surlignage couleur incassable via `lua-ul`/`luacolor` (insensible aux césures).
    2. Troncature automatique des messages dépassant 30 caractères dans la marge.
    3. Infobulle interactive (`\pdftooltip` de `pdfcomment`) affichant l'intégralité du texte au survol de la souris dans le visualiseur PDF.
    4. Détection intelligente des commandes LaTeX (les liens `\url` ne sont pas tronqués et sont césurés proprement par `xurl`).
    5. Lien hypertexte cliquable depuis le texte surligné vers le tableau récapitulatif `\listoftodos` !
* **Section 7.2 : Démonstration Multi-Auteurs en Situation Réelle**
  - Notes attribuées aux différents profils : `GuillaumeStyle`, `MarieStyle`, `FloraStyle`, `TestStyle`.
  - Réservation d'emplacements pour schémas futurs avec `\missingfigure`.
  - Démonstration de l'option de classe `todoNote` : passage instantané en mode publication finale.

#### Chapitre 8 : Référencement Croisé Moderne & Bibliographie Académique
* **Section 8.1 : Références Sémantiques Automatiques avec `cleveref`**
  - Comparatif `\ref` vs `\cref` / `\Cref` / `\cpageref`.
  - Prise en charge automatique des étiquettes en français (« l'équation (1) », « le tableau 2 », « la figure 3 », « l'illustration 4 »).
* **Section 8.2 : Gestion Bibliographique avec `biblatex` et `biber` (Style Vancouver)**
  - Pourquoi le style Vancouver médical/académique numéroté.
  - Démonstration des types de sources : articles de revues (`@article`), livres (`@book`), chapitres (`@incollection`), thèses (`@thesis`), sites web (`@online`).
  - Fonctionnalités automatiques de `ClasseGuillaume` :
    - Dates de consultation francisées : « consulté le » (`urldate`).
    - Liens sources francisés : « disponible sur » (`url`).
    - Liens retour `backref` : affichage des pages où la source a été citée.
  - Typographie des citations avec `csquotes` (`\enquote{...}`).

---

### 3.6. Annexes (Appendices)

* **Annexe A : Aide-Mémoire Complet des Commandes de `ClasseGuillaume.cls`**
  - Tableau exhaustif de toutes les macros, options et environnements avec syntaxe, paramètres et exemple d'utilisation.
* **Annexe B : Guide des Palettes de Couleurs et Personnalisation Esthétique**
  - Nuanciers complets en couleurs (Navy/Teal, Bordeaux/Or, Émeraude/Ardoise, Tech/Cobalt).
  - Code prêt à l'emploi pour personnaliser `ClasseGuillaume` selon l'institution ou l'entreprise.
* **Annexe C : Guide d'Outillage, Compilation et Bonnes Pratiques Git**
  - Utilisation de `latexmk`, configuration `.latexmkrc`, script PowerShell `compile.ps1` et `clean.ps1`.
  - Gestion des encodages de console sous Windows (UTF-8 / CP 65001).
* **Annexe D : Spécimen de Document PDF Externe inséré via `pdfpages`**
  - Exemple fonctionnel d'inclusion PDF multipage avec en-tête conservé.

---

### 3.7. Post-Contenu (Backmatter)

* **Liste des Figures (`\listoffigures`)**
* **Liste des Illustrations (`\listofillustrations`)** (via le flottant personnalisé `loi`)
* **Liste des Tableaux (`\listoftables`)**
* **Bibliographie Générale (`\printbibliography[heading=bibintoc]`)** avec liens retour `backref`

---

## 4. Tableau Pédagogique : « LaTeX Standard vs ClasseGuillaume »

| Fonctionnalité | En LaTeX Standard (Vanilla) | Avec `ClasseGuillaume.cls` |
| :--- | :--- | :--- |
| **Gestion des polices** | Déclarations complexes `fontspec` avec chemins manuels et fichiers `.ttf` | Détection automatique : système Windows direct, TeX Live natif ou repli Overleaf |
| **Interligne des titres** | `\onehalfspacing` étire affreusement les titres sur plusieurs lignes | Protection automatique : interligne 1.5 pour le texte, interligne 1 pour les titres |
| **Puces de paragraphes** | `\paragraph{Titre}` renvoie à la ligne ou nécessite une configuration manuelle | Puce discrète colorée en ligne prête à l'emploi (`\textbullet~`) |
| **Hiérarchie de titres** | `\part` et `\chapter` standard sans couleur ni typographie fine | Titres soignés en `\AsapFont`, numérotation romaine centrée, palette harmonieuse |
| **Changement de marges** | `\newgeometry` à réécrire entièrement à chaque page | 3 commandes simples : `\geometrieWord`, `\geometrieLarge`, `\geometrieStandard` |
| **Styles de page** | Paquet complexe `fancyhdr` aux conflits récurrents avec KOMA-Script | Intégration native `scrlayer-scrpage` avec `scrheadings`, `StyleFocus`, `StyleTest` |
| **Mises en page multi-colonnes**| `twocolumn` rigide cassant la mise en page de toute la page | Flexibilité locale `multicol` (2 ou 3 colonnes) avec filets élégants |
| **Notes de révision** | `\todo` standard déborde des marges, casse avec UTF-8, sans infobulle | `\todoH` : surlignage `lua-ul`, troncature > 30 car., infobulle PDF, lien retour vers `\listoftodos` |
| **Illustrations dédiées** | Les schémas se mélangent aux figures ordinaires dans `\listoffigures` | Flottant `illustration` avec sa propre table des illustrations `\listofillustrations` |
| **Mise en valeur visuelle** | Environnements bruts ou code `tcolorbox` lourd à réinventer | `cadreFigure` (coins arrondis) et `boiteSynthese` (fond teinté) prêts à l'emploi |
| **Logo de structure** | Montage complexe de paquets d'en-tête avec décalages imprécis | Couche `scrlayer` dynamique avec commandes instantanées `\masquerLogo` et `\afficherLogo` |
| **Style Vancouver FR** | Chaînes par défaut en anglais ("visited on", "available from") | Localisation soignée : « consulté le », « disponible sur », liens retour `backref` |
| **Références croisées** | `\ref{fig:mon_label}` oblige à taper "figure" manuellement | `\cref{mon_label}` détecte le type, accorde en français et met en majuscule avec `\Cref` |

---

## 5. Nouvelle Arborescence Cible des Fichiers de Contenu

```text
templates/template_principal/
├── .latexmkrc
├── ClasseGuillaume.cls                <-- STRICTEMENT INTACT
├── main.tex                           <-- Structuration globale (Parties I à IV + Annexes)
├── README.md                          <-- Documentation synthétique du template
├── bib/
│   └── references.bib                 <-- Corpus bibliographique riche et diversifié
├── chapters/
│   ├── 00_frontmatter/
│   │   ├── titlepage.tex              <-- Page de titre élégante en géométrie large
│   │   ├── abstract.tex               <-- Résumé bilingue FR/EN avec mots-clés
│   │   └── acknowledgements.tex       <-- Remerciements et mot d'avertissement
│   ├── 01_fondations/
│   │   ├── sec01_architecture_projet.tex
│   │   ├── sec02_lualatex_polices.tex
│   │   └── sec03_interlignes_microtype.tex
│   ├── 02_titres_typo_couleurs/
│   │   ├── sec01_niveaux_sectionnement.tex
│   │   ├── sec02_typographie_parcimonie.tex
│   │   └── sec03_charte_chromatique.tex
│   ├── 03_sciences_maths/
│   │   ├── sec01_formules_mathematiques.tex
│   │   └── sec02_unites_siunitx.tex
│   ├── 04_tableaux/
│   │   ├── sec01_regles_booktabs.tex
│   │   └── sec02_tableaux_avances.tex
│   ├── 05_illustrations_boites/
│   │   ├── sec01_figures_illustrations.tex
│   │   └── sec02_boites_tcolorbox_tikz.tex
│   ├── 06_geometries_styles_colonnes/
│   │   ├── sec01_geometries_multiples.tex
│   │   ├── sec02_styles_en_tetes_pieds.tex
│   │   ├── sec03_multi_colonnes.tex
│   │   └── sec04_logo_documents_externes.tex
│   ├── 07_collaboration_todos/
│   │   ├── sec01_systeme_todoH.tex
│   │   └── sec02_profils_relecteurs.tex
│   ├── 08_references_bibliographie/
│   │   ├── sec01_references_cleveref.tex
│   │   └── sec02_bibliographie_vancouver.tex
│   └── 99_annexes/
│       ├── annexe_a_cheatsheet_macros.tex
│       ├── annexe_b_guide_palettes_couleurs.tex
│       ├── annexe_c_guide_outillage_git.tex
│       └── annexe_d_specimen_externe.tex
├── Fonts/                             <-- Fallback Overleaf/Linux préservé
├── images/
│   ├── FacMedLogo.jpg
│   ├── logo_test.png
│   ├── UCLouvainLogo.png
│   └── diagrams/                      <-- Schémas et graphiques didactiques
├── scripts/
│   ├── clean.ps1
│   └── compile.ps1
└── tables/                            <-- Fichiers modulaires de tableaux complexes
    ├── tableau_comparatif_classe.tex
    ├── tableau_donnees_multipage.tex
    ├── tableau_paysage_synthese.tex
    └── tableau_synthese_mesures.tex
```

---

## 6. Feuille de Route d'Exécution par Étapes

* [ ] **Jalon 0 : Validation finale du plan d'attaque par l'utilisateur.**
* [ ] **Jalon 1 : Préparation de l'infrastructure de contenu**
  - Nettoyage et restructuration des dossiers `chapters/` et `tables/`.
  - Enrichissement de `bib/references.bib` avec des entrées académiques variées.
* [ ] **Jalon 2 : Rédaction du Frontmatter et de la Partie I (Fondations, Titres, Typographie & Couleurs)**
  - Page de garde `\geometrieLarge`, résumé bilingue, tableau de révision `\listoftodos`.
  - Chapitre 1 : modularité, LuaLaTeX, polices, microtypographie.
  - Chapitre 2 : tous les niveaux de titres (`\part` à `\subparagraph`), règles de gras/italique sobre, palettes de couleurs.
* [ ] **Jalon 3 : Rédaction de la Partie II (Sciences, Mathématiques & Tableaux)**
  - Chapitre 3 : `unicode-math`, `XITS Math`, équations complexes, `siunitx` FR.
  - Chapitre 4 : Règles `booktabs`, `tabularx`, `longtable`, tableau paysage `pdflscape`.
* [ ] **Jalon 4 : Rédaction de la Partie III (Illustrations, Boîtes, Géométries, Styles & Colonnes)**
  - Chapitre 5 : Figures, flottant `illustration`, `cadreFigure`, `boiteSynthese`, TikZ.
  - Chapitre 6 : Bascules en direct `\geometrieWord`/`\geometrieLarge`/`\geometrieStandard`, bascules `scrheadings`/`StyleFocus`/`StyleTest`, 2 et 3 colonnes `multicol`, calque `logo.layer`.
* [ ] **Jalon 5 : Rédaction de la Partie IV (Collaboration `\todoH`, Bibliographie & Références)**
  - Chapitre 7 : Démonstration complète de `\todoH` (troncature, `\pdftooltip`, liens retour, styles).
  - Chapitre 8 : `cleveref`, `csquotes`, `biblatex` Vancouver, liens `backref`.
* [ ] **Jalon 6 : Rédaction des Annexes (Cheatsheet complet, Nuanciers de couleurs & Guide d'outillage)**
  - Annexe A : Tableau exhaustif de toutes les macros et commandes.
  - Annexe B : Guide visuel des palettes de couleurs prêtes à l'emploi.
  - Annexe C : Guide `latexmk`, PowerShell, Git.
  - Annexe D : Inclusion PDF via `pdfpages`.
* [ ] **Jalon 7 : Assemblage de `main.tex`, compilation de validation et vérification finale**
  - Compilation complète avec LuaLaTeX via `compile.ps1`.
  - Vérification des liens hypertexte (liens `\todoH` -> `\listoftodos`, citations -> bibliographie, `backref`).
  - Validation typographique : 0 erreur, 0 avertissement de débordement (`overfull \hbox`).
