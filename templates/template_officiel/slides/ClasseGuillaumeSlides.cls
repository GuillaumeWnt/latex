%% ==============================================================================
%% ClasseGuillaumeSlides.cls
%% Classe LaTeX modulaire pour présentations éditoriales modernes (16:9)
%% Fondée sur Beamer + moteur minimal Moloch + compositions TikZ natives
%% ==============================================================================
\NeedsTeXFormat{LaTeX2e}[2020/01/01]
\ProvidesClass{ClasseGuillaumeSlides}[2026/11/14 v2.0 Modern Editorial Presentation Class]

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

% Palette chromatique (navy par défaut, forest, sage, vibrant)
\newcommand{\ClasseGuillaumeSlides@palette}{navy}
\DeclareOption{palette=navy}{%
  \renewcommand{\ClasseGuillaumeSlides@palette}{navy}%
  \@expandtwoargs\@removeelement{palette=navy}\@classoptionslist\@classoptionslist
}
\DeclareOption{palette=forest}{%
  \renewcommand{\ClasseGuillaumeSlides@palette}{forest}%
  \@expandtwoargs\@removeelement{palette=forest}\@classoptionslist\@classoptionslist
}
\DeclareOption{palette=sage}{%
  \renewcommand{\ClasseGuillaumeSlides@palette}{sage}%
  \@expandtwoargs\@removeelement{palette=sage}\@classoptionslist\@classoptionslist
}
\DeclareOption{palette=vibrant}{%
  \renewcommand{\ClasseGuillaumeSlides@palette}{vibrant}%
  \@expandtwoargs\@removeelement{palette=vibrant}\@classoptionslist\@classoptionslist
}

% Style visuel global des diapositives (editorial par défaut, organic, minimal)
\newcommand{\ClasseGuillaumeSlides@style}{editorial}
\DeclareOption{style=editorial}{%
  \renewcommand{\ClasseGuillaumeSlides@style}{editorial}%
  \@expandtwoargs\@removeelement{style=editorial}\@classoptionslist\@classoptionslist
}
\DeclareOption{style=organic}{%
  \renewcommand{\ClasseGuillaumeSlides@style}{organic}%
  \@expandtwoargs\@removeelement{style=organic}\@classoptionslist\@classoptionslist
}
\DeclareOption{style=minimal}{%
  \renewcommand{\ClasseGuillaumeSlides@style}{minimal}%
  \@expandtwoargs\@removeelement{style=minimal}\@classoptionslist\@classoptionslist
}

% Modèle de page de titre (diagonal par défaut, organic, framed, editorial)
\newcommand{\ClasseGuillaumeSlides@cover}{diagonal}
\DeclareOption{cover=diagonal}{%
  \renewcommand{\ClasseGuillaumeSlides@cover}{diagonal}%
  \@expandtwoargs\@removeelement{cover=diagonal}\@classoptionslist\@classoptionslist
}
\DeclareOption{cover=organic}{%
  \renewcommand{\ClasseGuillaumeSlides@cover}{organic}%
  \@expandtwoargs\@removeelement{cover=organic}\@classoptionslist\@classoptionslist
}
\DeclareOption{cover=framed}{%
  \renewcommand{\ClasseGuillaumeSlides@cover}{framed}%
  \@expandtwoargs\@removeelement{cover=framed}\@classoptionslist\@classoptionslist
}
\DeclareOption{cover=editorial}{%
  \renewcommand{\ClasseGuillaumeSlides@cover}{editorial}%
  \@expandtwoargs\@removeelement{cover=editorial}\@classoptionslist\@classoptionslist
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

% Position de la barre de progression (none par défaut pour un rendu léger)
\newcommand{\ClasseGuillaumeSlides@progressbar}{none}
\DeclareOption{progressbar=none}{%
  \renewcommand{\ClasseGuillaumeSlides@progressbar}{none}%
  \@expandtwoargs\@removeelement{progressbar=none}\@classoptionslist\@classoptionslist
}
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

% Surtitre de section au-dessus du titre de slide (off par défaut pour alléger)
\newif\ifClasseGuillaumeSlides@eyebrow
\ClasseGuillaumeSlides@eyebrowfalse
\DeclareOption{eyebrow=off}{%
  \ClasseGuillaumeSlides@eyebrowfalse
  \@expandtwoargs\@removeelement{eyebrow=off}\@classoptionslist\@classoptionslist
}
\DeclareOption{eyebrow=on}{%
  \ClasseGuillaumeSlides@eyebrowtrue
  \@expandtwoargs\@removeelement{eyebrow=on}\@classoptionslist\@classoptionslist
}

% Pied de page (minimal par défaut : juste folio discret à droite)
\newcommand{\ClasseGuillaumeSlides@footerstyle}{minimal}
\DeclareOption{footer=minimal}{%
  \renewcommand{\ClasseGuillaumeSlides@footerstyle}{minimal}%
  \@expandtwoargs\@removeelement{footer=minimal}\@classoptionslist\@classoptionslist
}
\DeclareOption{footer=full}{%
  \renewcommand{\ClasseGuillaumeSlides@footerstyle}{full}%
  \@expandtwoargs\@removeelement{footer=full}\@classoptionslist\@classoptionslist
}
\DeclareOption{footer=none}{%
  \renewcommand{\ClasseGuillaumeSlides@footerstyle}{none}%
  \@expandtwoargs\@removeelement{footer=none}\@classoptionslist\@classoptionslist
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
\PassOptionsToPackage{bookmarksopen=true, pdfcreator={LuaLaTeX with Beamer, Moloch and ClasseGuillaumeSlides v2.0}}{hyperref}

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

% --- Socle visuel épuré Moloch ---
\usetheme[progressbar=none, sectionpage=none]{moloch}
\molochset{block=fill}
\usefonttheme{professionalfonts}

% --- Définition des palettes chromatiques ---
% Couleurs de référence invariantes pour diagrammes TikZ (suivent la palette choisie)
\ifdefstring{\ClasseGuillaumeSlides@palette}{forest}{%
  \definecolor{ThesisPrimary}{RGB}{72, 102, 56}%
  \definecolor{ThesisSecondary}{RGB}{55, 140, 122}%
  \definecolor{ThesisAccent}{RGB}{44, 114, 102}%
  \definecolor{ThesisHighlight}{RGB}{198, 134, 62}%
  \definecolor{ThesisText}{RGB}{34, 42, 46}%
  \definecolor{ThesisMuted}{RGB}{96, 108, 114}%
  \definecolor{ThesisBackground}{RGB}{246, 248, 245}%
  \definecolor{ThesisLink}{RGB}{55, 140, 122}%
}{%
  \ifdefstring{\ClasseGuillaumeSlides@palette}{sage}{%
    \definecolor{ThesisPrimary}{RGB}{30, 63, 53}%
    \definecolor{ThesisSecondary}{RGB}{84, 116, 94}%
    \definecolor{ThesisAccent}{RGB}{181, 101, 77}%
    \definecolor{ThesisHighlight}{RGB}{181, 101, 77}%
    \definecolor{ThesisText}{RGB}{30, 48, 42}%
    \definecolor{ThesisMuted}{RGB}{84, 102, 95}%
    \definecolor{ThesisBackground}{RGB}{242, 245, 236}%
    \definecolor{ThesisLink}{RGB}{30, 63, 53}%
  }{%
    \ifdefstring{\ClasseGuillaumeSlides@palette}{vibrant}{%
      \definecolor{ThesisPrimary}{RGB}{43, 113, 185}%
      \definecolor{ThesisSecondary}{RGB}{224, 86, 96}%
      \definecolor{ThesisAccent}{RGB}{214, 128, 36}%
      \definecolor{ThesisHighlight}{RGB}{224, 86, 96}%
      \definecolor{ThesisText}{RGB}{46, 50, 56}%
      \definecolor{ThesisMuted}{RGB}{104, 112, 122}%
      \definecolor{ThesisBackground}{RGB}{246, 248, 252}%
      \definecolor{ThesisLink}{RGB}{43, 113, 185}%
    }{%
      % navy (défaut harmonisé ClasseGuillaume)
      \definecolor{ThesisPrimary}{RGB}{15, 60, 110}%
      \definecolor{ThesisSecondary}{RGB}{20, 110, 120}%
      \definecolor{ThesisAccent}{RGB}{190, 75, 40}%
      \definecolor{ThesisHighlight}{RGB}{190, 75, 40}%
      \definecolor{ThesisText}{RGB}{30, 35, 42}%
      \definecolor{ThesisMuted}{RGB}{95, 105, 118}%
      \definecolor{ThesisBackground}{RGB}{246, 248, 251}%
      \definecolor{ThesisLink}{RGB}{18, 90, 150}%
    }%
  }%
}

% --- Palette adaptative de l'interface (light vs dark) ---
\ifdarktheme
  \ifdefstring{\ClasseGuillaumeSlides@palette}{sage}{%
    \definecolor{SlideBg}{RGB}{20, 29, 25}%
    \definecolor{SlideCardBg}{RGB}{29, 41, 36}%
    \definecolor{SlideCardSurface}{RGB}{29, 41, 36}%
    \definecolor{SlideFg}{RGB}{236, 242, 236}%
    \definecolor{SlideTitleFg}{RGB}{244, 248, 244}%
    \definecolor{SlidePrimary}{RGB}{134, 196, 158}%
    \definecolor{SlideSecondary}{RGB}{164, 208, 178}%
    \definecolor{SlideAccent}{RGB}{228, 136, 108}%
    \definecolor{SlideMuted}{RGB}{156, 174, 164}%
    \definecolor{SlideBorder}{RGB}{52, 72, 62}%
    \definecolor{SlideBarBg}{RGB}{40, 56, 48}%
  }{%
    \definecolor{SlideBg}{RGB}{18, 25, 36}%
    \definecolor{SlideCardBg}{RGB}{28, 38, 52}%
    \definecolor{SlideCardSurface}{RGB}{28, 38, 52}%
    \definecolor{SlideFg}{RGB}{237, 242, 247}%
    \definecolor{SlideTitleFg}{RGB}{245, 248, 252}%
    \ifdefstring{\ClasseGuillaumeSlides@palette}{vibrant}{%
      \definecolor{SlidePrimary}{RGB}{100, 168, 235}%
      \definecolor{SlideSecondary}{RGB}{248, 134, 140}%
      \definecolor{SlideAccent}{RGB}{246, 186, 114}%
    }{%
      \ifdefstring{\ClasseGuillaumeSlides@palette}{forest}{%
        \definecolor{SlidePrimary}{RGB}{126, 184, 102}%
        \definecolor{SlideSecondary}{RGB}{92, 198, 174}%
        \definecolor{SlideAccent}{RGB}{226, 164, 92}%
      }{%
        \definecolor{SlidePrimary}{RGB}{96, 198, 210}%
        \definecolor{SlideSecondary}{RGB}{110, 205, 214}%
        \definecolor{SlideAccent}{RGB}{238, 128, 92}%
      }%
    }%
    \definecolor{SlideMuted}{RGB}{152, 167, 187}%
    \definecolor{SlideBorder}{RGB}{52, 68, 90}%
    \definecolor{SlideBarBg}{RGB}{38, 50, 66}%
  }%
  \colorlet{SlideFillPrimary}{ThesisPrimary}%
  \colorlet{SlideFillSecondary}{ThesisSecondary}%
  \colorlet{SlideFillAccent}{ThesisAccent}%
  \ifdefstring{\ClasseGuillaumeSlides@palette}{forest}{%
    \definecolor{SlideStandoutBg}{RGB}{36, 58, 28}%
  }{%
    \ifdefstring{\ClasseGuillaumeSlides@palette}{sage}{%
      \definecolor{SlideStandoutBg}{RGB}{24, 52, 43}%
    }{%
      \ifdefstring{\ClasseGuillaumeSlides@palette}{vibrant}{%
        \definecolor{SlideStandoutBg}{RGB}{28, 74, 128}%
      }{%
        \definecolor{SlideStandoutBg}{RGB}{15, 48, 86}%
      }%
    }%
  }%
  \definecolor{SlideStandoutFg}{RGB}{255, 255, 255}%
  \definecolor{SlideTextInverted}{RGB}{255, 255, 255}%
\else
  \ifdefstring{\ClasseGuillaumeSlides@palette}{sage}{%
    \definecolor{SlideBg}{RGB}{219, 224, 206}%
    \definecolor{SlideCardBg}{RGB}{234, 238, 225}%
    \definecolor{SlideCardSurface}{RGB}{248, 249, 245}%
    \definecolor{SlideFg}{RGB}{36, 52, 46}%
    \definecolor{SlideTitleFg}{RGB}{24, 56, 46}%
    \definecolor{SlidePrimary}{RGB}{30, 63, 53}%
    \definecolor{SlideSecondary}{RGB}{84, 116, 94}%
    \definecolor{SlideAccent}{RGB}{181, 101, 77}%
    \definecolor{SlideMuted}{RGB}{82, 98, 90}%
    \definecolor{SlideBorder}{RGB}{182, 192, 168}%
    \definecolor{SlideBarBg}{RGB}{198, 206, 184}%
  }{%
    \definecolor{SlideBg}{RGB}{255, 255, 255}%
    \definecolor{SlideCardBg}{RGB}{246, 248, 251}%
    \definecolor{SlideCardSurface}{RGB}{255, 255, 255}%
    \definecolor{SlideFg}{RGB}{40, 46, 54}%
    \colorlet{SlideTitleFg}{ThesisPrimary}%
    \colorlet{SlidePrimary}{ThesisPrimary}%
    \colorlet{SlideSecondary}{ThesisSecondary}%
    \colorlet{SlideAccent}{ThesisAccent}%
    \colorlet{SlideMuted}{ThesisMuted}%
    \definecolor{SlideBorder}{RGB}{214, 222, 232}%
    \definecolor{SlideBarBg}{RGB}{226, 232, 240}%
  }%
  \colorlet{SlideFillPrimary}{SlidePrimary}%
  \colorlet{SlideFillSecondary}{SlideSecondary}%
  \colorlet{SlideFillAccent}{SlideAccent}%
  \colorlet{SlideStandoutBg}{ThesisPrimary}%
  \definecolor{SlideStandoutFg}{RGB}{255, 255, 255}%
  \definecolor{SlideTextInverted}{RGB}{255, 255, 255}%
\fi

% Application aux couleurs Beamer/Moloch
\setbeamercolor{normal text}{fg=SlideFg, bg=SlideBg}
\setbeamercolor{background canvas}{bg=SlideBg}
\setbeamercolor{structure}{fg=SlidePrimary}
\setbeamercolor{alerted text}{fg=SlideAccent}
\setbeamercolor{example text}{fg=SlideSecondary}
\setbeamercolor{frametitle}{fg=SlideTitleFg, bg=}
\setbeamercolor{framesubtitle}{fg=SlideMuted, bg=}
\setbeamercolor{title}{fg=SlideTitleFg}
\setbeamercolor{subtitle}{fg=SlideMuted}
\setbeamercolor{author}{fg=SlideFg}
\setbeamercolor{institute}{fg=SlideMuted}
\setbeamercolor{date}{fg=SlideMuted}
\setbeamercolor{section title}{fg=SlideTitleFg}
\setbeamercolor{subsection title}{fg=SlideMuted}
\setbeamercolor{standout}{fg=SlideStandoutFg, bg=SlideStandoutBg}
\setbeamercolor{progress bar}{fg=SlideAccent, bg=SlideBarBg}
\setbeamercolor{footline}{fg=SlideMuted, bg=}
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
\newcommand{\ClasseGuillaumeSlides@covergraphic}{}
\newif\ifslideslogo
\slideslogofalse

\newcommand{\category}[1]{\renewcommand{\ClasseGuillaumeSlides@category}{#1}}
\newcommand{\event}[1]{\renewcommand{\ClasseGuillaumeSlides@event}{#1}}
\newcommand{\location}[1]{\renewcommand{\ClasseGuillaumeSlides@location}{#1}}
\newcommand{\footertext}[1]{\renewcommand{\ClasseGuillaumeSlides@footer}{#1}}
\newcommand{\covervisual}[1]{\renewcommand{\ClasseGuillaumeSlides@covergraphic}{#1}}
\NewDocumentCommand{\definirLogo}{m O{1.35cm}}{%
  \renewcommand{\ClasseGuillaumeSlides@logo}{#1}%
  \renewcommand{\ClasseGuillaumeSlides@logowidth}{#2}%
}
\newcommand{\afficherLogoSlides}{\slideslogotrue}
\newcommand{\masquerLogoSlides}{\slideslogofalse}

% --- Hiérarchie typographique aérée (proche Keynote / Pitch) ---
\setbeamersize{text margin left=1.05cm, text margin right=1.05cm}
\setbeamertemplate{navigation symbols}{}
\setbeamerfont{title}{size=\fontsize{23}{27}, series=\bfseries, family=\sffamily}
\setbeamerfont{subtitle}{size=\fontsize{11}{15}, series=\normalfont, family=\sffamily}
\setbeamerfont{author}{size=\small, series=\bfseries, family=\sffamily}
\setbeamerfont{institute}{size=\footnotesize, series=\normalfont, family=\sffamily}
\setbeamerfont{date}{size=\footnotesize, series=\normalfont, family=\sffamily}
\setbeamerfont{frametitle}{size=\fontsize{17}{20}, series=\bfseries, family=\sffamily}
\setbeamerfont{framesubtitle}{size=\fontsize{9}{12}, series=\normalfont, family=\sffamily}
\setbeamerfont{section title}{size=\fontsize{20}{24}, series=\bfseries, family=\sffamily}
\setbeamerfont{footline}{size=\scriptsize, family=\sffamily}
\setbeamerfont{caption}{size=\footnotesize, family=\sffamily}
\setbeamerfont{caption name}{size=\footnotesize, series=\bfseries, family=\sffamily}
\setbeamerfont{block title}{size=\small, series=\bfseries, family=\sffamily}
\setbeamerfont{standout}{size=\fontsize{19}{24}, series=\bfseries, family=\sffamily}

% Espacement des listes propre (sans enumitem pour préserver les overlays Beamer)
\setlength{\leftmargini}{1.2em}
\setlength{\leftmarginii}{1.1em}
\setlength{\leftmarginiii}{1.0em}
\setbeamertemplate{bibliography item}{}
\addtobeamertemplate{itemize/enumerate body begin}{}{%
  \setlength{\itemsep}{4pt}%
  \setlength{\parskip}{0pt}%
}

% --- Arrière-plan dynamique par défaut (courbes organiques si style=organic) ---
\newif\ifClasseGuillaumeSlides@suppressdecor
\ClasseGuillaumeSlides@suppressdecorfalse

\setbeamertemplate{background canvas}{%
  \tikzexternaldisable%
  \begin{tikzpicture}[inner sep=0pt, outer sep=0pt]%
    \path[use as bounding box] (0,0) rectangle (\paperwidth,\paperheight);%
    \clip (0,0) rectangle (\paperwidth,\paperheight);%
    \ifbool{moloch@standout}{%
      \fill[SlideStandoutBg] (-1pt,-1pt) rectangle (\paperwidth+1pt,\paperheight+1pt);%
      \fill[SlideFillAccent] (-1pt,\paperheight+1pt) rectangle (\paperwidth+1pt,\paperheight-2.2pt);%
      \fill[SlideFillSecondary!35!SlideStandoutBg]
        (\paperwidth-2.8cm,-1pt) -- (\paperwidth+1pt,-1pt) -- (\paperwidth+1pt,3.6cm) -- cycle;%
    }{%
      \fill[SlideBg] (-1pt,-1pt) rectangle (\paperwidth+1pt,\paperheight+1pt);%
      \ifClasseGuillaumeSlides@suppressdecor\else%
        \ifdefstring{\ClasseGuillaumeSlides@style}{organic}{%
          % Formes douces discrètes dans les coins extrêmes (zéro empiètement contenu)
          \fill[SlidePrimary]
            (\paperwidth-1.9cm,\paperheight)
            .. controls (\paperwidth-1.5cm,\paperheight-0.55cm)
            and (\paperwidth-0.6cm,\paperheight-0.55cm)
            .. (\paperwidth,\paperheight-1.15cm)
            -- (\paperwidth,\paperheight) -- cycle;%
          \fill[SlideAccent!85]
            (0,0)
            -- (0,1.25cm)
            .. controls (0.65cm,1.05cm) and (1.25cm,0.55cm)
            .. (1.45cm,0) -- cycle;%
        }{}%
      \fi%
    }%
  \end{tikzpicture}%
  \tikzexternalenable%
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
      \fill[SlideBarBg] (0,0) rectangle (\paperwidth, 1.4pt);%
      \fill[SlideAccent] (0,0) rectangle (\moloch@progressinheadfoot, 1.4pt);%
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

% Composition vectorielle par défaut pour les pages de titre sans visuel dédié
\newcommand{\ClasseGuillaumeSlides@defaultcoverart}[1]{%
  \tikz[scale=#1]{%
    \foreach \r/\op in {2.1/0.12, 1.6/0.18, 1.1/0.25, 0.62/0.35}{%
      \draw[white, opacity=\op, line width=1.1pt] (0,0) circle (\r);%
    }%
    \foreach \x in {-1.2,-0.6,0,0.6,1.2}{%
      \foreach \y in {-1.2,-0.6,0,0.6,1.2}{%
        \fill[white, opacity=0.22] (\x,\y) circle (1.2pt);%
      }%
    }%
    \draw[white, line width=2pt, rounded corners=8pt, fill=white, fill opacity=0.12]
      (-1.35,-0.88) rectangle (1.35,0.88);%
    \fill[SlideAccent] (-1.02,0.46) rectangle (0.35,0.58);%
    \fill[white, opacity=0.88] (-1.02,0.10) rectangle (0.95,0.25);%
    \fill[white, opacity=0.65] (-1.02,-0.22) rectangle (0.70,-0.09);%
    \fill[white, opacity=0.45] (-1.02,-0.52) rectangle (0.20,-0.40);%
  }%
}

% --- Titre de diapositive épuré et respirant ---
\setbeamertemplate{frametitle}{%
  \nointerlineskip%
  \vskip0.30cm\relax%
  \begin{beamercolorbox}[wd=\paperwidth, leftskip=1.05cm, rightskip=1.05cm]{frametitle}%
    \ifClasseGuillaumeSlides@eyebrow%
      \ifx\insertsectionhead\@empty\else%
        {\fontsize{7}{8.5}\selectfont\bfseries\sffamily\color{SlideSecondary}%
          \MakeUppercase{\insertsectionhead}}%
        \ifslideslogo%
          \hfill\raisebox{-0.2ex}{\ClasseGuillaumeSlides@includelogo{height=0.38cm, keepaspectratio}}%
        \fi%
        \par\vspace*{0.07cm}%
      \fi%
    \else%
      \ifslideslogo%
        \hfill\raisebox{-0.2ex}{\ClasseGuillaumeSlides@includelogo{height=0.38cm, keepaspectratio}}%
        \par\vspace*{0.04cm}%
      \fi%
    \fi%
    \parbox[b]{\textwidth}{%
      \raggedright%
      \usebeamerfont{frametitle}\usebeamercolor[fg]{frametitle}\insertframetitle%
      \ifx\insertframesubtitle\@empty\else%
        \par\vspace*{0.06cm}%
        \usebeamerfont{framesubtitle}\usebeamercolor[fg]{framesubtitle}\insertframesubtitle%
      \fi%
    }\par%
    \vspace*{0.16cm}%
    \ifdefstring{\ClasseGuillaumeSlides@progressbar}{frametitle}{%
      \pgfmathsetlength{\moloch@progressinheadfoot}{%
        \textwidth * min(1, \insertframenumber / max(1, \inserttotalframenumber))%
      }%
      \tikzexternaldisable%
      \noindent\begin{tikzpicture}%
        \fill[SlideBorder] (0,0) rectangle (\textwidth, 0.7pt);%
        \fill[SlideAccent] (0,0) rectangle (\moloch@progressinheadfoot, 1.5pt);%
      \end{tikzpicture}\par%
      \tikzexternalenable%
    }{%
      \ifdefstring{\ClasseGuillaumeSlides@style}{editorial}{%
        \noindent\hbox to \textwidth{{\color{SlidePrimary}\rule{1.2cm}{1.5pt}}{\color{SlideBorder}\leaders\hrule height 0.5pt\hfill}}\par%
      }{}%
    }%
    \vspace*{0.10cm}%
  \end{beamercolorbox}%
}
\setbeamertemplate{frametitle continuation}{\textnormal{\small(\insertcontinuationcountroman)}}

% --- Pied de page minimaliste par défaut ---
\setbeamertemplate{footline}{%
  \ifdefstring{\ClasseGuillaumeSlides@footerstyle}{none}{}{%
    \begin{beamercolorbox}[wd=\paperwidth, leftskip=1.05cm, rightskip=1.05cm]{footline}%
      \usebeamerfont{footline}%
      \ifdefstring{\ClasseGuillaumeSlides@footerstyle}{full}{%
        \textcolor{SlideMuted}{\ClasseGuillaumeSlides@footer}\hfill%
        \textcolor{SlidePrimary}{\textbf{\insertframenumber}}%
        \textcolor{SlideMuted}{\,/\,\inserttotalframenumber}%
      }{%
        \hfill%
        {\fontsize{7}{8}\selectfont\sffamily\color{SlideMuted}%
          \textcolor{SlidePrimary}{\textbf{\insertframenumber}}\,/\,\inserttotalframenumber}%
      }%
      \vspace*{0.16cm}%
    \end{beamercolorbox}%
  }%
  \ifdefstring{\ClasseGuillaumeSlides@progressbar}{foot}{%
    \ClasseGuillaumeSlides@drawprogressbar%
  }{}%
}

% --- Pages de titre modulaires (cover=diagonal | organic | framed | editorial) ---
\newsavebox{\ClasseGuillaumeSlides@coverbox}

\setbeamertemplate{title page}{%
  \ifdefstring{\ClasseGuillaumeSlides@cover}{organic}{%
    % COUVERTURE ORGANIQUE (vagues bicolores + médaillon gauche + titre blanc à droite)
    \sbox{\ClasseGuillaumeSlides@coverbox}{%
      \ifdefempty{\ClasseGuillaumeSlides@covergraphic}{%
        \ClasseGuillaumeSlides@defaultcoverart{1.15}%
      }{%
        \ClasseGuillaumeSlides@covergraphic%
      }%
    }%
    \tikz[remember picture, overlay]{%
      \fill[SlideFillSecondary] ([xshift=-1pt, yshift=-1pt]current page.south west) rectangle ([xshift=1pt, yshift=1pt]current page.north east);%
      \fill[SlideFillPrimary]
        ([xshift=-1pt, yshift=1pt]current page.north west)
        -- ([xshift=3.4cm, yshift=1pt]current page.north west)
        .. controls ([xshift=6.8cm, yshift=-2.8cm]current page.north west)
        and ([xshift=7.8cm, yshift=2.6cm]current page.south west)
        .. ([xshift=8.5cm, yshift=-1pt]current page.south west)
        -- ([xshift=-1pt, yshift=-1pt]current page.south west) -- cycle;%
      \fill[SlideFillAccent!90]
        ([xshift=-1.6cm, yshift=-1pt]current page.south east)
        .. controls ([xshift=-1.2cm, yshift=1.4cm]current page.south east)
        and ([xshift=-0.3cm, yshift=1.4cm]current page.south east)
        .. ([xshift=1pt, yshift=2.1cm]current page.south east)
        -- ([xshift=1pt, yshift=-1pt]current page.south east) -- cycle;%
      \fill[SlideFillAccent!65] ([xshift=4.93cm, yshift=0.06cm]current page.west) circle (2.82cm);%
      \begin{scope}%
        \clip ([xshift=4.65cm, yshift=-0.1cm]current page.west) circle (2.70cm);%
        \fill[SlideStandoutBg] ([xshift=1.65cm, yshift=-3.1cm]current page.west) rectangle ([xshift=7.65cm, yshift=2.9cm]current page.west);%
        \node at ([xshift=4.65cm, yshift=-0.1cm]current page.west) {\usebox{\ClasseGuillaumeSlides@coverbox}};%
      \end{scope}%
    }%
    \begin{minipage}[t][\dimexpr\paperheight-2.15cm\relax][s]{\textwidth}%
      \vspace*{0.55cm}%
      \hspace*{0.49\textwidth}%
      \begin{minipage}[t]{0.49\textwidth}%
        \raggedleft%
        {\fontsize{8}{10}\selectfont\bfseries\sffamily\color{white!85}%
          \MakeUppercase{\ClasseGuillaumeSlides@category}}%
        \par\vspace*{0.28cm}%
        {\usebeamerfont{title}\color{white}\inserttitle\par}%
        \ifx\insertsubtitle\@empty\else%
          \vspace*{0.26cm}%
          {\usebeamerfont{subtitle}\color{white!88}\insertsubtitle\par}%
        \fi%
      \end{minipage}%
      \vfill%
      \raggedleft%
      {\usebeamerfont{author}\color{white}\insertauthor\par}%
      \ifx\insertinstitute\@empty\else%
        {\usebeamerfont{institute}\color{white!85}\insertinstitute\par}%
      \fi%
      {\usebeamerfont{date}\color{white!80}\insertdate%
        \ifdefempty{\ClasseGuillaumeSlides@location}{}{\enspace\textbullet\enspace\ClasseGuillaumeSlides@location}\par}%
      \vspace*{0.25cm}%
    \end{minipage}%
  }{%
    \ifdefstring{\ClasseGuillaumeSlides@cover}{framed}{%
      % COUVERTURE ARCHITECTURALE À CADRE INCLINÉ (façon exemple1)
      \sbox{\ClasseGuillaumeSlides@coverbox}{%
        \ifdefempty{\ClasseGuillaumeSlides@covergraphic}{%
          \ClasseGuillaumeSlides@defaultcoverart{1.10}%
        }{%
          \ClasseGuillaumeSlides@covergraphic%
        }%
      }%
      \tikz[remember picture, overlay]{%
        \fill[SlideBg] (current page.south west) rectangle (current page.north east);%
        \draw[SlidePrimary, line width=1.1pt]
          ([xshift=4.2cm, yshift=-0.85cm]current page.north west)
          -- ([yshift=-0.85cm]current page.north east);%
        \fill[SlideCardSurface]
          ([xshift=3.85cm]current page.north west)
          rectangle ([xshift=4.22cm, yshift=-1.75cm]current page.north west);%
        \draw[SlidePrimary, line width=1.1pt]
          ([yshift=0.72cm]current page.south west)
          -- ([xshift=4.2cm, yshift=0.72cm]current page.south west);%
        \draw[SlidePrimary, line width=1.1pt]
          ([xshift=4.2cm]current page.south west)
          -- ([xshift=4.2cm, yshift=1.45cm]current page.south west);%
        \begin{scope}[shift={([xshift=-3.65cm, yshift=-0.2cm]current page.east)}, rotate=-2.5]%
          \fill[SlideFillPrimary!18] (-2.68,-2.98) rectangle (2.78,2.90);%
          \fill[white] (-2.75,-2.90) rectangle (2.70,2.98);%
          \clip (-2.50,-2.65) rectangle (2.45,2.73);%
          \fill[SlideFillPrimary] (-2.6,-2.7) rectangle (2.6,2.8);%
          \node at (0,0) {\usebox{\ClasseGuillaumeSlides@coverbox}};%
        \end{scope}%
      }%
      \begin{minipage}[t][\dimexpr\paperheight-2.15cm\relax][s]{0.47\textwidth}%
        \vspace*{0.75cm}%
        {\fontsize{8}{10}\selectfont\bfseries\sffamily\color{SlideAccent}%
          \MakeUppercase{\ClasseGuillaumeSlides@category}}%
        \par\vspace*{0.28cm}%
        {\usebeamerfont{title}\usebeamercolor[fg]{title}\raggedright\inserttitle\par}%
        \ifx\insertsubtitle\@empty\else%
          \vspace*{0.28cm}%
          {\usebeamerfont{subtitle}\usebeamercolor[fg]{subtitle}\raggedright\insertsubtitle\par}%
        \fi%
        \vfill%
        {\usebeamerfont{author}\usebeamercolor[fg]{author}\insertauthor\par}%
        \ifx\insertinstitute\@empty\else%
          \vspace*{0.08cm}%
          {\usebeamerfont{institute}\usebeamercolor[fg]{institute}\insertinstitute\par}%
        \fi%
        {\usebeamerfont{date}\usebeamercolor[fg]{date}\insertdate%
          \ifdefempty{\ClasseGuillaumeSlides@location}{}{\enspace\textbullet\enspace\ClasseGuillaumeSlides@location}\par}%
        \vspace*{0.95cm}%
      \end{minipage}%
    }{%
      \ifdefstring{\ClasseGuillaumeSlides@cover}{diagonal}{%
        % COUVERTURE GÉOMÉTRIQUE DIAGONALE MODERNE (défaut, façon exemple2)
        \sbox{\ClasseGuillaumeSlides@coverbox}{%
          \ifdefempty{\ClasseGuillaumeSlides@covergraphic}{%
            \ClasseGuillaumeSlides@defaultcoverart{1.50}%
          }{%
            \ClasseGuillaumeSlides@covergraphic%
          }%
        }%
        \tikz[remember picture, overlay]{%
          % Accent triangle haut gauche
          \fill[SlideFillSecondary]
            (current page.north west)
            -- ([xshift=1.4cm]current page.north west)
            -- ([yshift=-2.3cm]current page.north west) -- cycle;%
          % Panneau droit découpé en diagonale
          \begin{scope}%
            \clip ([xshift=-5.1cm]current page.north east)
              -- (current page.north east)
              -- (current page.south east)
              -- ([xshift=-9.0cm]current page.south east) -- cycle;%
            \fill[SlideFillPrimary] (current page.south west) rectangle (current page.north east);%
            \node at ([xshift=-3.6cm]current page.east) {\usebox{\ClasseGuillaumeSlides@coverbox}};%
          \end{scope}%
          % Ruban diagonal d'accentuation parallèlement à la coupe (pleine hauteur)
          \fill[SlideFillAccent]
            ([xshift=-5.1cm]current page.north east)
            -- ([xshift=-4.45cm]current page.north east)
            -- ([xshift=-8.35cm]current page.south east)
            -- ([xshift=-9.0cm]current page.south east) -- cycle;%
          % Triangle secondaire en coin bas droit
          \fill[SlideFillSecondary]
            ([xshift=-2.1cm]current page.south east)
            -- (current page.south east)
            -- ([yshift=3.2cm]current page.south east) -- cycle;%
        }%
        \begin{minipage}[t][\dimexpr\paperheight-2.15cm\relax][s]{0.50\textwidth}%
          \vspace*{0.45cm}%
          {\fontsize{8}{10}\selectfont\bfseries\sffamily\color{SlideAccent}%
            \MakeUppercase{\ClasseGuillaumeSlides@category}}%
          \ifdefempty{\ClasseGuillaumeSlides@event}{}{%
            \enspace\textcolor{SlideBorder}{|}\enspace%
            {\fontsize{8}{10}\selectfont\sffamily\color{SlideSecondary}\ClasseGuillaumeSlides@event}%
          }%
          \par\vspace*{0.28cm}%
          {\usebeamerfont{title}\usebeamercolor[fg]{title}\raggedright\inserttitle\par}%
          \ifx\insertsubtitle\@empty\else%
            \vspace*{0.28cm}%
            {\usebeamerfont{subtitle}\usebeamercolor[fg]{subtitle}\raggedright\insertsubtitle\par}%
          \fi%
          \vfill%
          {\usebeamerfont{author}\usebeamercolor[fg]{author}\insertauthor\par}%
          \ifx\insertinstitute\@empty\else%
            \vspace*{0.08cm}%
            {\usebeamerfont{institute}\usebeamercolor[fg]{institute}\insertinstitute\par}%
          \fi%
          {\usebeamerfont{date}\usebeamercolor[fg]{date}\insertdate%
            \ifdefempty{\ClasseGuillaumeSlides@location}{}{\enspace\textbullet\enspace\ClasseGuillaumeSlides@location}\par}%
          \vspace*{0.25cm}%
        \end{minipage}%
      }{%
        % COUVERTURE ÉDITORIALE SOBRE (cover=editorial)
        \tikz[remember picture, overlay]{%
          \fill[ThesisPrimary] (current page.north west) rectangle ([xshift=0.38cm]current page.south west);%
          \fill[SlideAccent] ([xshift=0.38cm]current page.north west) rectangle ([xshift=0.50cm]current page.south west);%
          \ifdarktheme\else%
            \fill[SlideCardBg] ([xshift=0.50cm]current page.south west) rectangle ([yshift=2.35cm]current page.south east);%
          \fi%
        }%
        \begin{minipage}[t][\dimexpr\paperheight-2.15cm\relax][s]{\textwidth}%
          \vspace*{0.15cm}%
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
              {\usebeamerfont{date}\usebeamercolor[fg]{date}\insertdate%
                \ifdefempty{\ClasseGuillaumeSlides@location}{}{\enspace\textbullet\enspace\ClasseGuillaumeSlides@location}\par}%
            \end{column}%
            \begin{column}{0.26\textwidth}%
              \raggedleft%
              \ClasseGuillaumeSlides@includelogo{width=\ClasseGuillaumeSlides@logowidth, height=1.25cm, keepaspectratio}%
            \end{column}%
          \end{columns}%
          \vspace*{0.20cm}%
        \end{minipage}%
      }%
    }%
  }%
}

\def\maketitle{%
  \ifbeamer@inframe%
    \titlepage%
  \else%
    \frame[plain,noframenumbering]{\titlepage}%
  \fi%
}

% --- Diapositive de section éditoriale graphique ---
\setbeamertemplate{section page}{%
  \tikz[remember picture, overlay]{%
    \fill[SlideFillPrimary] ([xshift=-1pt, yshift=1pt]current page.north west) rectangle ([xshift=4.6cm, yshift=-1pt]current page.south west);%
    \fill[SlideFillAccent] ([xshift=4.6cm, yshift=1pt]current page.north west) rectangle ([xshift=4.74cm, yshift=-1pt]current page.south west);%
    \node[anchor=center] at ([xshift=2.3cm]current page.west) {%
      {\fontsize{54}{56}\selectfont\bfseries\sffamily\color{white}%
        \ifnum\value{section}<10 0\fi\thesection}%
    };%
  }%
  \hspace*{4.2cm}%
  \begin{minipage}[c]{0.66\textwidth}%
    \raggedright%
    {\fontsize{8.5}{10}\selectfont\bfseries\sffamily\color{SlideSecondary}%
      \MakeUppercase{\ClasseGuillaumeSlides@sectiontag}}%
    \par\vspace*{0.22cm}%
    {\usebeamerfont{section title}\usebeamercolor[fg]{section title}\insertsectionhead\par}%
    \vspace*{0.36cm}%
    \hbox to 0.45\linewidth{{\color{SlideAccent}\rule{1.6cm}{2.2pt}}{\color{SlideBorder}\leaders\hrule height 0.7pt\hfill}}%
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
