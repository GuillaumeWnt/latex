%----------------------------------------------------------------------------------
%  CLASSE GUILLAUME - TEMPLATE UNIVERSITAIRE MODERNE & COMPLET (v2.2)
%  Moteur recommandé : LuaLaTeX
%----------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[2020/01/01]
\newcommand{\classname}{ClasseGuillaume}
\ProvidesClass{\classname}[2026/11/10 v2.2 Classe de rapport/memoire universitaire personnalisee]

% Base KOMA-Script
\providecommand{\baseclass}{scrbook}

% Paquets utilitaires de base
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{scrhack}     % Corrige les avertissements avec hyperref, float, listings
\RequirePackage{xstring}     % Manipulation de chaînes (troncature des notes)

% --- Options KOMA-Script par défaut (passées avant \ProcessOptions) ---
% Permet d'initialiser scrbook/typearea en une seule passe sans avertissement
% tout en laissant à l'utilisateur la liberté de les surcharger dans \documentclass[...]
\PassOptionsToClass{
  11pt,
  a4paper,
  oneside,
  BCOR=0mm,
  DIV=12
}{\baseclass}

% --- Options personnalisées de la classe ---
\newif\ifusetodos
\usetodosfalse
\DeclareOption{todoNote}{\usetodostrue}

% Choix de la police par défaut via option de classe
\newcommand{\selectedfont}{calibri}
\DeclareOption{font=calibri}{\renewcommand{\selectedfont}{calibri}}
\DeclareOption{font=heros}{\renewcommand{\selectedfont}{heros}}
\DeclareOption{font=libertinus}{\renewcommand{\selectedfont}{libertinus}}
\DeclareOption{font=comicsans}{\renewcommand{\selectedfont}{comicsans}}
\DeclareOption{font=standard}{\renewcommand{\selectedfont}{standard}}

% Passe toutes les autres options non interceptées à scrbook
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\ProcessOptions\relax
\LoadClass{\baseclass}

% Options KOMA-Script appliquées immédiatement après \LoadClass (avant fontspec)
\KOMAoptions{
  usegeometry=true,
  headheight=20pt,
  footheight=20pt,
  parskip=half,
  appendixprefix=true,        % Préfixe "Annexe A" dans les annexes
  chapterprefix=false,
  numbers=noenddot,           % Pas de point final aux numéros de sections (1.2 au lieu de 1.2.)
  captions=tableheading,      % Légendes de tableaux configurées au-dessus
  toc=listof,
  toc=index,
  toc=bibliography,
  listof=totoc,
  listof=entryprefix
}

% Ajustement dynamique de la largeur des numéros dans la TOC, LOF et LOT (évite les warnings tocbasic)
\DeclareTOCStyleEntries[dynnumwidth=true]{tocline}{part,chapter,section,subsection,subsubsection,figure,table}

% --- Métadonnées du document ---
\newcommand{\thetitle}{\@title}
\newcommand{\theauthor}{\@author}
\newcommand{\thedate}{\@date}

% lipsum : texte de remplissage, chargé uniquement en mode brouillon
\AtEndPreamble{\@ifclasswith{\baseclass}{draft}{\RequirePackage{lipsum}}{}}

%----------------------------------------------------------------------------------
%  LANGUES, MATHEMATIQUES & SCIENCES
%----------------------------------------------------------------------------------
\RequirePackage{babel}
% Configuration moderne babel-french dans le préambule (\frenchsetup est \@onlypreamble)
\@ifundefined{frenchsetup}{}{%
  \frenchsetup{
    StandardLists=true,
    TocPartNameFull=false,
    SuppressWarning=true
  }%
}
\AtBeginDocument{%
  % Harmonisation francophone : "Tableau" au lieu de l'anglicisme "Table"
  \@ifundefined{captionsfrench}{}{%
    \addto\captionsfrench{%
      \renewcommand*{\tablename}{Tableau}%
      \renewcommand*{\listtablename}{Liste des tableaux}%
    }%
  }%
  \iflanguage{french}{%
    \renewcommand*{\tablename}{Tableau}%
    \renewcommand*{\listtablename}{Liste des tableaux}%
  }{}%
}

\RequirePackage{amsmath}
\RequirePackage{mathtools}

\RequirePackage{siunitx}
\sisetup{
  locale = FR,                % Virgule décimale et espace fin entre milliers
  mode = match,               % Harmonise la police avec le texte environnant
  propagate-math-font = true,
  reset-math-version = false,
  reset-text-family = false,
  reset-text-series = false,
  reset-text-shape = false,
  per-mode = symbol,          % Affiche m/s
  range-phrase = { à },       % Plage lisible en français : 10 à 20 km
  range-units = single        % 10 à 20 km
}
% Déclaration explicite de l'unité bar (recommandation BIPM / siunitx v3)
\DeclareSIUnit\bar{bar}

%----------------------------------------------------------------------------------
%  COULEURS & SURLIGNAGE SÉCURISÉ (LUA-UL)
%----------------------------------------------------------------------------------
\RequirePackage[table,xcdraw,dvipsnames]{xcolor}
\colorlet{mdtRed}{red!50!black}
\colorlet{primaryColor}{NavyBlue}
\colorlet{secondaryColor}{TealBlue}
\colorlet{accentColor}{Bittersweet}

% luacolor doit impérativement être chargé avant lua-ul pour la couleur
\RequirePackage{luacolor}
\RequirePackage{lua-ul}        % Soulignement et surlignement gérant la césure sous LuaTeX

%----------------------------------------------------------------------------------
%  POLICES DE CARACTÈRES (LuaLaTeX)
%----------------------------------------------------------------------------------
\RequirePackage{fontspec}

% ---------------------------------------------------------------------------------
% GESTION MODERNE DES POLICES AVEC LUALATEX :
% 1. POLICES SYSTÈME (Windows) : Calibri, Comic Sans MS, Segoe UI, etc.
%    -> Accessibles directement par leur nom via \setmainfont{Calibri}.
%    -> Aucun fichier .ttf dans le projet n'est nécessaire sur une machine Windows !
% 2. POLICES TEX LIVE (universelles) : TeX Gyre Heros, Libertinus, Fira Sans, etc.
%    -> Fournies avec TeX Live, utilisables immédiatement sur n'importe quel OS.
% 3. FICHIERS LOCAUX (./Fonts/...) :
%    -> Méthode utilisée sur Overleaf (Linux) où les polices Microsoft ne sont pas
%       préinstallées, assurant une portabilité totale quel que soit l'environnement.
% ---------------------------------------------------------------------------------

% Définition de \AsapFont (utilisée pour les titres de chapitres)
% Recherche en priorité dans le système, repli sur ./Fonts/, puis sur TeX Gyre Heros
\IfFontExistsTF{Asap Condensed}{%
  \newfontfamily{\AsapFont}{Asap Condensed}
}{%
  \IfFileExists{./Fonts/AsapFontFiles/Asap-Condensed-Regular.ttf}{%
    \newfontfamily{\AsapFont}{Asap-Condensed-Regular}[
      Path = ./Fonts/AsapFontFiles/,
      Extension = .ttf,
      BoldFont = Asap-Condensed-Bold,
      ItalicFont = Asap-Condensed-Italic,
      BoldItalicFont = Asap-Condensed-BoldItalic
    ]
  }{%
    \newfontfamily{\AsapFont}{TeX Gyre Heros}[BoldFont=*, ItalicFont=*, BoldItalicFont=*]
  }
}

% Familles de démonstration ponctuelle (\CalibriFont, \ComicSansMSFont)
\IfFontExistsTF{Calibri}{%
  \newfontfamily{\CalibriFont}{Calibri}
}{%
  \IfFileExists{./Fonts/CalibriFontFiles/calibri-regular.ttf}{%
    \newfontfamily{\CalibriFont}{calibri-regular}[
      Path = ./Fonts/CalibriFontFiles/,
      Extension = .ttf,
      BoldFont = calibri-bold,
      ItalicFont = calibri-italic,
      BoldItalicFont = calibri-bold-italic
    ]
  }{%
    \newfontfamily{\CalibriFont}{TeX Gyre Heros}
  }
}

\IfFontExistsTF{Comic Sans MS}{%
  \newfontfamily{\ComicSansMSFont}{Comic Sans MS}
}{%
  \IfFileExists{./Fonts/ComicSansMSFontFiles/ComicSansMS.ttf}{%
    \newfontfamily{\ComicSansMSFont}{ComicSansMS}[
      Path = ./Fonts/ComicSansMSFontFiles/,
      Extension = .ttf,
      BoldFont = ComicSansMS-Bold,
      ItalicFont = ComicSansMS-Italic,
      BoldItalicFont = ComicSansMS-BoldItalic
    ]
  }{%
    \newfontfamily{\ComicSansMSFont}{Latin Modern Roman}
  }
}

% --- Application de la police principale et sans-serif selon l'option choisie ---
\ifdefstring{\selectedfont}{calibri}{
  % Option par défaut : tente de charger Calibri directement depuis le système Windows.
  % Si absent (ex. Overleaf / Linux), se replie sur ./Fonts/CalibriFontFiles/
  \IfFontExistsTF{Calibri}{
    \setmainfont{Calibri}
    \setsansfont{Calibri}
  }{
    \IfFileExists{./Fonts/CalibriFontFiles/calibri-regular.ttf}{
      \setmainfont{calibri-regular}[
        Path = ./Fonts/CalibriFontFiles/,
        Extension = .ttf,
        BoldFont = calibri-bold,
        ItalicFont = calibri-italic,
        BoldItalicFont = calibri-bold-italic
      ]
      \setsansfont{calibri-regular}[
        Path = ./Fonts/CalibriFontFiles/,
        Extension = .ttf,
        BoldFont = calibri-bold,
        ItalicFont = calibri-italic,
        BoldItalicFont = calibri-bold-italic
      ]
    }{
      \setmainfont{Latin Modern Roman}
      \setsansfont{Latin Modern Sans}
    }
  }
}{}

\ifdefstring{\selectedfont}{heros}{
  % TeX Gyre Heros (équivalent libre moderne d'Helvetica) : inclus nativement dans TeX Live
  % Ne nécessite aucun fichier local et fonctionne à 100% sur Windows, Mac, Linux et Overleaf.
  \setmainfont{TeX Gyre Heros}
  \setsansfont{TeX Gyre Heros}
}{}

\ifdefstring{\selectedfont}{libertinus}{
  % Libertinus Serif (police avec empattements moderne et élégante) : incluse dans TeX Live
  \setmainfont{Libertinus Serif}
  \setsansfont{Libertinus Sans}
}{}

\ifdefstring{\selectedfont}{comicsans}{
  \IfFontExistsTF{Comic Sans MS}{
    \setmainfont{Comic Sans MS}
    \setsansfont{Comic Sans MS}
  }{
    \IfFileExists{./Fonts/ComicSansMSFontFiles/ComicSansMS.ttf}{
      \setmainfont{ComicSansMS}[
        Path = ./Fonts/ComicSansMSFontFiles/,
        Extension = .ttf,
        BoldFont = ComicSansMS-Bold,
        ItalicFont = ComicSansMS-Italic,
        BoldItalicFont = ComicSansMS-BoldItalic
      ]
      \setsansfont{ComicSansMS}[
        Path = ./Fonts/ComicSansMSFontFiles/,
        Extension = .ttf,
        BoldFont = ComicSansMS-Bold,
        ItalicFont = ComicSansMS-Italic,
        BoldItalicFont = ComicSansMS-BoldItalic
      ]
    }{
      \setmainfont{Latin Modern Roman}
    }
  }
}{}

\ifdefstring{\selectedfont}{standard}{
  % Latin Modern standard fourni avec TeX Live
  \setmainfont{Latin Modern Roman}
  \setsansfont{Latin Modern Sans}
}{}

% Polices mathématiques modernes (sans avertissements de redéfinition avec mathtools)
\RequirePackage[warnings-off={mathtools-colon,mathtools-overbracket}]{unicode-math}
\setmathfont{XITS Math}[Scale=MatchLowercase]

%----------------------------------------------------------------------------------
%  COHABITATION KOMA-SCRIPT & GEOMETRY (GÉOMÉTRIES MULTIPLES ET PAGES SUR-MESURE)
%----------------------------------------------------------------------------------
% Architecture hybride propre :
% - KOMA-Script (scrbook) gère la structure sémantique, les titres et les calques.
% - geometry gouverne avec précision les dimensions physiques et les bascules de marges.
% - La macro \syncKomaGeometry synchronise automatiquement scrlayer-scrpage et parskip
%   à chaque appel de \newgeometry ou \restoregeometry.
\RequirePackage{geometry}
\geometry{
  a4paper,
  left=2.8cm,
  right=2.8cm,
  top=2.6cm,
  bottom=2.8cm,
  headheight=20pt,
  headsep=18pt,
  footskip=34pt,
  footnotesep=10pt,
  marginparwidth=2.1cm,
  marginparsep=3mm,
  bindingoffset=0cm
}

% Synchronisation automatique de KOMA-Script lors des changements de géométrie
\newcommand{\syncKomaGeometry}{%
  \csname par@updaterelative\endcsname
  \KOMAoptions{headwidth=text, footwidth=text}%
}
\apptocmd{\newgeometry}{\syncKomaGeometry}{}{}
\apptocmd{\restoregeometry}{\syncKomaGeometry}{}{}

% Suivi de la géométrie courante pour restauration intelligente après une pageDesign
\newcommand{\currentGeometryCmd}{\geometrieStandard}

% 1. Géométrie standard (mise en page académique équilibrée par défaut)
\newcommand{\geometrieStandard}{%
  \cleardoublepage%
  \renewcommand{\currentGeometryCmd}{\geometrieStandard}%
  \restoregeometry%
}

% 2. Géométrie Word (marges de 2.5 cm partout avec marge de notes sécurisée)
\newcommand{\geometrieWord}{%
  \cleardoublepage%
  \renewcommand{\currentGeometryCmd}{\geometrieWord}%
  \newgeometry{
    left=2.5cm, right=2.5cm,
    top=2.5cm, bottom=2.5cm,
    headheight=20pt, headsep=18pt,
    footskip=34pt, footnotesep=10pt,
    marginparwidth=2.0cm, marginparsep=2.5mm,
    twoside=false, bindingoffset=0cm, twocolumn=false
  }%
}

% 3. Géométrie large / couverture / grands tableaux (marges compactes de 1.4 cm)
\newcommand{\geometrieLarge}{%
  \cleardoublepage%
  \renewcommand{\currentGeometryCmd}{\geometrieLarge}%
  \newgeometry{
    left=1.4cm, right=1.4cm,
    top=1.8cm, bottom=1.8cm,
    headheight=20pt, headsep=14pt,
    footskip=28pt, footnotesep=8pt,
    marginparwidth=0mm, marginparsep=0mm,
    twoside=false, bindingoffset=0cm, twocolumn=false
  }%
}
\newcommand{\geometrieExemple}{\geometrieLarge}

% 4. Géométrie libre à la volée (avec valeurs par défaut saines pour KOMA)
\newcommand{\geometrieLibre}[1]{%
  \cleardoublepage%
  \newgeometry{
    headheight=20pt, headsep=16pt,
    footskip=30pt, footnotesep=8pt,
    marginparwidth=0mm, marginparsep=0mm,
    twoside=false, bindingoffset=0cm, twocolumn=false,
    #1
  }%
}

% Interligne 1.5 par défaut dans le corps du texte
\RequirePackage{setspace}
\onehalfspacing

\raggedbottom

%----------------------------------------------------------------------------------
%  EN-TÊTES ET PIEDS DE PAGE (scrlayer-scrpage)
%----------------------------------------------------------------------------------
\RequirePackage[
  automark,
  headsepline=0.5pt,
  footsepline=false,
  markcase=used
]{scrlayer-scrpage}

\RequirePackage{lastpage}
\RequirePackage{calc}

\clearpairofpagestyles
\setkomafont{pagehead}{\normalfont\sffamily\small\itshape\color{darkgray}}
\setkomafont{pagenumber}{\normalfont\sffamily\bfseries\small}

\ohead[\pagemark]{\pagemark}
\ihead[]{\headmark}
\cfoot[]{}

% Garantit que le retour à scrheadings rétablit toujours ses propres filets
\AddToLayerPageStyleOptions{scrheadings}{%
  onselect={%
    \KOMAoptions{headsepline=0.5pt, footsepline=false}%
  }%
}
\AddToLayerPageStyleOptions{plain.scrheadings}{%
  onselect={%
    \KOMAoptions{headsepline=0.5pt, footsepline=false}%
  }%
}

% Style personnalisé épuré (le code du 2e argument est exécuté dans onselect par scrlayer-scrpage)
\newpairofpagestyles{StyleFocus}{
  \KOMAoptions{headsepline=false, footsepline=false}
  \clearpairofpagestyles
  \chead{-- \headmark --}
  \cfoot[\pagemark]{\pagemark}
}

% Style personnalisé pour le diagnostic / debug
\newpairofpagestyles{StyleTest}{
  \KOMAoptions{headsepline=0.8pt, footsepline=0.4pt, markcase=used}
  \clearpairofpagestyles
  \def\TestFontHead{\normalfont\sffamily\small\color{MidnightBlue}}
  \def\TestFontFoot{\normalfont\ttfamily\footnotesize\color{Gray}}
  \automark[section]{chapter}
  \lehead[\textbf{\thepage}]{{\color{orange}\tiny\sffamily\bfseries [DEBUG VIEW]}\enspace\textbf{\thepage}}
  \lohead[]{\TestFontHead \leftmark}
  \chead[]{}
  \rehead[]{\TestFontHead \rightmark}
  \rohead[\textbf{\thepage}]{{\color{orange}\tiny\sffamily\bfseries [DEBUG VIEW]}\enspace\textbf{\thepage}}
  \lefoot[]{\TestFontFoot \jobname.tex}
  \lofoot[]{\TestFontFoot \jobname.tex}
  \cfoot[]{\color{gray!60}|--- CENTRE ---|}
  \refoot[]{\TestFontFoot p.\thepage/\pageref{LastPage}}
  \rofoot[]{\TestFontFoot p.\thepage/\pageref{LastPage}}
}

\pagestyle{scrheadings}

%----------------------------------------------------------------------------------
%  TITRES ET HIÉRARCHIE TYPOGRAPHIQUE
%----------------------------------------------------------------------------------
\setcounter{secnumdepth}{3}

% Forcer l'interligne simple dans tous les niveaux de titres (évite l'étirement dû à \onehalfspacing)
\addtokomafont{disposition}{\bfseries\color{primaryColor}\setstretch{1}}
\addtokomafont{part}{\setstretch{1}\selectfont}
\addtokomafont{partnumber}{\setstretch{1}\selectfont}
\addtokomafont{chapter}{\setstretch{1}\selectfont}
\addtokomafont{section}{\setstretch{1}\selectfont}
\addtokomafont{subsection}{\setstretch{1}\selectfont}
\addtokomafont{subsubsection}{\setstretch{1}\selectfont}

\renewcommand*{\raggedchapter}{\centering}

\RedeclareSectionCommand[
  font={\Huge\AsapFont\color{primaryColor}\setstretch{1}\selectfont},
  beforeskip=-10pt,
  afterskip=20pt,
  innerskip=0.5em
]{chapter}

\RedeclareSectionCommand[
  font={\Large\bfseries\color{secondaryColor}\setstretch{1}\selectfont},
  beforeskip=-12pt,
  afterskip=10pt
]{section}

\RedeclareSectionCommand[
  font={\large\bfseries\color{darkgray}\setstretch{1}\selectfont},
  beforeskip=-8pt,
  afterskip=6pt
]{subsection}

% Paragraphe en ligne précédé d'une puce discrète
\RedeclareSectionCommand[
  indent=5mm,
  afterskip=-1em,
  font={\color{primaryColor}\bfseries\textbullet~}
]{paragraph}

% Numérotation : Chapitre en Romain, Sections en Arabe
\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand{\thesection}{\thechapter.\arabic{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}

%----------------------------------------------------------------------------------
%  TABLE DES MATIÈRES & LISTES DE FLOTTANTS
%----------------------------------------------------------------------------------
\BeforeStartingTOC{\singlespacing}

%----------------------------------------------------------------------------------
%  TYPOGRAPHIE AVANCÉE (MICROTYPE & PÉNALITÉS)
%----------------------------------------------------------------------------------
\RequirePackage{microtype}

\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000
\doublehyphendemerits=10000
\brokenpenalty=10000
\interfootnotelinepenalty=9999
% Souplesse contrôlée pour éviter les Overfull \hbox sur les inline \texttt{...}
\emergencystretch=1.5em

%----------------------------------------------------------------------------------
%  FIGURES, TABLEAUX, ENCADRÉS (tcolorbox) & DOCUMENTS EXTERNES (pdfpages)
%----------------------------------------------------------------------------------
\RequirePackage{adjustbox}
\RequirePackage{rotating}
\RequirePackage{float}
\RequirePackage{pdfpages}       % Pour insérer des documents PDF externes dans les annexes
\RequirePackage{ragged2e}       % Justification améliorée (\RaggedRight) pour colonnes étroites

% Boîtes et encadrés modernes
\RequirePackage[skins,breakable]{tcolorbox}

% Environnements de boîtes prédéfinis
\newtcolorbox{cadreFigure}[1][]{
  colframe=primaryColor!80!black,
  colback=white,
  boxrule=1.5pt,
  arc=10pt,
  halign=center,
  #1
}

\newtcolorbox{boiteSynthese}[2][]{
  colframe=primaryColor,
  colback=primaryColor!6,
  fonttitle=\bfseries\sffamily,
  title={#2},
  arc=4pt,
  boxrule=1pt,
  #1
}

% Liste personnalisée d'illustrations (numérotée par chapitre comme les figures)
\DeclareNewTOC[%
  type=illustration,
  types=illustrations,
  float,
  counterwithin=chapter,
  name=Illustration,
  listname={Liste des illustrations},
  tocentrystyle=tocline,
  tocentrydynnumwidth=true
]{loi}

% Tableaux professionnels et types de colonnes à drapeau droit (évite Underfull \hbox)
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{tabularx}
\RequirePackage{multirow}

\newcolumntype{L}[1]{>{\RaggedRight\arraybackslash}p{#1}}
\newcolumntype{C}[1]{>{\Centering\arraybackslash}p{#1}}
\newcolumntype{R}[1]{>{\RaggedLeft\arraybackslash}p{#1}}
\newcolumntype{Y}{>{\RaggedRight\arraybackslash}X}

% Graphiques
\RequirePackage{graphicx}
\graphicspath{{images/}{images/diagrams/}{./}}

% Légendes
\RequirePackage{caption}
\captionsetup{
  format = hang,
  justification = centerlast,
  singlelinecheck = true,
  font = {small, sf},
  labelfont = {bf, sf},
  labelsep = period,
  margin = {1cm, 1cm},
  skip = 10pt
}
\captionsetup[table]{position = above, skip = 8pt}

\RequirePackage{subcaption}
\captionsetup[sub]{
  labelfont = {bf, sf},
  labelformat = simple,
  justification = centering
}
\renewcommand\thesubfigure{(\alph{subfigure})}

% Gestion des listes (listes compactes par défaut)
\RequirePackage{enumitem}
\setlist{noitemsep}

%----------------------------------------------------------------------------------
%  CITATIONS & BIBLIOGRAPHIE (biber + vancouver)
%----------------------------------------------------------------------------------
\RequirePackage[
  autostyle=true,
  style=french
]{csquotes}

% Protection de \theauthor avant le chargement de biblatex
\let\oldtheauthor\theauthor
\let\theauthor\relax

\RequirePackage[
  backend=biber,
  style=vancouver,
  url=true,
  urldate=long,
  doi=true,
  hyperref=true,
  backref=true
]{biblatex}

\let\theauthor\oldtheauthor

% Localisation soignée pour le style Vancouver en français
\DefineBibliographyStrings{french}{
  urlseen = {consulté le},
  urlfrom = {disponible sur},
}
\DeclareFieldFormat{urldate}{\mkbibbrackets{\bibstring{urlseen}\space#1}}
\DeclareFieldFormat{url}{\bibstring{urlfrom}\addcolon\space\url{#1}}
\renewbibmacro*{url+urldate}{%
  \usebibmacro{urldate}%
  \setunit{\adddot\space}%
  \usebibmacro{url}%
}

%----------------------------------------------------------------------------------
%  NOTES MARGINALES AVANCÉES (TRONCATURE, INFOBULLE ET LIEN RETOUR)
%----------------------------------------------------------------------------------
\ifusetodos
  \RequirePackage[colorinlistoftodos, shadow, loadshadowlibrary]{todonotes}
\else
  \RequirePackage[colorinlistoftodos, disable]{todonotes}
\fi

\setuptodonotes{size=\tiny, color=red!30}

\todostyle{GuillaumeStyle}{author=Guillaume, shadow}
\todostyle{MarieStyle}{author=Marie, shadow}
\todostyle{FloraStyle}{author=Flora, shadow}
\todostyle{TestStyle}{author=Test}
\todostyle{BlancStyle}{}

%----------------------------------------------------------------------------------
%  LOGO EN COUCHE D'ARRIÈRE-PLAN DYNAMIQUE (scrlayer) & ENVIRONNEMENT PAGEDESIGN
%----------------------------------------------------------------------------------
\newif\iflogoactive
\logoactivefalse
\newif\ifsavedlogo
\savedlogofalse

\newcommand{\logoFilePath}{images/logo_test.png}
\newcommand{\logoWidth}{1.35cm}

% Permet de personnaliser le chemin et la taille du logo dans main.tex
\NewDocumentCommand{\definirLogo}{m O{1.35cm}}{%
  \renewcommand{\logoFilePath}{#1}%
  \renewcommand{\logoWidth}{#2}%
}

% Positionné dans le coin supérieur droit extérieur (hors zone de texte et hors filet d'en-tête)
\DeclareNewLayer[
  background,
  align=tr,
  hoffset=\paperwidth-0.45cm,
  voffset=0.40cm,
  width=2.0cm,
  height=2.0cm,
  contents={%
    \iflogoactive
      \IfFileExists{\logoFilePath}{%
        \hfill\includegraphics[width=\logoWidth,height=\logoWidth,keepaspectratio]{\logoFilePath}%
      }{}%
    \fi
  }
]{logo.layer}

\AddLayersToPageStyle{scrheadings}{logo.layer}
\AddLayersToPageStyle{plain.scrheadings}{logo.layer}
\AddLayersToPageStyle{StyleFocus}{logo.layer}
\AddLayersToPageStyle{plain.StyleFocus}{logo.layer}
\AddLayersToPageStyle{StyleTest}{logo.layer}
\AddLayersToPageStyle{plain.StyleTest}{logo.layer}

% Commandes pour masquer ou réactiver le logo
\newcommand{\masquerLogo}{\logoactivefalse}
\newcommand{\afficherLogo}{\logoactivetrue}

% Environnement dédié aux pages au design libre (couverture, planche graphique, poster)
% Bascule automatiquement sur une géométrie sur-mesure sans en-tête ni logo, puis
% restaure l'exacte géométrie et l'état du logo à la sortie de l'environnement.
\NewDocumentEnvironment{pageDesign}{O{left=1.4cm, right=1.4cm, top=1.6cm, bottom=1.6cm}}{%
  \cleardoublepage%
  \let\savedGeometryCmd\currentGeometryCmd%
  \iflogoactive\savedlogotrue\else\savedlogofalse\fi%
  \masquerLogo%
  \geometrieLibre{#1}%
  \pagestyle{empty}%
  \thispagestyle{empty}%
}{%
  \cleardoublepage%
  \ifsavedlogo\afficherLogo\fi%
  \pagestyle{scrheadings}%
  \savedGeometryCmd%
}

%----------------------------------------------------------------------------------
%  HYPERLIENS (hyperref), INFOBULLES (pdfcomment), URL (xurl) & RÉFÉRENCES (cleveref)
%----------------------------------------------------------------------------------
\RequirePackage{xurl} % Césure irréprochable des URL longues dans les notes et le texte

\RequirePackage{hyperref}
\hypersetup{
  pdftitle = {\thetitle},
  pdfauthor = {\theauthor},
  pdfsubject = {Rapport Universitaire},
  pdfcreator = {LaTeX via LuaLaTeX},
  pdflang = {fr-FR},
  pdfdisplaydoctitle = true,
  pdfstartview = {FitH},
  pdfpagemode = {UseOutlines},
  bookmarksopen = true,
  bookmarksopenlevel = 1,
  hypertexnames = true,
  plainpages = false,
  colorlinks = true,
  linkcolor = primaryColor,
  citecolor = ForestGreen,
  urlcolor = mdtRed,
  unicode = true,
  breaklinks = true
}
\RequirePackage{bookmark} % Gestion avancée des signets PDF recommandée par KOMA-Script

% Chargement de soul avant pdfcomment (évite le chargement du paquet obsolète soulutf8 par soulpos)
\RequirePackage{soul}
\RequirePackage{pdfcomment} % Pour l'infobulle interactive (\pdftooltip) au survol

% Commande \todoH avancée :
% - Troncature automatique des messages > 30 caractères avec infobulle (\pdftooltip)
% - Préservation intégrale des commandes LaTeX telles que \url{...}
% - Surlignage robuste via lua-ul/luacolor (aucun bug UTF-8)
% - Lien hypertexte cliquable depuis le surlignage vers la liste des todos (label: table_todos)
\makeatletter
\newcommand{\todoH}[4]{%
  \if@todonotes@disabled
    #4%
  \else
    \IfSubStr{\detokenize{#3}}{\@backslashchar}{%
      % CAS 1 : Une commande LaTeX est présente (ex: \url) -> pas de troncature
      \todo[#1,color=#2]{#3}%
    }{%
      % CAS 2 : Texte simple -> troncature à 30 caractères + infobulle complète
      \StrLeft{#3}{30}[\apercu]%
      \todo[#1,color=#2]{\pdftooltip{\apercu...}{#3}}%
    }%
    \hyperref[table_todos]{\highLight[#2]{#4}}%
  \fi
}
\makeatother

% Commande clé en main pour afficher le tableau de bord des révisions (uniquement si todoNote est actif)
\NewDocumentCommand{\tableDesTodos}{O{Tableau de Bord des Révisions et Tâches de Rédaction}}{%
  \ifusetodos
    \begin{singlespace}
      \phantomsection
      \label{table_todos}
      \listoftodos[#1]
    \end{singlespace}
  \fi
}

% Synchronisation sécurisée des métadonnées au début du document
\makeatletter
\AtBeginDocument{
  \hypersetup{
    pdftitle = {\thetitle},
    pdfauthor = {\theauthor}
  }
}
\makeatother

\pdfstringdefDisableCommands{\let\\\space}

% cleveref chargé IMPÉRATIVEMENT après hyperref
\RequirePackage[french,capitalize,noabbrev]{cleveref}
\crefname{illustration}{Illustration}{Illustrations}
\Crefname{illustration}{Illustration}{Illustrations}
% Bascule automatique du compteur chapter vers appendix dans cleveref lors de \appendix
\AddToHook{cmd/appendix/after}{\crefalias{chapter}{appendix}}

\endinput
