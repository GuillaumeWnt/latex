%% ==============================================================================
%% mythesis.cls
%% Classe LaTeX modulaire pour mémoires, thèses et rapports académiques
%% Fondée sur KOMA-Script scrbook (moteur moderne LuaLaTeX ou pdfLaTeX)
%% ==============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mythesis}[2026/10/17 v1.0 Modern Modular Academic Book Class]

% --- Correction préventive des avertissements de packages tiers avec KOMA-Script ---
\RequirePackage{scrhack}

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

% Option pour activer les notes marginales et la collaboration (todonotes)
\newif\ifmythesis@todos
\mythesis@todosfalse
\DeclareOption{todos}{%
  \mythesis@todostrue
  \@expandtwoargs\@removeelement{todos}\@classoptionslist\@classoptionslist
}
\DeclareOption{todoNote}{%
  \mythesis@todostrue
  \@expandtwoargs\@removeelement{todoNote}\@classoptionslist\@classoptionslist
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
\KOMAoptions{usegeometry=true}

% --- Chargement précoce de la gestion des couleurs ---
\RequirePackage[dvipsnames]{xcolor}

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

% Conditionnel public pour les notes de révision et tâches collaboratives
\newif\ifusetodos
\ifmythesis@todos
  \usetodostrue
\else
  \usetodosfalse
\fi

% --- Pénalités typographiques strictes (élimination des lignes veuves et orphelines) ---
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000
\doublehyphendemerits=10000
\brokenpenalty=10000
\interfootnotelinepenalty=9999

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

% --- Logo institutionnel en calque d'arrière-plan dynamique (scrlayer) ---
\newcommand{\thesislogo}[1]{\def\mythesis@logo{#1}}
\thesislogo{figures/logo.pdf}

\DeclareNewLayer[
  background,
  topmargin,
  align=tr,
  hoffset=\paperwidth-2.3cm,
  voffset=1.0cm,
  width=2cm,
  height=2cm,
  contents={%
    \ifx\mythesis@logo\empty\else
      \IfFileExists{\mythesis@logo}{%
        \includegraphics[width=1.4cm]{\mythesis@logo}%
      }{}%
    \fi
  }
]{thesis.logo.layer}

\AddLayersToPageStyle{scrheadings}{thesis.logo.layer}

\newcommand{\masquerLogo}{\ModifyLayer[contents={}]{thesis.logo.layer}}
\newcommand{\afficherLogo}{%
  \ModifyLayer[contents={%
    \ifx\mythesis@logo\empty\else
      \IfFileExists{\mythesis@logo}{%
        \includegraphics[width=1.4cm]{\mythesis@logo}%
      }{}%
    \fi
  }]{thesis.logo.layer}%
}

% --- Style de page de débogage / diagnostic d'édition ---
\newpairofpagestyles{ThesisDebug}{
  \clearpairofpagestyles
  \automark[section]{section}
  \ihead{\normalfont\ttfamily\footnotesize\textcolor{ThesisPrimary}{[\jobname.tex]}}
  \chead{\normalfont\sffamily\scriptsize\bfseries\textcolor{ThesisAccent}{[DEBUG / RÉVISION]}}
  \ohead{\parbox[b]{0.38\linewidth}{\raggedleft\normalfont\sffamily\footnotesize\textcolor{ThesisSecondary}{\truncate{\linewidth}{\rightmark}}}}
  \ifmythesis@print
    \lefoot{\normalfont\ttfamily\footnotesize p.\thepage/\pageref{LastPage}}
    \rofoot{\normalfont\ttfamily\footnotesize p.\thepage/\pageref{LastPage}}
  \else
    \cfoot{\normalfont\ttfamily\footnotesize Page \thepage{} sur \pageref{LastPage}}
  \fi
}

% --- Style de page épuré "Focus" (pour grands tableaux et schémas pleine page) ---
\newpairofpagestyles{StyleFocus}{
  \clearpairofpagestyles
  \cfoot{\normalfont\sffamily\footnotesize\textcolor{ThesisMuted}{---\,\pagemark\,---}}
}

% Commandes explicites d'activation des styles avec synchronisation des filets de séparation
\newcommand{\activerStyleDebug}{%
  \cleardoublepage%
  \KOMAoptions{headsepline=0.8pt, footsepline=0.4pt}%
  \pagestyle{ThesisDebug}%
}

\newcommand{\activerStyleFocus}{%
  \cleardoublepage%
  \KOMAoptions{headsepline=false, footsepline=false}%
  \pagestyle{StyleFocus}%
}

\newcommand{\activerStyleStandard}{%
  \cleardoublepage%
  \KOMAoptions{headsepline=0.5pt, footsepline=false}%
  \pagestyle{scrheadings}%
}

\pagestyle{scrheadings}
\KOMAoptions{headsepline=0.5pt, footsepline=false}

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

% Protection contre les caractères et sauts de ligne dans les signets PDF
\pdfstringdefDisableCommands{%
  \let\\\space
  \let\code\texttt
  \let\term\@firstofone
  \let\textbullet\space
}

\endinput
