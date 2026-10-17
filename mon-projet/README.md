# Architecture Modulaire LaTeX (`scrbook`)

Ce projet propose une architecture \LaTeX{} professionnelle, modulaire et hautement pérenne, conçue sur une base vierge de la classe **KOMA-Script** (`scrbook`).

Il applique rigoureusement le principe de **séparation des préoccupations** (*Separation of Concerns*) : le style, les profils de diffusion, les macros métier, la bibliographie et les chapitres rédactionnels sont totalement découplés.

---

## 1. Arborescence Détaillée du Projet

```text
mon-projet/
├── main.tex                 # Point d'entrée unique (le chef d'orchestre du document)
├── latexmkrc                # Automatisation de compilation (LuaLaTeX + Biber + outdir=build)
├── .gitignore               # Exclusion des fichiers temporaires de compilation
├── README.md                # Documentation architecturale et guide d'utilisation
│
├── mythesis.cls             # CLASSE : architecture globale, métadonnées, KOMA-Script
├── mythesis-print.clo       # OPTION DE CLASSE : profil impression papier & reliure (BCOR, monochrome)
├── mythesis-screen.clo      # OPTION DE CLASSE : profil écran & liseuse (marges symétriques, hyperliens)
│
├── config/
│   ├── packages.sty         # STYLE : appel et configuration fine des paquets tiers
│   └── macros.sty           # STYLE : commandes mathématiques, raccourcis et boîtes tcolorbox
│
├── biblio/
│   ├── references.bib       # BASE DE DONNÉES : notices bibliographiques BibLaTeX
│   ├── custom-style.bbx     # BIBLATEX : mise en page de la bibliographie finale
│   └── custom-style.cbx     # BIBLATEX : mise en page et liens des citations dans le corps
│
├── frontmatter/             # Pages liminaires (numérotation romaine)
│   ├── titlepage.tex        # Page de titre institutionnelle moderne avec jury
│   ├── acknowledgements.tex # Remerciements (\addchap)
│   └── abstract.tex         # Résumés bilingues français / anglais et mots-clés
│
├── content/                 # Corps de l'ouvrage découpé en chapitres autonomes
│   ├── 01-introduction.tex  # Chapitre 1 : Contexte, verrous et organisation
│   ├── 02-etat-de-l-art.tex # Chapitre 2 : Revue bibliographique et tableau comparatif
│   ├── 03-methodologie.tex  # Chapitre 3 : Modélisation mathématique et schéma TikZ
│   └── 04-resultats.tex     # Chapitre 4 : Validation expérimentale et métrologie SI
│
├── backmatter/              # Documents de clôture
│   ├── appendix-a.tex       # Annexe A : Preuves mathématiques et tables de paramètres
│   └── glossary.tex         # Table des sigles / acronymes et glossaire technique
│
└── figures/                 # Médias graphiques et dessins vectoriels
    ├── logo.pdf             # Logo institutionnel vectoriel (utilisé en page de titre)
    └── schema-principe.tikz # Schéma TikZ modulaire inclus via \input{}
```

---

## 2. Principes Fondateurs et Fonctionnement

### A. Le rôle pivot de `main.tex`
Le fichier `main.tex` ne contient **aucune instruction de style** ni aucun paramétrage de géométrie. Il agit comme un chef d'orchestre :
1. Déclaration de la classe et de son profil : `\documentclass[screen]{mythesis}` ou `\documentclass[print]{mythesis}`.
2. Définition des métadonnées (`\title`, `\author`, `\institution`, `\supervisor`, etc.).
3. Découpage standardisé de l'ouvrage :
   - `\frontmatter` : préliminaires en chiffres romains (`titlepage`, `acknowledgements`, `abstract`, `\tableofcontents`, `\listoffigures`, `\listoftables`).
   - `\mainmatter` : développement scientifique avec `\include{content/...}`.
   - `\appendix` : annexes avec `\include{backmatter/appendix-a}`.
   - `\backmatter` : glossaire et `\printbibliography`.

### B. Le mécanisme des fichiers d'options (`.clo`)
Plutôt que d'insérer des conditions `\if...` complexes et dispersées dans le texte, le projet utilise le mécanisme natif des fichiers **`.clo`** (*Class Option*) :
- **`mythesis-screen.clo`** :
  - Marges symétriques (`twoside=false`, `BCOR=0mm`) adaptées au défilement continu sur écran et tablette.
  - Palette chromatique riche et accessible (`ThesisPrimary`, `ThesisSecondary`, `ThesisAccent`).
  - Configuration `hyperref` avec liens colorés et signets PDF interactifs ouverts.
- **`mythesis-print.clo`** :
  - Mise en page recto-verso rigoureuse (`twoside=true`, `open=right`) assurant que les chapitres démarrent sur belle page (page impaire).
  - Compensation de reliure physique `BCOR=10mm` (la marge intérieure est élargie pour compenser l'encollage ou la couture).
  - Neutralisation chromatique des hyperliens (`hidelinks=true`) pour un rendu net et contrasté sur papier sans trame de gris.

### C. La personnalisation BibLaTeX (`.bbx` / `.cbx`)
La bibliographie est confiée au moteur moderne **Biber + BibLaTeX** :
- **`custom-style.bbx`** : définit la structure des références dans la liste finale (noms d'auteurs en petites capitales, titres en italique ou entre guillemets, formatage compact des liens DOI).
- **`custom-style.cbx`** : configure les citations dans le texte (`\autocite`, `\textcite`, `\parencite`) en rendant le bloc auteur-année entièrement cliquable vers la bibliographie.

### D. Règle d'inclusion : `\input{}` vs `\include{}`
- `\include{chemin/fichier}` (sans extension `.tex`) est **exclusivement réservé aux chapitres majeurs** dans le corps principal. Il insère un saut de page propre (`\clearpage` ou `\cleardoublepage`) et permet l'usage éventuel de `\includeonly{}` pour accélérer la compilation.
- `\input{chemin/fichier.tex}` est utilisé pour les préambules, les pages de garde, les sous-sections et les schémas vectoriels (`figures/*.tikz`).

---

## 3. Guide de Compilation

Le projet est configuré pour être compilé de manière entièrement automatisée grâce au fichier `latexmkrc` fourni.

### Commande recommandée (terminal)
Depuis la racine du dossier `mon-projet/` :
```bash
latexmk
```
Cette commande unique :
1. Lance le moteur moderne **LuaLaTeX**.
2. Exécute **Biber** pour mettre à jour la base bibliographique.
3. Répète les passes nécessaires pour stabiliser les références croisées et la table des matières.
4. Isole tous les fichiers auxiliaires dans le sous-dossier `build/` pour préserver un répertoire de travail parfaitement propre.

Le fichier PDF final est produit dans : `build/main.pdf`.

### Nettoyage des fichiers temporaires
```bash
latexmk -c    # Supprime les fichiers auxiliaires courants
latexmk -C    # Supprime également le fichier PDF produit dans build/
```

---

## 4. Comment Adapter ce Canevas à Votre Projet

1. **Changer le profil de sortie :**
   Dans `main.tex`, modifiez la première ligne :
   - Pour la lecture numérique : `\documentclass[screen]{mythesis}`
   - Pour l'imprimeur / la reliure : `\documentclass[print]{mythesis}`
2. **Renseigner vos métadonnées :**
   Mettez à jour les champs institutionnels dans `main.tex` (`\institution`, `\degree`, `\supervisor`, `\keywords`, etc.).
3. **Ajouter un nouveau chapitre :**
   Créez un fichier `content/05-discussion.tex` et ajoutez simplement `\include{content/05-discussion}` dans `main.tex`.
4. **Enrichir les macros mathématiques ou graphiques :**
   Définissez vos notations dans `config/macros.sty` pour qu'elles soient disponibles dans l'ensemble de vos chapitres.

