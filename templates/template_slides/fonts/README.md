# Gestion des Polices Locales (`fonts/`)

Ce dossier héberge les polices typographiques OpenType (`.otf`) locales utilisées par le document sous les moteurs modernes **Lua\LaTeX{}** ou **Xe\LaTeX{}**.

---

## 1. Pourquoi Figer les Polices Localement ?

Dans un environnement de recherche ou de rédaction collaborative :
- Les machines des différents co-auteurs (Windows, macOS, distributions Linux) n'ont pas forcément les mêmes polices installées au niveau de l'OS.
- Les conteneurs d'intégration continue (GitHub Actions, GitLab CI) et les plateformes en ligne (Overleaf) disposent de bibliothèques système restreintes.

En stockant directement les fichiers de police dans le dossier `fonts/` de votre projet et en utilisant la directive `Path = fonts/` du paquet `fontspec`, **votre document devient 100 % autonome et indépendant du système d'exploitation**. Le rendu visuel, les césures et la pagination sont strictement identiques partout.

---

## 2. Polices Présentes dans ce Projet

Ce projet inclut la famille de polices OpenType open-source **TeX Gyre Heros** (alternative professionnelle de haute fidélité à Helvetica) :
- `texgyreheros-regular.otf` : corps droit normal
- `texgyreheros-bold.otf` : graisse forte pour les titres
- `texgyreheros-italic.otf` : italique
- `texgyreheros-bolditalic.otf` : gras italique

---

## 3. Déclaration dans `config/packages.sty`

Sous Lua\LaTeX{}, la classe déclare automatiquement ces polices pour la famille sans-serif (`\sffamily`), gouvernant les titres de chapitres, sections et en-têtes KOMA-Script :

```latex
\ifluatex
  \RequirePackage{fontspec}
  \defaultfontfeatures{Ligatures=TeX}
  
  \IfFileExists{fonts/texgyreheros-regular.otf}{%
    \setsansfont{texgyreheros}[
      Path = fonts/,
      Extension = .otf,
      UprightFont = *-regular,
      BoldFont = *-bold,
      ItalicFont = *-italic,
      BoldItalicFont = *-bolditalic
    ]%
  }{%
    % Fallback automatique si les fichiers sont absents
  }%
\fi
```

