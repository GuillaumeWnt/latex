# Template Universitaire Complet (Mémoire, Thèse, Rapport)

Ce modèle est conçu pour produire des mémoires de fin d'études, thèses et rapports techniques exigeants avec un rendu typographique professionnel, sans avoir à reconfigurer LaTeX de zéro à chaque projet.

---

## 1. Arborescence du Template

Le dossier est organisé selon le principe de **séparation stricte du contenu et du style** :

```text
templates/template_principal/
├── README.md                      # Guide d'utilisation et aide-mémoire (ce fichier)
├── main.tex                       # Fichier maître (ordonnancement des chapitres)
├── ClasseGuillaume.cls            # Classe KOMA-Script enrichie, corrigée et interactive
├── Fonts/                         # Polices OpenType/TrueType locales
│   ├── AsapFontFiles/             # Police Asap Condensed pour les titres
│   ├── CalibriFontFiles/          # Police Calibri pour le corps de texte
│   └── ComicSansMSFontFiles/      # Police Comic Sans MS
├── images/                        # Logos et figures institutionnelles
│   ├── FacMedLogo.jpg
│   ├── UCLouvainLogo.png
│   └── logo_test.png
├── chapters/                      # Corps du document découpé en modules
│   ├── 00_frontmatter/            # Couverture, liste todos, résumé bilingue
│   ├── 01_chapitre1/              # Chapitre I (théorie, tableaux, illustrations, encadrés)
│   └── 02_chapitre2/              # Chapitre II (méthodologie, annotations interactives, biblio)
├── tables/                        # Tableaux complexes au format booktabs
│   └── hypotheses_diagnostiques.tex
├── bib/                           # Base de données bibliographique Biber / Vancouver
│   └── references.bib
└── scripts/                       # Outils de compilation
    ├── compile.ps1                # Script PowerShell de compilation LuaLaTeX
    └── clean.ps1                  # Nettoyage des fichiers auxiliaires
```

---

## 2. Compilation

Le moteur requis est **LuaLaTeX** (indispensable pour `fontspec`, `lua-ul`, `luacolor` et `unicode-math`).

### En ligne de commande (PowerShell) :
```powershell
# Via le script fourni :
.\scripts\compile.ps1

# Ou directement avec latexmk :
latexmk -lualatex -outdir=build -interaction=nonstopmode -synctex=1 main.tex
```

Le fichier PDF final est généré dans `build/main.pdf`.

---

## 3. Guide Pratique des Fonctionnalités Avancées

### 1. Notes marginales intelligentes et révisions (`\todoH`)
La commande `\todoH{style}{couleur}{commentaire}{texte}` intègre un comportement dynamique unique :
- **Troncature automatique des longs messages :** Si le commentaire dépasse 30 caractères, il est abrégé dans la marge avec `...`. Une info-bulle interactive (`tooltip`) s'affiche au survol de la souris dans le PDF avec le texte intégral.
- **Préservation des commandes et URL :** Si le commentaire contient une commande LaTeX (ex. `\url{https://...}`), il n'est pas tronqué afin de préserver le lien, et `xurl` assure la coupure propre de la ligne.
- **Lien hypertexte bidirectionnel :** Le surlignage dans le corps du texte est cliquable et renvoie directement à la table des révisions (`\label{table_todos}`) en début de document.
- **Surlignage 100 % stable sous LuaLaTeX :** Basé sur `lua-ul` et `luacolor` (évite les bugs de césure et de caractères accentués du package obsolète `soul`).

```latex
% Message long tronqué avec info-bulle au survol :
\todoH{FloraStyle}{red!30}{Remarque très détaillée qui dépasse 30 caractères...}{texte surligné}

% Message avec lien web préservé :
\todoH{GuillaumeStyle}{NavyBlue!30}{\url{https://ctan.org/pkg/todonotes}}{texte surligné}

% Figure provisoire réservée :
\missingfigure[figwidth=\linewidth, figheight=4cm]{Schéma à intégrer}
```

### 2. Géométries de page multiples
Passez facilement d'une mise en page à une autre selon la nature des pages :
- `\geometrieWord` : Marges classiques de 2,5 cm partout (avec marge réservée aux notes).
- `\geometrieLarge` : Marges étroites de 1,2 cm (idéal pour la page de couverture ou les figures pleines pages).
- `\geometrieStandard` : Restauration de la géométrie KOMA-Script originale.

### 3. Encadrés et boîtes visuelles (`tcolorbox`)
- **Cadre décoratif pour images :**
  ```latex
  \begin{cadreFigure}[width=0.8\textwidth]
    \includegraphics[width=\linewidth]{mon_image.png}
  \end{cadreFigure}
  ```
- **Boîte de synthèse ou point clé :**
  ```latex
  \begin{boiteSynthese}{Titre de la boîte}
    Contenu mis en valeur avec un fond doux et un liseré coloré.
  \end{boiteSynthese}
  ```

### 4. Insertion d'annexes et PDF externes (`pdfpages`)
Insérez des documents administratifs, attestations ou comptes-rendus multipages dans les annexes en conservant les numéros de page :
```latex
\appendix
\chapter{Documents Complémentaires}
\label{annexe:justificatifs}

\includepdf[pages=-, pagecommand={\thispagestyle{plain}}]{documents/attestation.pdf}
```

### 5. Paragraphes avec puces en ligne (`\paragraph`)
La commande `\paragraph` est redéfinie pour insérer une puce discrète suivie du texte sur la même ligne (run-in), permettant de structurer des listes argumentées :
```latex
\paragraph{Premier critère} Le texte commence immédiatement après le titre...
\paragraph{Second critère} Deuxième point structuré...
```

### 6. Citer des sources et référencer les pages
- Citations BibLaTeX (style Vancouver) :
  - `\parencite{clef}` $\rightarrow$ *(1)*
  - `\textcite{clef}` $\rightarrow$ *Auteur et al. (1)*
  - `\cite{clef}` $\rightarrow$ *[1]*
- Références intelligentes avec page automatique :
  - `\cref{fig:mon_image}` $\rightarrow$ *Figure 1.1*
  - `\cpageref{fig:mon_image}` $\rightarrow$ *page 4*
  - Exemple : `reprise dans la~\cref{tab:hypotheses} à la~\cpageref{tab:hypotheses}.`

### 7. Changer de police
- **Option globale** dans le `\documentclass` de `main.tex` :
  - `\documentclass[font=calibri]{ClasseGuillaume}` (recommandé pour un rendu propre et moderne)
  - `\documentclass[font=comicsans]{ClasseGuillaume}` (Comic Sans MS)
  - `\documentclass[font=standard]{ClasseGuillaume}` (Latin Modern)
- **Commandes locales** :
  - `{\CalibriFont Texte en Calibri}`
  - `{\AsapFont Texte en Asap Condensed}`
  - `{\ComicSansMSFont Texte en Comic Sans MS}`

### 8. Tableaux professionnels (`booktabs` + `tabularx`)
**Règle d'or :** Pas de barres verticales (`|`).
```latex
\begin{table}[htbp]
  \centering
  \caption{Titre explicite du tableau}
  \label{tab:mon_tableau}
  \begin{tabularx}{\textwidth}{>{\bfseries}p{3cm} X r}
    \toprule
    Élément & Description détaillée (largeur automatique) & Valeur \\
    \midrule
    Paramètre 1 & Texte s'étalant proprement sur plusieurs lignes & \qty{12.5}{\kilo\gram} \\
    Paramètre 2 & Deuxième ligne avec retour à la ligne fluide & \qty{45.0}{\meter\per\second} \\
    \bottomrule
  \end{tabularx}
\end{table}
```

### 9. Styles de texte et typographie

| Effet | Commande courte | Bascule de paragraphe |
| :--- | :--- | :--- |
| **Gras** | `\textbf{Texte}` | `\bfseries` |
| *Italique* | `\textit{Texte}` | `\itshape` |
| ***Gras Italique*** | `\textbf{\textit{Texte}}` | `\bfseries\itshape` |
| Petites Capitales | `\textsc{Texte}` | `\scshape` |
| Sans Serif | `\textsf{Texte}` | `\sffamily` |
| Monospace (Code) | `\texttt{Texte}` | `\ttfamily` |
| Serif (Roman) | `\textrm{Texte}` | `\rmfamily` |
| Emphase | `\emph{Texte}` | `\em` |
| Souligné (avec césure) | `\underLine{Texte}` | — |
| Surligné couleur | `\highLight[yellow!40]{Texte}` | — |

---

## 4. Bonnes Pratiques de Rédaction

1. **Jamais de `\\` pour changer de paragraphe :**
   Laissez simplement une **ligne vide** dans votre éditeur.
2. **Sauts de ligne sémantiques (Semantic Line Breaks) :**
   Écrivez **une seule phrase par ligne** pour un suivi optimal sous Git.
3. **Flèches et symboles mathématiques :**
   Toujours écrire `$\rightarrow$` en mode mathématique (et non `\rightarrow` en mode texte).
4. **Espaces insécables (`~`) :**
   Toujours placer un tilde avant chaque citation ou référence : `selon~\textcite{nieva2024impact}` ou `dans la~\cref{fig:schema}`.
