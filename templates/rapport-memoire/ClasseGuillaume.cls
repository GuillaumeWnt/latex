%----------------------------------------------------------------------------------
%  CLASSE GUILLAUME - TEMPLATE UNIVERSITAIRE MODERNE & COMPLET (v2.1)
%  Moteur recommandé : LuaLaTeX
%----------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[2020/01/01]
\newcommand{\classname}{ClasseGuillaume}
\ProvidesClass{\classname}[2026/10/11 v2.1 Classe de rapport/memoire universitaire personnalisee]

% Base KOMA-Script
\providecommand{\baseclass}{scrbook}

% Paquets utilitaires de base
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{scrhack}     % Corrige les avertissements avec hyperref, float, listings
\RequirePackage{xstring}     % Manipulation de chaînes (troncature des notes)

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
%  MISE EN PAGE, GÉOMÉTRIES MULTIPLES ET ESPACEMENT
%----------------------------------------------------------------------------------
% Configuration KOMA de base
\KOMAoptions{
  usegeometry=true,
  fontsize=11pt,
  paper=a4,
  twoside=false,
  twocolumn=false,
  BCOR=0cm,
  DIV=12,
  headheight=26pt,
  footheight=26pt,
  appendixprefix=true,        % Préfixe "Annexe A :" dans les annexes
  numbers=noenddot            % Pas de point final aux numéros de sections (1.2 au lieu de 1.2.)
}

\RequirePackage{geometry}
\geometry{
  headheight=26pt,
  footskip=30pt
}
\recalctypearea

% 1. Géométrie standard (restauration des réglages KOMA)
\newcommand{\geometrieStandard}{%
  \cleardoublepage%
  \restoregeometry%
}

% 2. Géométrie Word (marges de 2.5 cm partout avec marge de notes)
\newcommand{\geometrieWord}{%
  \cleardoublepage%
  \newgeometry{
    left=2.5cm, right=2.5cm,
    top=2.5cm, bottom=2.5cm,
    headheight=26pt, headsep=10pt,
    footskip=26pt, footnotesep=10pt,
    marginparwidth=2.2cm, marginparsep=3mm,
    twoside=false, bindingoffset=0cm, twocolumn=false
  }%
}

% 3. Géométrie large / couverture / grands tableaux (marges compactes de 1.2 cm)
\newcommand{\geometrieLarge}{%
  \cleardoublepage%
  \newgeometry{
    left=1.2cm, right=1.2cm,
    top=1.6cm, bottom=1.6cm,
    headheight=26pt, headsep=8pt,
    footskip=26pt, footnotesep=8pt,
    marginparwidth=0mm, marginparsep=0mm,
    twoside=false, bindingoffset=0cm, twocolumn=false
  }%
}
\newcommand{\geometrieExemple}{\geometrieLarge}

% Espace inter-paragraphe et interligne
\KOMAoptions{parskip=half}
\RequirePackage{setspace}
\onehalfspacing % Interligne 1.5 par défaut

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
%  TITRES ET HIÉRARCHIE TYPOGRAPHIQUE
%----------------------------------------------------------------------------------
\setcounter{secnumdepth}{3}

\addtokomafont{disposition}{\bfseries\color{primaryColor}}

% Forcer l'interligne simple dans les titres (évite l'étirement dû à \onehalfspacing)
\addtokomafont{section}{\setstretch{1}\selectfont}
\addtokomafont{subsection}{\setstretch{1}\selectfont}
\addtokomafont{subsubsection}{\setstretch{1}\selectfont}

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

% Paragraphe en ligne précédé d'une puce discrète
\RedeclareSectionCommand[
  indent=5mm,
  afterskip=-1em,
  font={\color{primaryColor}\bfseries\textbullet~}
]{paragraph}

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
%  FIGURES, TABLEAUX, ENCADRÉS (tcolorbox) & DOCUMENTS EXTERNES (pdfpages)
%----------------------------------------------------------------------------------
\RequirePackage{adjustbox}
\RequirePackage{rotating}
\RequirePackage{float}
\RequirePackage{tocbasic}
\RequirePackage{pdfpages}       % Pour insérer des documents PDF externes dans les annexes

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
\RequirePackage{pdfcomment} % Pour l'infobulle interactive au survol
\setlength{\marginparwidth}{2.2cm}

\ifusetodos
  \RequirePackage[colorinlistoftodos, shadow]{todonotes}
\else
  \RequirePackage[colorinlistoftodos, disable]{todonotes}
\fi

\setuptodonotes{size=\tiny, color=red!30}
\usetikzlibrary{shadows}

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

\todostyle{GuillaumeStyle}{author=Guillaume, shadow}
\todostyle{MarieStyle}{author=Marie, shadow}
\todostyle{FloraStyle}{author=Flora, shadow}
\todostyle{TestStyle}{author=Test}
\todostyle{BlancStyle}{}

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

% Commandes pour masquer ou réactiver le logo
\newcommand{\masquerLogo}{\ModifyLayer[contents={}]{logo.layer}}
\newcommand{\afficherLogo}{%
  \ModifyLayer[contents={%
    \IfFileExists{images/logo_test.png}{%
      \includegraphics[width=2.2cm]{images/logo_test.png}%
    }{}%
  }]{logo.layer}%
}

%----------------------------------------------------------------------------------
%  HYPERLIENS (hyperref), CÉSURE DES URL (xurl) & RÉFÉRENCES (cleveref)
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
\crefname{illustration}{illustration}{illustrations}
\Crefname{illustration}{Illustration}{Illustrations}

\endinput
