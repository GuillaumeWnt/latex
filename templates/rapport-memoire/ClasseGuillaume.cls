%----------------------------------------------------------------------------------
%  CLASSE GUILLAUME - TEMPLATE UNIVERSITAIRE MODERNE & COMPLET
%  Moteur recommandé : LuaLaTeX
%----------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[2020/01/01]
\newcommand{\classname}{ClasseGuillaume}
\ProvidesClass{\classname}[2026/10/11 v2.0 Classe de rapport/memoire universitaire personnalisee]

% Base KOMA-Script
\providecommand{\baseclass}{scrbook}

% Paquets utilitaires de base
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{scrhack}     % Corrige les avertissements avec hyperref, float, listings

% --- Options de classe ---
\newif\ifusetodos
\usetodosfalse
\DeclareOption{todoNote}{\usetodostrue}

% Choix de la police par défaut via option de classe
\newcommand{\selectedfont}{calibri}
\DeclareOption{font=calibri}{\renewcommand{\selectedfont}{calibri}}
\DeclareOption{font=comicsans}{\renewcommand{\selectedfont}{comicsans}}
\DeclareOption{font=standard}{\renewcommand{\selectedfont}{standard}}

% Passe toutes les autres options non interceptées à scrbook
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\ProcessOptions\relax
\LoadClass{\baseclass}

% --- Métadonnées du document ---
\newcommand{\thetitle}{\@title}
\newcommand{\theauthor}{\@author}
\newcommand{\thedate}{\@date}

\RequirePackage{comment}
\RequirePackage{lipsum}

%----------------------------------------------------------------------------------
%  LANGUES, MATHEMATIQUES & SCIENCES
%----------------------------------------------------------------------------------
\RequirePackage{babel}
% Syntaxe moderne pour babel-french (remplace \frenchbsetup obsolète)
\frenchsetup{StandardLists=true}

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

%----------------------------------------------------------------------------------
%  COULEURS & SURLIGNAGE
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

% Définitions des familles de polices locales fournies dans Fonts/
\newfontfamily{\AsapFont}{Asap-Condensed-Regular}[
  Path = ./Fonts/AsapFontFiles/,
  Extension = .ttf,
  BoldFont = Asap-Condensed-Bold,
  ItalicFont = Asap-Condensed-Italic,
  BoldItalicFont = Asap-Condensed-BoldItalic
]

\newfontfamily{\CalibriFont}{calibri-regular}[
  Path = ./Fonts/CalibriFontFiles/,
  Extension = .ttf,
  BoldFont = calibri-bold,
  ItalicFont = calibri-italic,
  BoldItalicFont = calibri-bold-italic
]

\newfontfamily{\ComicSansMSFont}{ComicSansMS}[
  Path = ./Fonts/ComicSansMSFontFiles/,
  Extension = .ttf,
  BoldFont = ComicSansMS-Bold,
  ItalicFont = ComicSansMS-Italic,
  BoldItalicFont = ComicSansMS-BoldItalic
]

% Application de la police principale et sans-serif
\ifdefstring{\selectedfont}{calibri}{
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
}{}

\ifdefstring{\selectedfont}{comicsans}{
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
}{}

% Polices mathématiques modernes
\RequirePackage{unicode-math}
\setmathfont{XITS Math}[Scale=MatchLowercase]

%----------------------------------------------------------------------------------
%  MISE EN PAGE, GEOMETRIE ET ESPACEMENT
%----------------------------------------------------------------------------------
% Configuration KOMA avec dimensions d'en-tête et de pied adaptées
\KOMAoptions{
  usegeometry=true,
  fontsize=11pt,
  paper=a4,
  twoside=false,
  twocolumn=false,
  BCOR=1cm,
  DIV=12,
  headheight=26pt,
  footheight=26pt
}

\RequirePackage{geometry}
\geometry{
  headheight=26pt,
  footskip=30pt
}
\recalctypearea

% Commandes de bascule de géométrie
\newcommand{\geometrieStandard}{%
  \cleardoublepage%
  \restoregeometry%
}

\newcommand{\geometrieExemple}{%
  \cleardoublepage%
  \newgeometry{
    left=1.5cm, right=1.5cm,
    top=1.8cm, bottom=1.8cm,
    headheight=26pt, headsep=10pt,
    footskip=26pt, footnotesep=10pt,
    marginparwidth=0mm, marginparsep=0mm,
    twoside=false, bindingoffset=0cm, twocolumn=false
  }%
}

% Espace inter-paragraphe et interligne
\KOMAoptions{parskip=half}
\RequirePackage{setspace}
\onehalfspacing % Interligne 1.5 par défaut (bien plus équilibré et professionnel que doublespacing)

\raggedbottom

%----------------------------------------------------------------------------------
%  EN-TETES ET PIEDS DE PAGE (scrlayer-scrpage)
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

% Style personnalisé épuré
\newpairofpagestyles{StyleFocus}{
  \clearpairofpagestyles
  \KOMAoptions{headsepline=false}
  \chead{-- \headmark --}
  \cfoot[\pagemark]{\pagemark}
}

% Style personnalisé pour le diagnostic / debug
\newpairofpagestyles{StyleTest}{
  \clearpairofpagestyles
  \KOMAoptions{
    headsepline=0.8pt,
    footsepline=0.4pt,
    markcase=used
  }
  \def\TestFontHead{\normalfont\sffamily\small\color{MidnightBlue}}
  \def\TestFontFoot{\normalfont\ttfamily\footnotesize\color{Gray}}
  \automark[section]{chapter}
  \lehead[\textbf{\thepage}]{\textbf{\thepage}}
  \lohead[]{\TestFontHead \leftmark}
  \chead[]{\color{orange}\tiny\sffamily [DEBUG VIEW]}
  \rehead[]{\TestFontHead \rightmark}
  \rohead[\textbf{\thepage}]{\textbf{\thepage}}
  \lefoot[]{\TestFontFoot \jobname.tex}
  \lofoot[]{\TestFontFoot \jobname.tex}
  \cfoot[]{\color{gray!60}|--- CENTRE ---|}
  \refoot[]{\TestFontFoot p.\thepage/\pageref{LastPage}}
  \rofoot[]{\TestFontFoot p.\thepage/\pageref{LastPage}}
}

\pagestyle{scrheadings}

%----------------------------------------------------------------------------------
%  TITRES ET HIERARCHIE
%----------------------------------------------------------------------------------
\setcounter{secnumdepth}{3}

\addtokomafont{disposition}{\bfseries\color{primaryColor}}

\KOMAoptions{chapterprefix=false}
\renewcommand*{\raggedchapter}{\centering}

\RedeclareSectionCommand[
  font={\Huge\AsapFont\color{primaryColor}},
  beforeskip=-10pt,
  afterskip=20pt,
  innerskip=0.5em
]{chapter}

\RedeclareSectionCommand[
  font={\Large\bfseries\color{secondaryColor}},
  beforeskip=-12pt,
  afterskip=10pt
]{section}

\RedeclareSectionCommand[
  font={\large\bfseries\color{darkgray}},
  beforeskip=-8pt,
  afterskip=6pt
]{subsection}

% Numérotation : Chapitre en Romain, Sections en Arabe
\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}

%----------------------------------------------------------------------------------
%  TABLE DES MATIÈRES & LISTES DE FLOTTANTS
%----------------------------------------------------------------------------------
\KOMAoptions{
  toc=listof,
  toc=index,
  toc=bibliography,
  listof=totoc,
  listof=entryprefix
}

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

%----------------------------------------------------------------------------------
%  FIGURES, TABLEAUX, FLOTTANTS & LISTES
%----------------------------------------------------------------------------------
\RequirePackage{adjustbox}
\RequirePackage{rotating}
\RequirePackage{float}
\RequirePackage{tocbasic}

% Liste personnalisée d'illustrations
\DeclareNewTOC[%
  type=illustration,
  float,
  name=Illustration,
  listname={Liste des illustrations},
]{loi}

% Tableaux professionnels
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{tabularx}
\RequirePackage{multirow}

% Graphiques
\RequirePackage{graphicx}
\graphicspath{{images/}{./}}

% Légendes
\KOMAoptions{captions=tableheading}
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
\captionsetup[table]{position = above}

\RequirePackage{subcaption}
\captionsetup[sub]{
  labelfont = {bf, sf},
  labelformat = simple,
  justification = centering
}
\renewcommand\thesubfigure{(\alph{subfigure})}

\RequirePackage{enumitem}

%----------------------------------------------------------------------------------
%  CITATIONS & BIBLIOGRAPHIE
%----------------------------------------------------------------------------------
\RequirePackage[
  autostyle=true,
  style=french
]{csquotes}

\RequirePackage[
  backend=biber,
  style=vancouver,
  url=true,
  urldate=long,
  doi=true,
  hyperref=true,
  backref=true
]{biblatex}

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
%  NOTES TODO & HIGHLIGHTING SÉCURISÉ (LUA-UL)
%----------------------------------------------------------------------------------
\setlength{\marginparwidth}{2.2cm}

\ifusetodos
  \RequirePackage[colorinlistoftodos, shadow]{todonotes}
\else
  \RequirePackage[colorinlistoftodos, disable]{todonotes}
\fi

\setuptodonotes{color=red!30}

% Commande de surlignage robuste sans soul (utilise lua-ul et luacolor)
\makeatletter
\newcommand{\todoH}[4]{%
  \if@todonotes@disabled
    #4%
  \else
    \todo[#1,color=#2]{#3}%
    \highLight[#2]{#4}%
  \fi
}
\makeatother

\usetikzlibrary{shadows}

\todostyle{GuillaumeStyle}{shadow}
\todostyle{MarieStyle}{shadow, author=Marie}

%----------------------------------------------------------------------------------
%  LOGO EN COUCHE D'ARRIÈRE-PLAN DYNAMIQUE (scrlayer)
%----------------------------------------------------------------------------------
\DeclareNewLayer[
  background,
  topmargin,
  align=tr,
  hoffset=\paperwidth-1.8cm, % Dynamique par rapport au bord droit de la page
  voffset=1.2cm,
  width=3cm,
  height=3cm,
  contents={%
    \IfFileExists{images/logo_test.png}{%
      \includegraphics[width=2.2cm]{images/logo_test.png}%
    }{}%
  }
]{logo.layer}

\AddLayersToPageStyle{scrheadings}{logo.layer}
\AddLayersToPageStyle{plain.scrheadings}{logo.layer}

% Commande pour activer ou désactiver facilement le logo
\newcommand{\masquerLogo}{\ModifyLayer[contents={}]{logo.layer}}
\newcommand{\afficherLogo}{%
  \ModifyLayer[contents={%
    \IfFileExists{images/logo_test.png}{%
      \includegraphics[width=2.2cm]{images/logo_test.png}%
    }{}%
  }]{logo.layer}%
}

%----------------------------------------------------------------------------------
%  HYPERLIENS (hyperref) ET RÉFÉRENCES INTELLIGENTES (cleveref)
%----------------------------------------------------------------------------------
\RequirePackage{hyperref}
\hypersetup{
  pdftitle = {\thetitle},
  pdfauthor = {\theauthor},
  pdfsubject = {Rapport Universitaire},
  pdfstartview = {FitV},
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
\pdfstringdefDisableCommands{\let\\\space}

% cleveref chargé IMPÉRATIVEMENT après hyperref
\RequirePackage[french,capitalize,noabbrev]{cleveref}
\crefname{illustration}{illustration}{illustrations}
\Crefname{illustration}{Illustration}{Illustrations}

\endinput

