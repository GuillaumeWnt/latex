%% ==============================================================================
%% ClasseGuillaumeSlides.cls
%% Classe LaTeX modulaire pour présentations éditoriales modernes (16:9)
%% Fondée sur Beamer + moteur minimal Moloch (v2.1+) + palette ClasseGuillaume
%% ==============================================================================
\NeedsTeXFormat{LaTeX2e}[2020/01/01]
\ProvidesClass{ClasseGuillaumeSlides}[2026/11/14 v1.0 Modern Modular Presentation Class]

\RequirePackage{etoolbox}

% --- Gestion des options de classe ---
% Langue (french par défaut)
\newif\ifClasseGuillaumeSlides@english
\ClasseGuillaumeSlides@englishfalse
\DeclareOption{english}{%
  \ClasseGuillaumeSlides@englishtrue
  \@expandtwoargs\@removeelement{english}\@classoptionslist\@classoptionslist
}
\DeclareOption{french}{%
  \ClasseGuillaumeSlides@englishfalse
  \@expandtwoargs\@removeelement{french}\@classoptionslist\@classoptionslist
}

% Thème clair / sombre (light par défaut)
\newif\ifClasseGuillaumeSlides@dark
\ClasseGuillaumeSlides@darkfalse
\DeclareOption{theme=light}{%
  \ClasseGuillaumeSlides@darkfalse
  \@expandtwoargs\@removeelement{theme=light}\@classoptionslist\@classoptionslist
}
\DeclareOption{theme=dark}{%
  \ClasseGuillaumeSlides@darktrue
  \@expandtwoargs\@removeelement{theme=dark}\@classoptionslist\@classoptionslist
}

% Mode sous-projet intégré dans un document ClasseGuillaume (dossier slides/)
\newif\ifClasseGuillaumeSlides@integrated
\ClasseGuillaumeSlides@integratedfalse
\DeclareOption{integrated}{%
  \ClasseGuillaumeSlides@integratedtrue
  \@expandtwoargs\@removeelement{integrated}\@classoptionslist\@classoptionslist
}

% Police sans-serif principale
\newcommand{\ClasseGuillaumeSlides@font}{fira}
\DeclareOption{font=fira}{%
  \renewcommand{\ClasseGuillaumeSlides@font}{fira}%
  \@expandtwoargs\@removeelement{font=fira}\@classoptionslist\@classoptionslist
}
\DeclareOption{font=heros}{%
  \renewcommand{\ClasseGuillaumeSlides@font}{heros}%
  \@expandtwoargs\@removeelement{font=heros}\@classoptionslist\@classoptionslist
}
\DeclareOption{font=calibri}{%
  \renewcommand{\ClasseGuillaumeSlides@font}{calibri}%
  \@expandtwoargs\@removeelement{font=calibri}\@classoptionslist\@classoptionslist
}
\DeclareOption{font=plex}{%
  \renewcommand{\ClasseGuillaumeSlides@font}{plex}%
  \@expandtwoargs\@removeelement{font=plex}\@classoptionslist\@classoptionslist
}
\DeclareOption{font=libertinus}{%
  \renewcommand{\ClasseGuillaumeSlides@font}{libertinus}%
  \@expandtwoargs\@removeelement{font=libertinus}\@classoptionslist\@classoptionslist
}

% Format d'écran (16:9 par défaut)
\newcommand{\ClasseGuillaumeSlides@ratio}{169}
\DeclareOption{ratio=169}{%
  \renewcommand{\ClasseGuillaumeSlides@ratio}{169}%
  \@expandtwoargs\@removeelement{ratio=169}\@classoptionslist\@classoptionslist
}
\DeclareOption{ratio=1610}{%
  \renewcommand{\ClasseGuillaumeSlides@ratio}{1610}%
  \@expandtwoargs\@removeelement{ratio=1610}\@classoptionslist\@classoptionslist
}
\DeclareOption{ratio=43}{%
  \renewcommand{\ClasseGuillaumeSlides@ratio}{43}%
  \@expandtwoargs\@removeelement{ratio=43}\@classoptionslist\@classoptionslist
}

% Position de la barre de progression (foot par défaut)
\newcommand{\ClasseGuillaumeSlides@progressbar}{foot}
\DeclareOption{progressbar=foot}{%
  \renewcommand{\ClasseGuillaumeSlides@progressbar}{foot}%
  \@expandtwoargs\@removeelement{progressbar=foot}\@classoptionslist\@classoptionslist
}
\DeclareOption{progressbar=head}{%
  \renewcommand{\ClasseGuillaumeSlides@progressbar}{head}%
  \@expandtwoargs\@removeelement{progressbar=head}\@classoptionslist\@classoptionslist
}
\DeclareOption{progressbar=frametitle}{%
  \renewcommand{\ClasseGuillaumeSlides@progressbar}{frametitle}%
  \@expandtwoargs\@removeelement{progressbar=frametitle}\@classoptionslist\@classoptionslist
}
\DeclareOption{progressbar=none}{%
  \renewcommand{\ClasseGuillaumeSlides@progressbar}{none}%
  \@expandtwoargs\@removeelement{progressbar=none}\@classoptionslist\@classoptionslist
}

% Diapositive de transition automatique sur \section{}
\newif\ifClasseGuillaumeSlides@sectionpage
\ClasseGuillaumeSlides@sectionpagetrue
\DeclareOption{sectionpage=on}{%
  \ClasseGuillaumeSlides@sectionpagetrue
  \@expandtwoargs\@removeelement{sectionpage=on}\@classoptionslist\@classoptionslist
}
\DeclareOption{sectionpage=off}{%
  \ClasseGuillaumeSlides@sectionpagefalse
  \@expandtwoargs\@removeelement{sectionpage=off}\@classoptionslist\@classoptionslist
}

% Notes orateur sur second écran (utile avec pdfpc / pympress)
\newif\ifClasseGuillaumeSlides@notes
\ClasseGuillaumeSlides@notesfalse
\DeclareOption{notes}{%
  \ClasseGuillaumeSlides@notestrue
  \@expandtwoargs\@removeelement{notes}\@classoptionslist\@classoptionslist
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}

\ProcessOptions\relax

% --- Chargement propre de Beamer sans conflit d'options xcolor/hyperref ---
\PassOptionsToPackage{dvipsnames, table}{xcolor}
\PassOptionsToPackage{bookmarksopen=true, pdfcreator={LuaLaTeX with Beamer, Moloch and ClasseGuillaumeSlides v1.0}}{hyperref}

\LoadClass[
  aspectratio=\ClasseGuillaumeSlides@ratio,
  10pt,
  t
]{beamer}

% Conditionnels publics accessibles aux auteurs et packages
\newif\ifenglishversion
\ifClasseGuillaumeSlides@english
  \englishversiontrue
\else
  \englishversionfalse
\fi

\newif\ifdarktheme
\ifClasseGuillaumeSlides@dark
  \darkthemetrue
\else
  \darkthemefalse
\fi

\newif\ifintegratedslides
\ifClasseGuillaumeSlides@integrated
  \integratedslidestrue
\else
  \integratedslidesfalse
\fi

\ifClasseGuillaumeSlides@notes
  \RequirePackage{pgfpages}
  \setbeameroption{show notes on second screen=right}
\fi

% --- Socle visuel épuré Moloch (sans chrome Beamer daté) ---
\usetheme[progressbar=none, sectionpage=none]{moloch}
\molochset{block=fill}
\usefonttheme{professionalfonts}

% --- Palette de référence ClasseGuillaume (invariante pour les diagrammes TikZ) ---
\definecolor{ThesisPrimary}{RGB}{15, 60, 110}
\definecolor{ThesisSecondary}{RGB}{20, 110, 120}
\definecolor{ThesisAccent}{RGB}{190, 75, 40}
\definecolor{ThesisText}{RGB}{30, 35, 42}
\definecolor{ThesisMuted}{RGB}{95, 105, 118}
\definecolor{ThesisBackground}{RGB}{246, 248, 251}
\definecolor{ThesisLink}{RGB}{18, 90, 150}

% --- Palette adaptative de l'interface des diapositives (light vs dark) ---
\ifdarktheme
  \definecolor{SlideBg}{RGB}{18, 25, 36}
  \definecolor{SlideFg}{RGB}{237, 242, 247}
  \definecolor{SlideTitleFg}{RGB}{245, 248, 252}
  \definecolor{SlidePrimary}{RGB}{96, 198, 210}
  \definecolor{SlideSecondary}{RGB}{110, 205, 214}
  \definecolor{SlideAccent}{RGB}{238, 128, 92}
  \definecolor{SlideMuted}{RGB}{152, 167, 187}
  \definecolor{SlideCardBg}{RGB}{28, 38, 52}
  \definecolor{SlideBorder}{RGB}{52, 68, 90}
  \definecolor{SlideBarBg}{RGB}{38, 50, 66}
  \definecolor{SlideStandoutBg}{RGB}{15, 60, 110}
  \definecolor{SlideStandoutFg}{RGB}{255, 255, 255}
\else
  \definecolor{SlideBg}{RGB}{255, 255, 255}
  \definecolor{SlideFg}{RGB}{30, 35, 42}
  \definecolor{SlideTitleFg}{RGB}{15, 60, 110}
  \definecolor{SlidePrimary}{RGB}{15, 60, 110}
  \definecolor{SlideSecondary}{RGB}{20, 110, 120}
  \definecolor{SlideAccent}{RGB}{190, 75, 40}
  \definecolor{SlideMuted}{RGB}{95, 105, 118}
  \definecolor{SlideCardBg}{RGB}{246, 248, 251}
  \definecolor{SlideBorder}{RGB}{214, 222, 232}
  \definecolor{SlideBarBg}{RGB}{224, 231, 239}
  \definecolor{SlideStandoutBg}{RGB}{15, 60, 110}
  \definecolor{SlideStandoutFg}{RGB}{255, 255, 255}
\fi

% Application aux couleurs Beamer/Moloch
\setbeamercolor{normal text}{fg=SlideFg, bg=SlideBg}
\setbeamercolor{background canvas}{bg=SlideBg}
\setbeamercolor{structure}{fg=SlidePrimary}
\setbeamercolor{alerted text}{fg=SlideAccent}
\setbeamercolor{example text}{fg=SlideSecondary}
\setbeamercolor{frametitle}{fg=SlideTitleFg, bg=SlideBg}
\setbeamercolor{framesubtitle}{fg=SlideMuted, bg=SlideBg}
\setbeamercolor{title}{fg=SlideTitleFg}
\setbeamercolor{subtitle}{fg=SlideMuted}
\setbeamercolor{author}{fg=SlideFg}
\setbeamercolor{institute}{fg=SlideMuted}
\setbeamercolor{date}{fg=SlideMuted}
\setbeamercolor{section title}{fg=SlideTitleFg}
\setbeamercolor{subsection title}{fg=SlideMuted}
\setbeamercolor{standout}{fg=SlideStandoutFg, bg=SlideStandoutBg}
\setbeamercolor{progress bar}{fg=SlideAccent, bg=SlideBarBg}
\setbeamercolor{footline}{fg=SlideMuted, bg=SlideBg}
\setbeamercolor{page number in head/foot}{fg=SlidePrimary}
\setbeamercolor{caption name}{fg=SlidePrimary}
\setbeamercolor{block title}{fg=SlideTitleFg, bg=SlideCardBg}
\setbeamercolor{block body}{fg=SlideFg, bg=SlideCardBg}
\setbeamercolor{block title alerted}{fg=SlideAccent, bg=SlideAccent!10!SlideBg}
\setbeamercolor{block body alerted}{fg=SlideFg, bg=SlideAccent!6!SlideBg}
\setbeamercolor{block title example}{fg=SlideSecondary, bg=SlideSecondary!10!SlideBg}
\setbeamercolor{block body example}{fg=SlideFg, bg=SlideSecondary!6!SlideBg}

% --- Configuration des paquets et macros des diapositives ---
\RequirePackage{config/slides-packages}
\RequirePackage{config/slides-macros}

% --- Métadonnées enrichies ---
\ifenglishversion
  \newcommand{\ClasseGuillaumeSlides@category}{PRESENTATION}
  \newcommand{\ClasseGuillaumeSlides@sectiontag}{SECTION}
\else
  \newcommand{\ClasseGuillaumeSlides@category}{PRÉSENTATION}
  \newcommand{\ClasseGuillaumeSlides@sectiontag}{PARTIE}
\fi
\newcommand{\ClasseGuillaumeSlides@event}{}
\newcommand{\ClasseGuillaumeSlides@location}{}
\newcommand{\ClasseGuillaumeSlides@footer}{\insertshorttitle\ifx\insertshortauthor\@empty\else\enspace\textcolor{SlideBorder}{|}\enspace\insertshortauthor\fi}
\newcommand{\ClasseGuillaumeSlides@logo}{figures/logo.pdf}
\newcommand{\ClasseGuillaumeSlides@logowidth}{1.35cm}
\newif\ifslideslogo
\slideslogofalse

\newcommand{\category}[1]{\renewcommand{\ClasseGuillaumeSlides@category}{#1}}
\newcommand{\event}[1]{\renewcommand{\ClasseGuillaumeSlides@event}{#1}}
\newcommand{\location}[1]{\renewcommand{\ClasseGuillaumeSlides@location}{#1}}
\newcommand{\footertext}[1]{\renewcommand{\ClasseGuillaumeSlides@footer}{#1}}
\NewDocumentCommand{\definirLogo}{m O{1.35cm}}{%
  \renewcommand{\ClasseGuillaumeSlides@logo}{#1}%
  \renewcommand{\ClasseGuillaumeSlides@logowidth}{#2}%
}
\newcommand{\afficherLogoSlides}{\slideslogotrue}
\newcommand{\masquerLogoSlides}{\slideslogofalse}

% --- Hiérarchie typographique des diapositives ---
\setbeamersize{text margin left=1.0cm, text margin right=1.0cm}
\setbeamertemplate{navigation symbols}{}
\setbeamerfont{title}{size=\fontsize{21}{25}, series=\bfseries, family=\sffamily}
\setbeamerfont{subtitle}{size=\fontsize{11}{15}, series=\normalfont, family=\sffamily}
\setbeamerfont{author}{size=\small, series=\bfseries, family=\sffamily}
\setbeamerfont{institute}{size=\footnotesize, series=\normalfont, family=\sffamily}
\setbeamerfont{date}{size=\footnotesize, series=\normalfont, family=\sffamily}
\setbeamerfont{frametitle}{size=\fontsize{15}{18}, series=\bfseries, family=\sffamily}
\setbeamerfont{framesubtitle}{size=\fontsize{8.5}{11}, series=\normalfont, family=\sffamily}
\setbeamerfont{section title}{size=\fontsize{19}{23}, series=\bfseries, family=\sffamily}
\setbeamerfont{footline}{size=\scriptsize, family=\sffamily}
\setbeamerfont{caption}{size=\footnotesize, family=\sffamily}
\setbeamerfont{caption name}{size=\footnotesize, series=\bfseries, family=\sffamily}
\setbeamerfont{block title}{size=\small, series=\bfseries, family=\sffamily}
\setbeamerfont{standout}{size=\fontsize{18}{23}, series=\bfseries, family=\sffamily}

% Espacement des listes propre (sans enumitem pour préserver les overlays Beamer)
\setlength{\leftmargini}{1.2em}
\setlength{\leftmarginii}{1.1em}
\setlength{\leftmarginiii}{1.0em}
\setbeamertemplate{bibliography item}{}
\addtobeamertemplate{itemize/enumerate body begin}{}{%
  \setlength{\itemsep}{3pt}%
  \setlength{\parskip}{0pt}%
}

% --- Barre de progression modulaire ---
\newcommand{\ClasseGuillaumeSlides@drawprogressbar}{%
  \nointerlineskip%
  \pgfmathsetlength{\moloch@progressinheadfoot}{%
    \paperwidth * min(1, \insertframenumber / max(1, \inserttotalframenumber))%
  }%
  \begin{beamercolorbox}[wd=\paperwidth]{progress bar}%
    \tikzexternaldisable%
    \begin{tikzpicture}%
      \fill[SlideBarBg] (0,0) rectangle (\paperwidth, 1.8pt);%
      \fill[SlideAccent] (0,0) rectangle (\moloch@progressinheadfoot, 1.8pt);%
    \end{tikzpicture}%
    \tikzexternalenable%
  \end{beamercolorbox}%
}

% --- En-tête minimal (barre uniquement si progressbar=head) ---
\setbeamertemplate{headline}{%
  \ifdefstring{\ClasseGuillaumeSlides@progressbar}{head}{%
    \ClasseGuillaumeSlides@drawprogressbar%
  }{}%
}

% Insertion de logo avec repli parent ../ en mode integrated
\newcommand{\ClasseGuillaumeSlides@includelogo}[1]{%
  \IfFileExists{\ClasseGuillaumeSlides@logo}{%
    \includegraphics[#1]{\ClasseGuillaumeSlides@logo}%
  }{%
    \ifintegratedslides%
      \IfFileExists{../\ClasseGuillaumeSlides@logo}{%
        \includegraphics[#1]{../\ClasseGuillaumeSlides@logo}%
      }{}%
    \fi%
  }%
}

% --- Titre de diapositive éditorial (eyebrow de section + titre fort + filet bicolore) ---
\setbeamertemplate{frametitle}{%
  \nointerlineskip%
  \begin{beamercolorbox}[wd=\paperwidth, leftskip=1.0cm, rightskip=1.0cm]{frametitle}%
    \vspace*{0.24cm}%
    \ifx\insertsectionhead\@empty%
    \else%
      {\fontsize{7}{8.5}\selectfont\bfseries\sffamily\color{SlideSecondary}%
        \MakeUppercase{\insertsectionhead}}%
      \ifslideslogo%
        \hfill\raisebox{-0.2ex}{\ClasseGuillaumeSlides@includelogo{height=0.40cm, keepaspectratio}}%
      \fi%
      \par\vspace*{0.08cm}%
    \fi%
    \parbox[b]{\textwidth}{%
      \raggedright%
      \usebeamerfont{frametitle}\usebeamercolor[fg]{frametitle}\insertframetitle%
      \ifx\insertframesubtitle\@empty%
      \else%
        \par\vspace*{0.05cm}%
        \usebeamerfont{framesubtitle}\usebeamercolor[fg]{framesubtitle}\insertframesubtitle%
      \fi%
    }\par%
    \vspace*{0.15cm}%
    \ifdefstring{\ClasseGuillaumeSlides@progressbar}{frametitle}{%
      \pgfmathsetlength{\moloch@progressinheadfoot}{%
        \textwidth * min(1, \insertframenumber / max(1, \inserttotalframenumber))%
      }%
      \tikzexternaldisable%
      \noindent\begin{tikzpicture}%
        \fill[SlideBorder] (0,0) rectangle (\textwidth, 0.7pt);%
        \fill[SlideAccent] (0,0) rectangle (\moloch@progressinheadfoot, 1.6pt);%
      \end{tikzpicture}\par%
      \tikzexternalenable%
    }{%
      \noindent\hbox to \textwidth{{\color{SlideAccent}\rule{1.6cm}{1.6pt}}{\color{SlideBorder}\leaders\hrule height 0.5pt\hfill}}\par%
    }%
    \vspace*{0.12cm}%
  \end{beamercolorbox}%
}

% --- Pied de page épuré (métadonnée discrète + folio + barre optionnelle) ---
\setbeamertemplate{footline}{%
  \begin{beamercolorbox}[wd=\paperwidth, leftskip=1.0cm, rightskip=1.0cm]{footline}%
    \usebeamerfont{footline}%
    \textcolor{SlideMuted}{\ClasseGuillaumeSlides@footer}%
    \hfill%
    \textcolor{SlidePrimary}{\textbf{\insertframenumber}}%
    \textcolor{SlideMuted}{\,/\,\inserttotalframenumber}%
    \vspace*{0.16cm}%
  \end{beamercolorbox}%
  \ifdefstring{\ClasseGuillaumeSlides@progressbar}{foot}{%
    \ClasseGuillaumeSlides@drawprogressbar%
  }{}%
}

% --- Page de titre éditoriale asymétrique ---
\setbeamertemplate{title page}{%
  \tikz[remember picture, overlay]{%
    \fill[ThesisPrimary] (current page.north west) rectangle ([xshift=0.38cm]current page.south west);%
    \fill[SlideAccent] ([xshift=0.38cm]current page.north west) rectangle ([xshift=0.50cm]current page.south west);%
    \ifdarktheme\else%
      \fill[SlideCardBg] ([xshift=0.50cm]current page.south west) rectangle ([yshift=2.35cm]current page.south east);%
    \fi%
  }%
  \begin{minipage}[t][\dimexpr\paperheight-1.6cm\relax][s]{\textwidth}%
    \vspace*{0.40cm}%
    {\fontsize{8}{10}\selectfont\bfseries\sffamily\color{SlideAccent}%
      \MakeUppercase{\ClasseGuillaumeSlides@category}}%
    \ifdefempty{\ClasseGuillaumeSlides@event}{}{%
      \enspace\textcolor{SlideBorder}{|}\enspace%
      {\fontsize{8}{10}\selectfont\sffamily\color{SlideSecondary}\ClasseGuillaumeSlides@event}%
    }%
    \par\vspace*{0.36cm}%
    {\usebeamerfont{title}\usebeamercolor[fg]{title}\raggedright\inserttitle\par}%
    \ifx\insertsubtitle\@empty\else%
      \vspace*{0.30cm}%
      {\usebeamerfont{subtitle}\usebeamercolor[fg]{subtitle}\raggedright\insertsubtitle\par}%
    \fi%
    \vspace*{0.45cm}%
    \hbox to 0.38\textwidth{{\color{SlideAccent}\rule{1.8cm}{2.2pt}}{\color{SlideBorder}\leaders\hrule height 0.7pt\hfill}}%
    \vfill%
    \begin{columns}[b, totalwidth=\textwidth]%
      \begin{column}{0.72\textwidth}%
        {\usebeamerfont{author}\usebeamercolor[fg]{author}\insertauthor\par}%
        \ifx\insertinstitute\@empty\else%
          \vspace*{0.10cm}%
          {\usebeamerfont{institute}\usebeamercolor[fg]{institute}\insertinstitute\par}%
        \fi%
        \vspace*{0.10cm}%
        {\usebeamerfont{date}\usebeamercolor[fg]{date}%
          \insertdate%
          \ifdefempty{\ClasseGuillaumeSlides@location}{}{\enspace\textbullet\enspace\ClasseGuillaumeSlides@location}%
        \par}%
      \end{column}%
      \begin{column}{0.26\textwidth}%
        \raggedleft%
        \ClasseGuillaumeSlides@includelogo{width=\ClasseGuillaumeSlides@logowidth, height=1.25cm, keepaspectratio}%
      \end{column}%
    \end{columns}%
    \vspace*{0.20cm}%
  \end{minipage}%
}

\def\maketitle{%
  \ifbeamer@inframe%
    \titlepage%
  \else%
    \frame[plain,noframenumbering]{\titlepage}%
  \fi%
}

% --- Diapositive de section éditoriale numérotée ---
\setbeamertemplate{section page}{%
  \begin{minipage}[c]{0.86\textwidth}%
    \raggedright%
    {\fontsize{28}{30}\selectfont\bfseries\sffamily\color{SlideAccent}%
      \ifnum\value{section}<10 0\fi\thesection}%
    \par\vspace*{0.18cm}%
    {\fontsize{8}{10}\selectfont\bfseries\sffamily\color{SlideSecondary}%
      \MakeUppercase{\ClasseGuillaumeSlides@sectiontag}}%
    \par\vspace*{0.22cm}%
    {\usebeamerfont{section title}\usebeamercolor[fg]{section title}\insertsectionhead\par}%
    \vspace*{0.42cm}%
    \pgfmathsetlength{\moloch@progressonsectionpage}{%
      \linewidth * min(1, \insertframenumber / max(1, \inserttotalframenumber))%
    }%
    \tikzexternaldisable%
    \begin{tikzpicture}%
      \fill[SlideBarBg] (0,0) rectangle (\linewidth, 2pt);%
      \fill[SlideAccent] (0,0) rectangle (\moloch@progressonsectionpage, 2pt);%
    \end{tikzpicture}%
    \tikzexternalenable%
    \ifx\insertsubsectionhead\@empty\else%
      \par\vspace*{0.25cm}%
      {\usebeamerfont{subsection title}\usebeamercolor[fg]{subsection title}\insertsubsectionhead\par}%
    \fi%
  \end{minipage}%
}

\ifClasseGuillaumeSlides@sectionpage
  \AtBeginSection{%
    \ifbeamer@inframe%
      \sectionpage%
    \else%
      \frame[plain,c,noframenumbering]{\sectionpage}%
    \fi%
  }
\fi

% --- Métadonnées PDF ---
\pdfstringdefDisableCommands{%
  \let\\\space
  \let\code\@firstofone
  \let\term\@firstofone
  \let\textbullet\space
}

\endinput
