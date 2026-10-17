%% ==============================================================================
%% mythesis.cls
%% Classe LaTeX modulaire pour mémoires, thèses et rapports académiques
%% Fondée sur KOMA-Script scrbook (moteur moderne LuaLaTeX ou pdfLaTeX)
%% ==============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mythesis}[2026/10/17 v1.0 Modern Modular Academic Book Class]

% --- Gestion des options de classe ---
\newif\ifmythesis@print
\mythesis@printfalse

\DeclareOption{print}{%
  \mythesis@printtrue
  \@expandtwoargs\@removeelement{print}\@classoptionslist\@classoptionslist
}
\DeclareOption{screen}{%
  \mythesis@printfalse
  \@expandtwoargs\@removeelement{screen}\@classoptionslist\@classoptionslist
}
% Transmettre toute autre option à la classe de base scrbook
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}

\ExecuteOptions{screen}
\ProcessOptions\relax

% --- Chargement de la classe parente scrbook ---
\LoadClass[
  a4paper,
  fontsize=11pt,
  headings=optiontoheadandtoc,
  numbers=noenddot,
  chapterprefix=false
]{scrbook}

% --- Chargement précoce de la gestion des couleurs ---
\RequirePackage{xcolor}

% --- Chargement du fichier d'options spécifique (.clo) ---
\ifmythesis@print
  \input{mythesis-print.clo}
\else
  \input{mythesis-screen.clo}
\fi

% --- Conditionnels publics de profil de document (accessibles aux auteurs) ---
\newif\ifprintversion
\ifmythesis@print
  \printversiontrue
\else
  \printversionfalse
\fi

\NewDocumentCommand{\ifprint}{m m}{\ifprintversion#1\else#2\fi}
\NewDocumentCommand{\screenonly}{+m}{\ifprintversion\else#1\fi}
\NewDocumentCommand{\printonly}{+m}{\ifprintversion#1\fi}

% --- Définition des métadonnées du document ---
\newcommand{\institution}[1]{\def\mythesis@institution{#1}}
\newcommand{\faculty}[1]{\def\mythesis@faculty{#1}}
\newcommand{\department}[1]{\def\mythesis@department{#1}}
\newcommand{\degree}[1]{\def\mythesis@degree{#1}}
\newcommand{\specialty}[1]{\def\mythesis@specialty{#1}}
\newcommand{\supervisor}[1]{\def\mythesis@supervisor{#1}}
\newcommand{\cosupervisor}[1]{\def\mythesis@cosupervisor{#1}}
\newcommand{\jury}[1]{\def\mythesis@jury{#1}}
\newcommand{\location}[1]{\def\mythesis@location{#1}}
\newcommand{\keywords}[1]{\def\mythesis@keywords{#1}}

% Valeurs par défaut pour éviter les erreurs si non renseignées
\institution{Université / École d'Ingénieurs}
\faculty{Faculté des Sciences et Techniques}
\department{Département Informatique et Systèmes}
\degree{Thèse de Doctorat}
\specialty{Sciences du Numérique \& Ingénierie des Systèmes}
\supervisor{Pr. Nom Encadrant}
\cosupervisor{Dr. Nom Co-encadrant}
\location{Paris}
\keywords{LaTeX, KOMA-Script, modularité, reproductibilité}

% Accesseurs publics pour les pages de titre et le corps
\newcommand{\getinstitution}{\mythesis@institution}
\newcommand{\getfaculty}{\mythesis@faculty}
\newcommand{\getdepartment}{\mythesis@department}
\newcommand{\getdegree}{\mythesis@degree}
\newcommand{\getspecialty}{\mythesis@specialty}
\newcommand{\getsupervisor}{\mythesis@supervisor}
\newcommand{\getcosupervisor}{\mythesis@cosupervisor}
\newcommand{\getlocation}{\mythesis@location}
\newcommand{\getkeywords}{\mythesis@keywords}

% --- Typographie KOMA-Script ---
\setkomafont{disposition}{\bfseries\sffamily\color{ThesisPrimary}}
\setkomafont{chapter}{\Huge\bfseries\sffamily\color{ThesisPrimary}}
\setkomafont{section}{\Large\bfseries\sffamily\color{ThesisPrimary}}
\setkomafont{subsection}{\large\bfseries\sffamily\color{ThesisSecondary}}
\setkomafont{subsubsection}{\normalsize\bfseries\sffamily\color{ThesisSecondary}}
\setkomafont{pageheadfoot}{\small\sffamily\color{ThesisMuted}}
\setkomafont{pagination}{\small\sffamily\bfseries\color{ThesisPrimary}}
\setkomafont{captionlabel}{\bfseries\sffamily\color{ThesisPrimary}}
\setkomafont{caption}{\small}
\setkomafont{descriptionlabel}{\bfseries\sffamily\color{ThesisPrimary}}

% --- Chargement des modules de configuration ---
\RequirePackage{config/packages}
\RequirePackage{config/macros}

% --- Configuration des en-têtes et pieds de page avec scrlayer-scrpage ---
\clearpairofpagestyles
\automark[section]{chapter}

\ifmythesis@print
  % Configuration recto-verso pour impression
  \lehead{\pagemark\quad\vrule\quad\headmark}
  \rohead{\headmark\quad\vrule\quad\pagemark}
\else
  % Configuration symétrique pour lecture écran
  \ihead{\headmark}
  \ohead{\pagemark}
\fi

% Configuration du style plain (pages de titre de chapitre, etc.)
\pagestyle{scrheadings}

% --- Injection automatique des métadonnées dans le PDF via hyperref ---
\AtBeginDocument{
  \hypersetup{
    pdftitle={\@title},
    pdfauthor={\@author},
    pdfsubject={\mythesis@degree{} -- \mythesis@specialty},
    pdfkeywords={\mythesis@keywords},
    pdfcreator={LuaLaTeX with KOMA-Script scrbook and mythesis class}
  }
}

\endinput
