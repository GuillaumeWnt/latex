# Manuel et Tutoriel d'Architecture LaTeX Modulaire (`scrbook`)

Ce projet constitue à la fois un **canevas de référence de niveau publication** et un **tutoriel auto-documenté complet** pour maîtriser la conception de documents scientifiques et académiques volumineux (thèses de doctorat, mémoires d'ingénierie, monographies, rapports techniques).

Bâti sur une base vierge de la classe **KOMA-Script** (`scrbook`), il applique rigoureusement le principe de **séparation des préoccupations** (*Separation of Concerns*) : le style, les profils de diffusion (écran vs impression papier reliée), les macros métier, les données brutes, le code externe, la bibliographie programmable et les chapitres rédactionnels sont totalement découplés.

---

## 1. Arborescence Complète du Projet

```text
mon-projet/
├── main.tex                 # Point d'entrée unique (le chef d'orchestre du document)
├── latexmkrc                # Automatisation de compilation (LuaLaTeX + Biber + outdir=build)
├── .editorconfig            # Standardisation de l'indentation (2 espaces) et UTF-8
├── .chktexrc                # Linter typographique (contrôle des espaces insécables ~)
├── .gitignore               # Exclusion des fichiers temporaires de compilation
├── README.md                # Documentation architecturale et guide d'utilisation
│
├── mythesis.cls             # CLASSE : architecture globale, métadonnées, KOMA-Script
├── mythesis-print.clo       # OPTION DE CLASSE : profil impression papier & reliure (BCOR, monochrome)
├── mythesis-screen.clo      # OPTION DE CLASSE : profil écran & liseuse (marges symétriques, hyperliens)
│
├── config/
│   ├── packages.sty         # STYLE : appel et configuration fine des paquets tiers
│   └── macros.sty           # STYLE : commandes mathématiques, raccourcis et styles listings/tcolorbox
│
├── fonts/                   # POLICES : polices OpenType/TrueType locales (fontspec Path=fonts/)
│   ├── README.md            # Guide de sanctuarisation des polices pour CI/CD et Overleaf
│   ├── texgyreheros-regular.otf
│   ├── texgyreheros-bold.otf
│   ├── texgyreheros-italic.otf
│   └── texgyreheros-bolditalic.otf
│
├── data/                    # DONNÉES : jeux de données bruts (.csv, .tsv) tracés par pgfplots
│   └── benchmark-results.csv
│
├── listings/                # CODE EXTERNE : fichiers sources testables (.py, .c, .rs)
│   └── algorithm-pipeline.py
│
├── biblio/
│   ├── references.bib       # BASE DE DONNÉES : notices bibliographiques BibLaTeX
│   ├── custom-style.bbx     # BIBLATEX : mise en page de la bibliographie finale
│   └── custom-style.cbx     # BIBLATEX : mise en page et liens des citations dans le corps
│
├── frontmatter/             # Pages liminaires (numérotation romaine)
│   ├── titlepage.tex        # Page de titre institutionnelle moderne avec jury
│   ├── acknowledgements.tex # Remerciements et avant-propos (\addchap)
│   └── abstract.tex         # Résumés bilingues français / anglais et mots-clés
│
├── content/                 # Tutoriel thématique découpé en chapitres autonomes
│   ├── 01-introduction.tex  # Chapitre 1 : Philosophie et cartographie de l'arborescence
│   ├── 02-etat-de-l-art.tex # Chapitre 2 : La classe racine et les profils d'options (.cls & .clo)
│   ├── 03-methodologie.tex  # Chapitre 3 : Styles, macros métier et intégration graphique
│   ├── 04-dynamique-page.tex # Chapitre 4 : Maîtrise dynamique de l'empagement : KOMA-Script, géométries et multi-colonnes
│   ├── 05-resultats.tex     # Chapitre 5 : Bibliographie programmable et compilation automatisée
│   └── 06-conclusion.tex    # Chapitre 6 : Conclusion générale et perspectives (isolée)
│
├── backmatter/              # Documents de clôture
│   ├── appendix-a.tex       # Annexe A : Aide-mémoire & Cheat Sheet des commandes
│   ├── appendix-b.tex       # Annexe B : Spécimen d'insertion réglementaire de document PDF externe
│   └── glossary.tex         # Table des sigles / acronymes et glossaire typographique
│
└── figures/                 # Médias graphiques et dessins vectoriels
    ├── logo.pdf             # Logo institutionnel vectoriel (utilisé en page de titre)
    ├── python-benchmark.pdf # Courbe 2D haute résolution générée par Matplotlib
    ├── python-3d-surface.pdf # Surface 3D complexe non-convexe pré-calculée en PDF
    ├── sample-annex-doc.pdf # Document multipage externe pour l'Annexe B
    └── tikz/
        ├── schema-principe.tex # Schéma d'architecture TikZ vectoriel autonome (standalone)
        └── schema-principe.pdf # Précompilation PDF haute performance
```

---

## 2. Nouveautés et Bonnes Pratiques Intégrées

1. **Isolation des données brutes (`data/`) :**
   Les données expérimentales (`.csv`) sont isolées des médias graphiques (`figures/`). Le paquet `pgfplots` trace les courbes directement depuis `data/benchmark-results.csv`, assurant une reproductibilité scientifique totale.
2. **Sanctuarisation du code externe (`listings/`) :**
   Les codes sources (`listings/algorithm-pipeline.py`) conservent leur extension native et peuvent être testés ou exécutés indépendamment. L'insertion via `\lstinputlisting` élimine tout copier-coller dans le document LaTeX.
3. **Figeage des polices locales (`fonts/`) :**
   Les polices TrueType/OpenType sont stockées dans `fonts/`. Grâce à la directive `Path = fonts/` de `fontspec`, le document produit un rendu visuel 100 % identique quel que soit le poste (Windows, macOS, Linux), sur Overleaf ou dans un conteneur CI/CD.
4. **Conclusion générale dédiée (`content/06-conclusion.tex`) :**
   La conclusion générale n'est plus noyée dans les résultats. Elle encadre symétriquement le manuscrit aux côtés de l'introduction générale (avec support natif de `\chapter` numéroté ou `\addchap` non numéroté).
5. **Standardisation et Linter qualité (`.editorconfig` & `.chktexrc`) :**
   - `.editorconfig` impose l'indentation à 2 espaces et l'encodage UTF-8/LF.
   - `.chktexrc` contrôle les espaces insécables obligatoires (`~`) avant `\ref`, `\cref` et `\cite`.

---

## 3. Compilation en Une Touche (`latexmk`)

Le projet est configuré pour être compilé de manière entièrement automatisée grâce au fichier `latexmkrc` fourni.

### Compiler le document
Depuis la racine du dossier `mon-projet/` :
```bash
latexmk
```
Cette commande unique :
1. Lance le moteur moderne **LuaLaTeX**.
2. Exécute **Biber** pour mettre à jour la base bibliographique.
3. Répète automatiquement les passes nécessaires pour stabiliser les références croisées et la table des matières.
4. Isole tous les fichiers auxiliaires dans le sous-dossier `build/` pour préserver une racine parfaitement propre.

Le fichier PDF final est produit dans : `build/main.pdf`.

### Nettoyage des fichiers temporaires
```bash
latexmk -c    # Supprime les fichiers auxiliaires courants (.aux, .log, .toc, etc.)
latexmk -C    # Supprime également le fichier PDF produit dans build/
```

---

## 4. Basculer entre Écran et Impression Papier

Dans `main.tex`, modifiez simplement la première ligne :
- **Pour la lecture numérique interactive :**
  ```latex
  \documentclass[screen]{mythesis}  % Marges symétriques, palette contrastée, hyperliens colorés
  ```
- **Pour l'impression papier reliée :**
  ```latex
  \documentclass[print]{mythesis}   % Recto-verso, décalage BCOR=10mm, liens monochromes
  ```
