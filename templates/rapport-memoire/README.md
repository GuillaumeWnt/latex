# Template Universitaire Complet (Mémoire, Thèse, Rapport)

Ce modèle est conçu pour produire des mémoires de fin d'études, thèses et rapports techniques exigeants avec un rendu typographique professionnel, sans avoir à reconfigurer LaTeX de zéro à chaque projet.

---

## 1. Arborescence du Template

Le dossier est organisé selon le principe de **séparation stricte du contenu et du style** :

```text
templates/rapport-memoire/
├── README.md                      # Guide d'utilisation et aide-mémoire (ce fichier)
├── main.tex                       # Fichier maître (ordonnancement des chapitres)
├── ClasseGuillaume.cls            # Classe KOMA-Script enrichie et corrigée
├── Fonts/                         # Polices OpenType/TrueType (Calibri, Asap, Comic Sans)
├── images/                        # Logos et figures institutionnelles
├── chapters/                      # Corps du document découpé en modules
│   ├── 00_frontmatter/            # Couverture, résumé bilingue
│   ├── 01_chapitre1/              # Chapitre I (théorie, tableaux, illustrations)
│   └── 02_chapitre2/              # Chapitre II (méthodologie, notes, citations)
├── tables/                        # Tableaux complexes au format booktabs
│   └── hypotheses_diagnostiques.tex
├── bib/                           # Base de données bibliographique
│   └── references.bib
└── scripts/                       # Outils de compilation
    ├── compile.ps1                # Script PowerShell de compilation LuaLaTeX
    └── clean.ps1                  # Nettoyage des fichiers auxiliaires
```

---

## 2. Compilation

Le moteur requis est **LuaLaTeX** (indispensable pour `fontspec`, `lua-ul` et `unicode-math`).

### En ligne de commande (PowerShell) :
```powershell
# Via le script fourni :
.\scripts\compile.ps1

# Ou directement avec latexmk :
latexmk -lualatex -outdir=build -interaction=nonstopmode -synctex=1 main.tex
```

Le fichier PDF final est généré dans `build/main.pdf`.

---

## 3. Guide Pratique & Antisèche (Cheat Sheet)

Voici les réponses directes aux cas d'usage courants :

### 1. Citer des sources bibliographiques
- Citation parenthétique standard : `\parencite{clef}` $\rightarrow$ *(1)* ou *(Nom, Année)*
- Citation intégrée au texte : `\textcite{clef}` $\rightarrow$ *Nom et al. (1)*
- Citation simple : `\cite{clef}` $\rightarrow$ *[1]*
- Toujours placer un espace insécable avant la citation : `d'après l'étude~\parencite{nieva2024impact}`.

### 2. Changer de langue en cours de document
```latex
\selectlanguage{english}
This section is written in English.
\selectlanguage{french}
Cette section est en français.
```

### 3. Changer de police
- **Globalement** (dans le `\documentclass` de `main.tex`) :
  ```latex
  \documentclass[font=calibri]{ClasseGuillaume}    % Moderne et propre (recommandé)
  \documentclass[font=comicsans]{ClasseGuillaume}  % Comic Sans MS
  \documentclass[font=standard]{ClasseGuillaume}   % Latin Modern classique
  ```
- **Localement** dans le texte :
  - `{\CalibriFont Mon texte en Calibri}`
  - `{\AsapFont Mon texte en Asap Condensed}`
  - `{\ComicSansMSFont Mon texte en Comic Sans}`

### 4. Ajuster l'interligne
- `\singlespacing` : Interligne simple (pour tableaux, pages de garde, citations longues).
- `\onehalfspacing` : Interligne 1,5 (valeur par défaut, aérée et lisible).
- `\doublespacing` : Double interligne.
- En bloc isolé :
  ```latex
  \begin{singlespace}
    Texte compact...
  \end{singlespace}
  ```

### 5. Gérer les notes de révision et todos
- Activer l'option `todoNote` dans `\documentclass[...]`.
- Note simple en marge : `\todo{Vérifier ce calcul}`.
- Surlignage lié à une note marginale :
  `\todoH{GuillaumeStyle}{Apricot!40}{Explication de la note}{Texte surligné dans le corps}`.
- Réserver une figure en attente :
  `\missingfigure[figwidth=8cm, figheight=4cm]{Description du schéma à insérer}`.
- Afficher la table des todos : `\listoftodos`.

### 6. Créer un tableau professionnel (`booktabs` + `tabularx`)
**Règle d'or :** Ne **jamais** utiliser de barres verticales (`|`).
```latex
\begin{table}[htbp]
  \centering
  \caption{Titre explicite du tableau}
  \label{tab:mon_tableau}
  \begin{tabularx}{\textwidth}{l X r}
    \toprule
    Élément & Description détaillée (largeur automatique) & Valeur \\
    \midrule
    Paramètre 1 & Texte s'étalant proprement sur plusieurs lignes & 12.5 \\
    Paramètre 2 & Deuxième ligne avec gestion fluide de la largeur & 45.0 \\
    \bottomrule
  \end{tabularx}
\end{table}
```

### 7. Utiliser une minipage (colonnes côte à côte)
```latex
\begin{minipage}[t]{0.48\textwidth}
  Contenu colonne gauche...
\end{minipage}
\hfill
\begin{minipage}[t]{0.48\textwidth}
  Contenu colonne droite...
\end{minipage}
```

### 8. Insérer des images et illustrations
- **Figure standard :**
  ```latex
  \begin{figure}[htbp]
    \centering
    \includegraphics[width=0.8\textwidth]{assets/images/logo_test.png}
    \caption{Légende de la figure}
    \label{fig:mon_image}
  \end{figure}
  ```
- **Illustration dédiée** (avec sa propre liste d'illustrations) :
  ```latex
  \begin{illustration}[htbp]
    \centering
    \includegraphics[width=0.7\textwidth]{mon_dessin.png}
    \caption{Légende de l'illustration}
    \label{ill:mon_dessin}
  \end{illustration}
  ```

### 9. Listes à puces et listes numérotées
```latex
% Puces standard :
\begin{itemize}
  \item Premier point
  \item Deuxième point
\end{itemize}

% Numérotée :
\begin{enumerate}
  \item Étape une
  \item Étape deux
\end{enumerate}

% Compacte (dans un tableau) :
\begin{itemize}[nosep, leftmargin=*]
  \item Point sans espacement superflu
\end{itemize}
```

### 10. Styles de texte et typographie

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
   - Laissez simplement une **ligne vide** dans votre éditeur.
   - L'utilisation de `\\` engendre des avertissements `Underfull \hbox` et casse la gestion de l'espace inter-paragraphe.
2. **Sauts de ligne sémantiques (Semantic Line Breaks) :**
   - Écrivez **une seule phrase par ligne**.
   - Cela optimise le suivi des modifications sous Git et simplifie les diffs.
3. **Flèches et symboles mathématiques :**
   - Toujours écrire `$\rightarrow$` en mode mathématique (et non `\rightarrow` en mode texte).
4. **Références croisées automatiques (`cleveref`) :**
   - Utilisez `\cref{sec:fondements}` au lieu d'écrire à la main `Section~\ref{sec:fondements}`.
   - Le préfixe "Section", "Figure", ou "Tableau" est injecté automatiquement selon la langue.
