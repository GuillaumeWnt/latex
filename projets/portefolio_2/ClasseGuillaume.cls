%% ==============================================================================
%% ClasseGuillaume.cls
%% Classe LaTeX modulaire de référence pour mémoires, thèses et rapports
%% Fondée sur KOMA-Script scrbook + cohabitation native geometry (LuaLaTeX)
%% ==============================================================================
\NeedsTeXFormat{LaTeX2e}[2020/01/01]
\ProvidesClass{ClasseGuillaume}[2026/11/12 v2.0 Modern Modular Academic Book Class]

% --- Correction préventive des avertissements de packages tiers avec KOMA-Script ---
\RequirePackage{scrhack}
\RequirePackage{etoolbox}

% --- Gestion des options de classe ---
\newif\ifClasseGuillaume@print
\ClasseGuillaume@printfalse

\DeclareOption{print}{%
  \ClasseGuillaume@printtrue
  \@expandtwoargs\@removeelement{print}\@classoptionslist\@classoptionslist
}
\DeclareOption{screen}{%
  \ClasseGuillaume@printfalse
  \@expandtwoargs\@removeelement{screen}\@classoptionslist\@classoptionslist
}

% Option pour activer les notes marginales collaboratives (todonotes)
\newif\ifClasseGuillaume@todos
\ClasseGuillaume@todosfalse
\DeclareOption{todos}{%
  \ClasseGuillaume@todostrue
  \@expandtwoargs\@removeelement{todos}\@classoptionslist\@classoptionslist
}
\DeclareOption{todoNote}{%
  \ClasseGuillaume@todostrue
  \@expandtwoargs\@removeelement{todoNote}\@classoptionslist\@classoptionslist
}

% Option de sélection de la police principale
\newcommand{\ClasseGuillaume@font}{libertinus}
\DeclareOption{font=libertinus}{%
  \renewcommand{\ClasseGuillaume@font}{libertinus}%
  \@expandtwoargs\@removeelement{font=libertinus}\@classoptionslist\@classoptionslist
}
\DeclareOption{font=heros}{%
  \renewcommand{\ClasseGuillaume@font}{heros}%
  \@expandtwoargs\@removeelement{font=heros}\@classoptionslist\@classoptionslist
}
\DeclareOption{font=calibri}{%
  \renewcommand{\ClasseGuillaume@font}{calibri}%
  \@expandtwoargs\@removeelement{font=calibri}\@classoptionslist\@classoptionslist
}
\DeclareOption{font=standard}{%
  \renewcommand{\ClasseGuillaume@font}{standard}%
  \@expandtwoargs\@removeelement{font=standard}\@classoptionslist\@classoptionslist
}
\DeclareOption{font=comicsans}{%
  \renewcommand{\ClasseGuillaume@font}{comicsans}%
  \@expandtwoargs\@removeelement{font=comicsans}\@classoptionslist\@classoptionslist
}

% Option de sélection du style bibliographique (custom par défaut, ou vancouver)
\newcommand{\ClasseGuillaume@bibstyle}{custom}
\DeclareOption{bibstyle=custom}{%
  \renewcommand{\ClasseGuillaume@bibstyle}{custom}%
  \@expandtwoargs\@removeelement{bibstyle=custom}\@classoptionslist\@classoptionslist
}
\DeclareOption{bibstyle=vancouver}{%
  \renewcommand{\ClasseGuillaume@bibstyle}{vancouver}%
  \@expandtwoargs\@removeelement{bibstyle=vancouver}\@classoptionslist\@classoptionslist
}

% Option d'interligne global (single par défaut, onehalf ou double via setspace)
\newcommand{\ClasseGuillaume@spacing}{single}
\DeclareOption{spacing=single}{%
  \renewcommand{\ClasseGuillaume@spacing}{single}%
  \@expandtwoargs\@removeelement{spacing=single}\@classoptionslist\@classoptionslist
}
\DeclareOption{spacing=onehalf}{%
  \renewcommand{\ClasseGuillaume@spacing}{onehalf}%
  \@expandtwoargs\@removeelement{spacing=onehalf}\@classoptionslist\@classoptionslist
}
\DeclareOption{spacing=double}{%
  \renewcommand{\ClasseGuillaume@spacing}{double}%
  \@expandtwoargs\@removeelement{spacing=double}\@classoptionslist\@classoptionslist
}

% Option de langue principale (french par défaut, ou english pour un document en anglais)
\newif\ifClasseGuillaume@english
\ClasseGuillaume@englishfalse
\DeclareOption{english}{%
  \ClasseGuillaume@englishtrue
  \@expandtwoargs\@removeelement{english}\@classoptionslist\@classoptionslist
}
\DeclareOption{french}{%
  \ClasseGuillaume@englishfalse
  \@expandtwoargs\@removeelement{french}\@classoptionslist\@classoptionslist
}

% Transmettre toute autre option à la classe de base scrbook
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}

\ExecuteOptions{screen}
\ProcessOptions\relax

% --- Pré-configuration du profil pour éviter les recalculs multiples de typearea ---
\ifClasseGuillaume@print
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
\ifClasseGuillaume@print
  \input{ClasseGuillaume-print.clo}
\else
  \input{ClasseGuillaume-screen.clo}
\fi

% --- Conditionnels publics de profil de document (accessibles aux auteurs) ---
\newif\ifprintversion
\ifClasseGuillaume@print
  \printversiontrue
\else
  \printversionfalse
\fi

\NewDocumentCommand{\ifprint}{m m}{\ifprintversion#1\else#2\fi}
\NewDocumentCommand{\screenonly}{+m}{\ifprintversion\else#1\fi}
\NewDocumentCommand{\printonly}{+m}{\ifprintversion#1\fi}

% Conditionnel public pour les notes de révision et tâches collaboratives
\newif\ifusetodos
\ifClasseGuillaume@todos
  \usetodostrue
\else
  \usetodosfalse
\fi

% Conditionnel public de langue principale (false = french par défaut, true = english)
\newif\ifenglishversion
\ifClasseGuillaume@english
  \englishversiontrue
\else
  \englishversionfalse
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
\newcommand{\institution}[1]{\def\ClasseGuillaume@institution{#1}}
\newcommand{\faculty}[1]{\def\ClasseGuillaume@faculty{#1}}
\newcommand{\department}[1]{\def\ClasseGuillaume@department{#1}}
\newcommand{\degree}[1]{\def\ClasseGuillaume@degree{#1}}
\newcommand{\specialty}[1]{\def\ClasseGuillaume@specialty{#1}}
\newcommand{\supervisor}[1]{\def\ClasseGuillaume@supervisor{#1}}
\newcommand{\cosupervisor}[1]{\def\ClasseGuillaume@cosupervisor{#1}}
\newcommand{\jury}[1]{\def\ClasseGuillaume@jury{#1}}
\newcommand{\location}[1]{\def\ClasseGuillaume@location{#1}}
\newcommand{\keywords}[1]{\def\ClasseGuillaume@keywords{#1}}

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

% Accesseurs publics pour les pages de titre et le corps
\newcommand{\getinstitution}{\ClasseGuillaume@institution}
\newcommand{\getfaculty}{\ClasseGuillaume@faculty}
\newcommand{\getdepartment}{\ClasseGuillaume@department}
\newcommand{\getdegree}{\ClasseGuillaume@degree}
\newcommand{\getspecialty}{\ClasseGuillaume@specialty}
\newcommand{\getsupervisor}{\ClasseGuillaume@supervisor}
\newcommand{\getcosupervisor}{\ClasseGuillaume@cosupervisor}
\newcommand{\getjury}{\ClasseGuillaume@jury}
\newcommand{\getlocation}{\ClasseGuillaume@location}
\newcommand{\getkeywords}{\ClasseGuillaume@keywords}
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

\newcommand{\ClasseGuillaume@logo}{figures/logo.pdf}
\newcommand{\ClasseGuillaume@logowidth}{1.05cm}

\newcommand{\thesislogo}[1]{\renewcommand{\ClasseGuillaume@logo}{#1}}
\NewDocumentCommand{\definirLogo}{m O{1.05cm}}{%
  \renewcommand{\ClasseGuillaume@logo}{#1}%
  \renewcommand{\ClasseGuillaume@logowidth}{#2}%
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
      \ifdefempty{\ClasseGuillaume@logo}{}{%
        \IfFileExists{\ClasseGuillaume@logo}{%
          \hfill\includegraphics[width=\ClasseGuillaume@logowidth, height=\ClasseGuillaume@logowidth, keepaspectratio]{\ClasseGuillaume@logo}%
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

\ifClasseGuillaume@print
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
  \chead{\normalfont\sffamily\scriptsize\bfseries\textcolor{ThesisAccent}{[DEBUG / \ifClasseGuillaume@english REVISION\else RÉVISION\fi]}}
  \ohead{\parbox[b]{0.36\linewidth}{\raggedleft\normalfont\sffamily\footnotesize\textcolor{ThesisSecondary}{\truncate{\linewidth}{\rightmark}}}}
  \ifClasseGuillaume@print
    \lefoot[\normalfont\ttfamily\footnotesize p.\thepage/\pageref{LastPage}]{\normalfont\ttfamily\footnotesize p.\thepage/\pageref{LastPage}}
    \rofoot[\normalfont\ttfamily\footnotesize p.\thepage/\pageref{LastPage}]{\normalfont\ttfamily\footnotesize p.\thepage/\pageref{LastPage}}
    \cefoot[]{\normalfont\ttfamily\scriptsize\textcolor{ThesisMuted}{\ifClasseGuillaume@english Profile\else Profil\fi: print (BCOR=\ClasseGuillaume@bcor)}}
    \cofoot[]{\normalfont\ttfamily\scriptsize\textcolor{ThesisMuted}{\ifClasseGuillaume@english Profile\else Profil\fi: print (BCOR=\ClasseGuillaume@bcor)}}
  \else
    \ifoot[]{\normalfont\ttfamily\scriptsize\textcolor{ThesisMuted}{\ifClasseGuillaume@english Profile\else Profil\fi: screen | \ifClasseGuillaume@english Font\else Police\fi: \ClasseGuillaume@font}}
    \ofoot[\normalfont\ttfamily\footnotesize Page \thepage{} / \pageref{LastPage}]{\normalfont\ttfamily\footnotesize Page \thepage{} \ifClasseGuillaume@english of\else sur\fi{} \pageref{LastPage}}
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
    pdfsubject={\ClasseGuillaume@degree{} -- \ClasseGuillaume@specialty},
    pdfkeywords={\ClasseGuillaume@keywords},
    pdfcreator={LuaLaTeX with KOMA-Script scrbook and ClasseGuillaume v2.0}
  }
}

% Protection contre les caractères et sauts de ligne dans les signets PDF
\pdfstringdefDisableCommands{%
  \let\\\space
  \let\code\@firstofone
  \let\term\@firstofone
  \let\textbullet\space
  \let\textsc\@firstofone
}

\endinput
