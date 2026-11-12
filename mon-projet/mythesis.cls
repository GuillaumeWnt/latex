%% ==============================================================================
%% mythesis.cls
%% Classe LaTeX modulaire de référence pour mémoires, thèses et rapports
%% Fondée sur KOMA-Script scrbook + cohabitation native geometry (LuaLaTeX)
%% ==============================================================================
\NeedsTeXFormat{LaTeX2e}[2020/01/01]
\ProvidesClass{mythesis}[2026/11/12 v2.0 Modern Modular Academic Book Class]

% --- Correction préventive des avertissements de packages tiers avec KOMA-Script ---
\RequirePackage{scrhack}
\RequirePackage{etoolbox}

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

% Option pour activer les notes marginales collaboratives (todonotes)
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

% Option de sélection de la police principale (compatible ClasseGuillaume)
\newcommand{\mythesis@font}{libertinus}
\DeclareOption{font=libertinus}{%
  \renewcommand{\mythesis@font}{libertinus}%
  \@expandtwoargs\@removeelement{font=libertinus}\@classoptionslist\@classoptionslist
}
\DeclareOption{font=heros}{%
  \renewcommand{\mythesis@font}{heros}%
  \@expandtwoargs\@removeelement{font=heros}\@classoptionslist\@classoptionslist
}
\DeclareOption{font=calibri}{%
  \renewcommand{\mythesis@font}{calibri}%
  \@expandtwoargs\@removeelement{font=calibri}\@classoptionslist\@classoptionslist
}
\DeclareOption{font=standard}{%
  \renewcommand{\mythesis@font}{standard}%
  \@expandtwoargs\@removeelement{font=standard}\@classoptionslist\@classoptionslist
}

% Transmettre toute autre option à la classe de base scrbook
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}

\ExecuteOptions{screen}
\ProcessOptions\relax

% --- Pré-configuration du profil pour éviter les recalculs multiples de typearea ---
\ifmythesis@print
  \PassOptionsToClass{twoside=true, open=right, BCOR=10mm, DIV=12}{scrbook}
\else
  \PassOptionsToClass{twoside=false, open=any, BCOR=0mm, DIV=12}{scrbook}
\fi

% --- Chargement de la classe parente scrbook ---
\LoadClass[
  a4paper,
  fontsize=11pt,
  headings=optiontoheadandtoc,
  numbers=noenddot,
  chapterprefix=false,
  appendixprefix=true,
  captions=tableheading
]{scrbook}

\KOMAoptions{
  headinclude=true,
  footinclude=false,
  headheight=20pt,
  footheight=20pt,
  usegeometry=true
}

% Ajustement dynamique de la largeur des numéros dans la TOC, LOF et LOT (évite les warnings tocbasic)
\DeclareTOCStyleEntries[dynnumwidth=true]{tocline}{part,chapter,section,subsection,subsubsection,figure,table}

% --- Chargement précoce de la gestion des couleurs ---
\RequirePackage[table, dvipsnames]{xcolor}

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
\emergencystretch=1.5em

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
\jury{}
\keywords{LaTeX, KOMA-Script, modularité, reproductibilité}

% Accesseurs publics pour les pages de titre et le corps (compatibles mythesis & ClasseGuillaume)
\newcommand{\getinstitution}{\mythesis@institution}
\newcommand{\getfaculty}{\mythesis@faculty}
\newcommand{\getdepartment}{\mythesis@department}
\newcommand{\getdegree}{\mythesis@degree}
\newcommand{\getspecialty}{\mythesis@specialty}
\newcommand{\getsupervisor}{\mythesis@supervisor}
\newcommand{\getcosupervisor}{\mythesis@cosupervisor}
\newcommand{\getjury}{\mythesis@jury}
\newcommand{\getlocation}{\mythesis@location}
\newcommand{\getkeywords}{\mythesis@keywords}
\newcommand{\gettitle}{\@title}
\newcommand{\getauthor}{\@author}
\newcommand{\getdate}{\@date}
\newcommand{\getsubtitle}{\@subtitle}

% --- Hiérarchie typographique et mise en scène des titres KOMA-Script ---
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}

\setkomafont{disposition}{\bfseries\sffamily\color{ThesisPrimary}}
\setkomafont{chapter}{\Huge\bfseries\sffamily\color{ThesisPrimary}}
\setkomafont{section}{\Large\bfseries\sffamily\color{ThesisPrimary}}
\setkomafont{subsection}{\large\bfseries\sffamily\color{ThesisSecondary}}
\setkomafont{subsubsection}{\normalsize\bfseries\sffamily\color{ThesisSecondary!85!black}}
\setkomafont{paragraph}{\normalsize\bfseries\sffamily\color{ThesisPrimary}}
\setkomafont{pageheadfoot}{\footnotesize\sffamily\color{ThesisMuted}}
\setkomafont{pagenumber}{\footnotesize\sffamily\bfseries\color{ThesisPrimary}}
\setkomafont{captionlabel}{\bfseries\sffamily\color{ThesisPrimary}}
\setkomafont{caption}{\small}
\setkomafont{descriptionlabel}{\bfseries\sffamily\color{ThesisPrimary}}

% Mise en scène architecturale des ouvertures de chapitres et d'annexes
\renewcommand*{\chapterformat}{%
  \textcolor{ThesisSecondary}{\fontsize{10}{13}\selectfont\bfseries\sffamily\MakeUppercase{\chapapp}\enskip\thechapter}%
}

\renewcommand*{\chapterlinesformat}[3]{%
  \Ifstr{#1}{chapter}{%
    \Ifstr{#2}{}{%
      % Chapitre non numéroté (\addchap : TOC, Résumé, Glossaire, Bibliographie)
      {\raggedchapter\interlinepenalty \@M #3\par}\nobreak%
      \vspace{6pt}\nobreak%
      \noindent{\color{ThesisPrimary}\rule{0.18\linewidth}{2.2pt}}{\color{ThesisSecondary!30}\rule{0.82\linewidth}{0.7pt}}\par%
    }{%
      % Chapitre numéroté (\chapter) ou Annexe (\appendix)
      \noindent{\color{ThesisAccent}\rule{3.5pt}{0.95em}}\enskip#2\par\nobreak%
      \vspace{5pt}\nobreak%
      {\raggedchapter\interlinepenalty \@M #3\par}\nobreak%
      \vspace{7pt}\nobreak%
      \noindent{\color{ThesisPrimary}\rule{0.22\linewidth}{2.2pt}}{\color{ThesisSecondary!30}\rule{0.78\linewidth}{0.7pt}}\par%
    }%
  }{%
    \@hangfrom{#2}{#3}%
  }%
}
\renewcommand*{\chapterlineswithprefixformat}[3]{\chapterlinesformat{#1}{#2}{#3}}

\RedeclareSectionCommand[
  beforeskip=-8pt,
  afterskip=18pt
]{chapter}

\RedeclareSectionCommand[
  beforeskip=-14pt,
  afterskip=7pt
]{section}

\RedeclareSectionCommand[
  beforeskip=-11pt,
  afterskip=5pt
]{subsection}

\RedeclareSectionCommand[
  beforeskip=-8pt,
  afterskip=4pt
]{subsubsection}

% --- Chargement des modules de configuration (polices, geometry, paquets et macros) ---
\RequirePackage{config/packages}
\RequirePackage{config/macros}

\providecommand{\thetitle}{\@title}
\providecommand{\theauthor}{\@author}
\providecommand{\thedate}{\@date}

% --- Logo institutionnel en calque d'arrière-plan dynamique (scrlayer) ---
% Positionné dans l'angle supérieur droit extérieur de la feuille (hors zone d'en-tête
% et hors filet headsepline, garantissant zéro collision quelle que soit la géométrie).
\newif\iflogoactive
\logoactivefalse
\newif\ifsavedlogo
\savedlogofalse

\newcommand{\mythesis@logo}{figures/logo.pdf}
\newcommand{\mythesis@logowidth}{1.05cm}

\newcommand{\thesislogo}[1]{\renewcommand{\mythesis@logo}{#1}}
\NewDocumentCommand{\definirLogo}{m O{1.05cm}}{%
  \renewcommand{\mythesis@logo}{#1}%
  \renewcommand{\mythesis@logowidth}{#2}%
}

\DeclareNewLayer[
  background,
  align=tr,
  hoffset=\paperwidth-0.40cm,
  voffset=0.35cm,
  width=1.4cm,
  height=1.2cm,
  contents={%
    \iflogoactive
      \ifdefempty{\mythesis@logo}{}{%
        \IfFileExists{\mythesis@logo}{%
          \hfill\includegraphics[width=\mythesis@logowidth, height=\mythesis@logowidth, keepaspectratio]{\mythesis@logo}%
        }{}%
      }%
    \fi
  }
]{thesis.logo.layer}

\newcommand{\masquerLogo}{\logoactivefalse}
\newcommand{\afficherLogo}{\logoactivetrue}

% --- Configuration des en-têtes et pieds de page avec scrlayer-scrpage ---
\clearpairofpagestyles
\automark[section]{chapter}

\ifmythesis@print
  % Configuration recto-verso pour impression reliée :
  % - Pages paires (versos) : Chapitre à gauche en haut, folio à gauche en bas
  % - Pages impaires (rectos) : Section à droite en haut, folio à droite en bas
  \lehead{\normalfont\sffamily\footnotesize\bfseries\color{ThesisPrimary}\truncate{0.92\linewidth}{\leftmark}}
  \rohead{\normalfont\sffamily\footnotesize\itshape\color{ThesisSecondary}\truncate{0.92\linewidth}{\rightmark}}
  \lefoot[\pagemark]{\pagemark}
  \rofoot[\pagemark]{\pagemark}
  \refoot[]{\normalfont\sffamily\scriptsize\color{ThesisMuted}\gettitle}
  \lofoot[]{\normalfont\sffamily\scriptsize\color{ThesisMuted}\getauthor}
\else
  % Configuration symétrique pour lecture écran :
  % - En-tête : Chapitre à gauche (tronqué à 48 %), Section courante à droite (tronquée à 48 % et omise si identique au chapitre)
  % - Pied de page : Signature discrète à gauche, folio mis en valeur à droite (y compris sur pages de chapitre)
  \ihead{\normalfont\sffamily\footnotesize\bfseries\color{ThesisPrimary}\truncate{0.48\linewidth}{\leftmark}}
  \ohead{%
    \Ifstr{\leftmark}{\rightmark}{}{%
      \normalfont\sffamily\footnotesize\itshape\color{ThesisSecondary}\truncate{0.48\linewidth}{\rightmark}%
    }%
  }
  \ifoot[]{\normalfont\sffamily\scriptsize\color{ThesisMuted}\getauthor\enspace\textcolor{ThesisSecondary}{\textbullet}\enspace\textit{\gettitle}}
  \ofoot[\pagemark]{\pagemark}
\fi

% Synchronisation automatique des filets lors de la sélection de scrheadings / plain.scrheadings
\AddToLayerPageStyleOptions{scrheadings}{%
  onselect={%
    \KOMAoptions{headsepline=0.5pt, footsepline=false}%
  }%
}
\AddToLayerPageStyleOptions{plain.scrheadings}{%
  onselect={%
    \KOMAoptions{headsepline=false, footsepline=false}%
  }%
}

\AddLayersToPageStyle{scrheadings}{thesis.logo.layer}
\AddLayersToPageStyle{plain.scrheadings}{thesis.logo.layer}

% --- Style de page de débogage / diagnostic d'édition (ThesisDebug & alias StyleTest) ---
\newpairofpagestyles{ThesisDebug}{
  \KOMAoptions{headsepline=0.8pt, footsepline=0.4pt}
  \clearpairofpagestyles
  \ihead{\normalfont\ttfamily\footnotesize\textcolor{ThesisPrimary}{[\jobname.tex]}}
  \chead{\normalfont\sffamily\scriptsize\bfseries\textcolor{ThesisAccent}{[DEBUG / RÉVISION]}}
  \ohead{\parbox[b]{0.36\linewidth}{\raggedleft\normalfont\sffamily\footnotesize\textcolor{ThesisSecondary}{\truncate{\linewidth}{\rightmark}}}}
  \ifmythesis@print
    \lefoot[\normalfont\ttfamily\footnotesize p.\thepage/\pageref{LastPage}]{\normalfont\ttfamily\footnotesize p.\thepage/\pageref{LastPage}}
    \rofoot[\normalfont\ttfamily\footnotesize p.\thepage/\pageref{LastPage}]{\normalfont\ttfamily\footnotesize p.\thepage/\pageref{LastPage}}
    \cefoot[]{\normalfont\ttfamily\scriptsize\textcolor{ThesisMuted}{Profil: print (BCOR=\mythesis@bcor)}}
    \cofoot[]{\normalfont\ttfamily\scriptsize\textcolor{ThesisMuted}{Profil: print (BCOR=\mythesis@bcor)}}
  \else
    \ifoot[]{\normalfont\ttfamily\scriptsize\textcolor{ThesisMuted}{Profil: screen | Police: \mythesis@font}}
    \ofoot[\normalfont\ttfamily\footnotesize Page \thepage{} / \pageref{LastPage}]{\normalfont\ttfamily\footnotesize Page \thepage{} sur \pageref{LastPage}}
  \fi
}

% --- Style de page épuré "Focus" (pour grands tableaux et schémas pleine page / paysage) ---
\newpairofpagestyles{StyleFocus}{
  \KOMAoptions{headsepline=false, footsepline=false}
  \clearpairofpagestyles
  \cfoot[\normalfont\sffamily\footnotesize\textcolor{ThesisMuted}{---\,\pagemark\,---}]{\normalfont\sffamily\footnotesize\textcolor{ThesisMuted}{---\,\pagemark\,---}}
}

% Commandes explicites d'activation des styles de page
\newcommand{\activerStyleDebug}{%
  \cleardoublepage%
  \pagestyle{ThesisDebug}%
}
\let\activerStyleTest\activerStyleDebug

\newcommand{\activerStyleFocus}{%
  \cleardoublepage%
  \pagestyle{StyleFocus}%
}

\newcommand{\activerStyleStandard}{%
  \cleardoublepage%
  \pagestyle{scrheadings}%
}

\pagestyle{scrheadings}

% --- Injection automatique des métadonnées dans le PDF via hyperref ---
\AtBeginDocument{
  \color{ThesisText}%
  \hypersetup{
    pdftitle={\@title},
    pdfauthor={\@author},
    pdfsubject={\mythesis@degree{} -- \mythesis@specialty},
    pdfkeywords={\mythesis@keywords},
    pdfcreator={LuaLaTeX with KOMA-Script scrbook and mythesis v2.0}
  }
}

% Protection contre les caractères et sauts de ligne dans les signets PDF
\pdfstringdefDisableCommands{%
  \let\\\space
  \let\code\@firstofone
  \let\term\@firstofone
  \let\textbullet\space
}

\endinput
