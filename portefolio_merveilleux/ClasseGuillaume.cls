%----------------------------------------------------------------------------------
%	INITIALISATION DE LA CLASSE
%----------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\newcommand{\classname}{ClasseGuillaume}
\ProvidesClass{\classname}[2017/08/27 v1.6 LaTeXTemplates.com]
\providecommand{\baseclass}{scrbook}
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{scrhack}     % Corrige les conflits avec hyperref, listings, etc.
%\RequirePackage{scrlfile}    % Permet de manipuler le chargement des fichiers

\newif\ifusetodos
\usetodosfalse
\DeclareOption{todoNote}{\usetodostrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\ProcessOptions\relax
\LoadClass{\baseclass}

% --- DÉFINITION DE COMMANDES D'ACCÈS AUX MÉTADONNÉES ---
\newcommand{\thetitle}{\@title}
\newcommand{\theauthor}{\@author}
\newcommand{\thedate}{\@date}

\RequirePackage{comment}  % Pour commenter le code sur plusieurs lignes
\RequirePackage{lipsum}   % Pour générer du texte pour la mise en forme
%\usepackage{showframe}    % Pour voir la géométrie de la feuille

%----------------------------------------------------------------------------------
%	CORRECTEUR ET CARACTERES (LANGUE, MATH ET SCIENCE)
%----------------------------------------------------------------------------------
\RequirePackage{babel}
\frenchbsetup{StandardLists=true}
%\selectlanguage{french}
%\selectlanguage{english}

\RequirePackage{amsmath}        % La base pour les mathématiques avancées

\RequirePackage{siunitx}        % Pour écrire correctement les nombres et les unités.
\sisetup{
    locale = FR,                % Active automatiquement la virgule et l'espace fin entre milliers
    mode = match,               % Adapte la police (gras, italique, sans-serif) au texte autour
    propagate-math-font = true, % Si utilisé dans des maths, prend la font math
    reset-math-version = false, 
    reset-text-family = false,
    reset-text-series = false,
    reset-text-shape = false,
    per-mode = symbol,          % Affiche m/s (alternative : 'fraction' pour m sur s)
    range-phrase = --,          % Tiret moyen pour les plages (ex: 10–20)
    range-units = single,       % 10–20 km (au lieu de 10 km – 20 km)
}

%----------------------------------------------------------------------------------
%	POLICES (LITTERAIRE ET MATHEMATIQUE)
%----------------------------------------------------------------------------------
% Littérature
\RequirePackage{fontspec}
\RequirePackage{lua-ul}         % Pour appliquer la césure au soulignement

% Définition de la police principale (Le texte courant)
\setmainfont{ComicSansMS}[
    Path = ./Fonts/ComicSansMSFontFiles/,
    Extension = .ttf,
    UprightFont = ComicSansMS,
    BoldFont = ComicSansMS-Bold,
    ItalicFont = ComicSansMS-Italic,
    BoldItalicFont = ComicSansMS-BoldItalic
]
% Définition de la police Sans Serif (souvent les titres)
\setsansfont{Calibri}[
    Path=./Fonts/CalibriFontFiles/,
    Scale=1,
    Extension = .ttf,
    UprightFont=calibri-regular,
    BoldFont=calibri-bold,
    ItalicFont=calibri-italic,
    BoldItalicFont=calibri-bold-italic
    ]
    

%\setmainfont{Caladea}
%\setsansfont{Carlito}
%\setmonofont{Consolas}
\renewcommand{\familydefault}{\sfdefault}

\newfontfamily{\AsapFont}{Asap}[
    Path=./Fonts/AsapFontFiles/,
    Scale=1,
    Extension = .ttf,
    UprightFont=Asap-Condensed-Regular,
    BoldFont=Asap-Condensed-Bold,
    ItalicFont=Asap-Condensed-Italic,
    BoldItalicFont=Asap-Condensed-BoldItalic
    ]
\newfontfamily{\CalibriFont}{Calibri}[
    Path=./Fonts/CalibriFontFiles/,
    Scale=1,
    Extension = .ttf,
    UprightFont=calibri-regular,
    BoldFont=calibri-bold,
    ItalicFont=calibri-italic,
    BoldItalicFont=calibri-bold-italic
    ]
\newfontfamily{\ComicSansMSFont}{ComicSansMS}[
    Path=./Fonts/ComicSansMSFontFiles/,
    Scale=1,
    Extension = .ttf,
    UprightFont=ComicSansMS,
    BoldFont=ComicSansMS-Bold,
    ItalicFont=ComicSansMS-Italic,
    BoldItalicFont=ComicSansMS-BoldItalic
    ]

% Mathématique
\RequirePackage{unicode-math}

\setmathfont{XITS Math}[Scale=MatchLowercase]
%\setmathfont{XITS Math}[range={\heartsuit, \clubsuit}, Scale=MatchLowercase]

%----------------------------------------------------------------------------------
%	COULEUR
%----------------------------------------------------------------------------------
\RequirePackage[table,xcdraw,dvipsnames]{xcolor} % Gestion avancée des couleurs.
% Options de chargement :
% table : Permet de colorer les cellules, lignes et colonnes des tableaux.
% xcdraw : Fournit une palette de couleurs étendue.
% dvipsnames : Donne accès à des noms de couleurs classiques (Red, Green, Blue, etc.).
% svgnames : Donne accès à encore plus de noms de couleurs (LightBlue, ForestGreen, etc.).
\colorlet{mdtRed}{red!50!black}

%----------------------------------------------------------------------------------
%	MISE EN PAGE ET TYPOGRAPHIE
%----------------------------------------------------------------------------------

% GEOMETRIE AVEC typearea de KOMA (AUTOMATIQUEMENT DIMENSIONNEE)

\KOMAoptions{%
    usegeometry=true,
    fontsize=11pt,              % Taille de la police de base
    paper=a4,                   % Type de papier
    twoside=false,              % Mode recto-verso
    twocolumn=false,            % Mode 2 colonnes
    BCOR=0cm,                   % Décalage pour reliure
    DIV=12,                      % Réglage des marges
    %headheight=30pt,           % Épaisseur de l'en-tête
    %headinclude=false,         % Inclut l'en-tête dans la zone de texte
    %footinclude=false          % Inclut le pied dans la zone de texte
}
\recalctypearea
% Pour les réglages très précis de LaTeX (non gérés par des clés KOMA)
%\setlength{\headsep}{20pt}
%\setlength{\footskip}{20pt}
%\setlength{\footnotesep}{10pt}
%\setlength{\marginparwidth}{3cm}
%\setlength{\marginparsep}{1mm}

%\areaset[0cm]{16cm}{26cm}

\RequirePackage[pass]{geometry}

\newcommand{\geometrieStandard}{%
    \cleardoublepage%
    \restoregeometry
}

\newcommand{\geometrieWord}{%
    \cleardoublepage%
    \newgeometry{%
        left=2.5cm, right=2.5cm,
        top=2.5cm, bottom=2.5cm,
        headheight=1cm, headsep=5mm,
        footskip=1cm, footnotesep = 5mm,
        marginparwidth=2cm, marginparsep=3mm,
        twoside=false, bindingoffset=0cm, twocolumn=false
        % includefoot, includehead,
        % showframe, a4paper
    }
}

\newcommand{\geometrieLarge}{%
    \cleardoublepage%
    \newgeometry{%
        left=1cm, right=1cm,
        top=1cm, bottom=1cm,
        headheight=22pt, headsep=5pt,
        footskip=22pt, footnotesep=5pt,
        marginparwidth=0mm, marginparsep=0mm,
        twoside=false, bindingoffset=0cm, twocolumn=false
        % includefoot, includehead,
        % showframe, a4paper
    }
}

% INTERLIGNES ET INTER-PARAGRAPHE

\KOMAoptions{
    parskip=half        % Espace entre paragraphes (half, full, false)
}

\RequirePackage{setspace} % Permet de contrôler l'interligne via les commandes \singlespacing, \onehalfspacing, \doublespacing.
\doublespacing

\raggedbottom

%----------------------------------------------------------------------------------
%	ENTETE ET PIED DE PAGE
%----------------------------------------------------------------------------------
\RequirePackage[
  automark,             % Récupère auto les titres (Chapitre/Section)
  headsepline=0.5pt,    % Ligne de séparation sous l'en-tête (épaisseur)
  footsepline=false,    % Pas de ligne au pied de page
  markcase=used         % Garde la casse du titre (pas de MAJUSCULES forcées)
]{scrlayer-scrpage}

\RequirePackage{lastpage} % Pour avoir le total des pages
\RequirePackage{calc}     % Pour des calculs de longueurs si besoin

\clearpairofpagestyles

\setkomafont{pagehead}{\normalfont\sffamily\itshape\color{gray}}
\setkomafont{pagenumber}{\normalfont\sffamily\bfseries}

\ohead[\pagemark]{\pagemark} 
\ihead[]{\headmark} 
\cfoot[]{} 

\newpairofpagestyles{StyleFocus}{
  \clearpairofpagestyles
  \KOMAoptions{headsepline=false}
  \chead{-- \headmark --}
  \cfoot[\pagemark]{\pagemark}
}

\newpairofpagestyles{StyleTest}{
  \clearpairofpagestyles % On part d'une feuille blanche pour ce style
  % --- 1. Réglages spécifiques à ce style (écrasent les globaux) ---
  \KOMAoptions{
    headsepline=1mm,      % Ligne très épaisse pour voir l'écartement
    footsepline=0.5mm,    % Ligne de pied visible
    markcase=used         % Garde la casse originale
  }
  % --- 2. Polices "Flashy" pour le debug ---
  % On force les polices directement ici pour ne pas toucher aux \setkomafont globaux
  \def\TestFontHead{\normalfont\sffamily\small\color{blue}}
  \def\TestFontFoot{\normalfont\ttfamily\footnotesize\color{red!70!black}}
  % --- 3. Configuration des marqueurs pour le test ---
  \automark[section]{chapter} % Maintenir la logique Chapitre/Section
  % --- 4. EN-TÊTE (HEADER) ---
  % GAUCHE (Pair : Page / Impair : Chapitre)
  \lehead[\fcolorbox{red}{white}{\textbf{\thepage}}]{\fcolorbox{red}{white}{\textbf{\thepage}}}
  \lohead[]{\TestFontHead \leftmark} 
  % CENTRE (Indicateur de mode)
  \chead[]{\fcolorbox{orange}{yellow}{\tiny \sffamily MODE DEBUG}}
  % DROITE (Pair : Section / Impair : Page)
  \rehead[]{\TestFontHead \rightmark}
  \rohead[\fcolorbox{red}{white}{\textbf{\thepage}}]{\fcolorbox{red}{white}{\textbf{\thepage}}}
  % --- 5. PIED DE PAGE (FOOTER) ---
  % GAUCHE : Affiche le nom du fichier courant
  \lefoot[]{\TestFontFoot \jobname.tex}
  \lofoot[]{\TestFontFoot \jobname.tex}
  % CENTRE : Règle graduée simulée (pour vérifier le centrage)
  \cfoot[]{\color{gray!50}|--- CENTRE ---|}
  % DROITE : Pagination détaillée (Page X sur Total)
  \refoot[]{\TestFontFoot p.\thepage/\pageref{LastPage}}
  \rofoot[]{\TestFontFoot p.\thepage/\pageref{LastPage}}
}

\pagestyle{scrheadings}

% --- SETUP NOTES DE BAS DE PAGE ---
%\deffootnote[2em]{2em}{1em}{\textsuperscript{\thefootnotemark}\enskip}
%\setlength{\footnotesep}{1.5ex}   % Un peu d'air entre les notes
%\addtokomafont{footnote}{\footnotesize} % Taille légèrement réduite
%----------------------------------------------------------------------------------
%	CONFIGURATION DES TITRES DE CHAPITRES ET SECTIONS
%----------------------------------------------------------------------------------
\setcounter{secnumdepth}{3}

% Police des sections
\addtokomafont{disposition}{\bfseries\AsapFont\color{mdtRed}}

% Personnalisation des chapitres
\KOMAoptions{chapterprefix=true}
\renewcommand*{\raggedchapter}{\centering}
\RedeclareSectionCommand[
    font={\Huge\AsapFont\color{mdtRed}},
    beforeskip=-2cm,  % Espace AVANT (négatif = pas d'indentation du 1er paragraphe qui suit)
    afterskip=1cm,    % Espace APRÈS le titre
    innerskip=0.5em    % Espace entre le numéro et le texte
]{chapter}

\addtokomafont{section}{\setstretch{1}\selectfont}
\addtokomafont{subsection}{\setstretch{1}\selectfont}
\addtokomafont{subsubsection}{\setstretch{1}\selectfont}

% 3. Redéfinition des espacements
% J'ai augmenté les valeurs pour qu'elles soient visibles par rapport au double interligne
\RedeclareSectionCommand[
    % beforeskip : on met une valeur plus grande (ex: -1.5 interlignes)
    % Le 'minus' sert toujours à supprimer l'indentation du paragraphe suivant beforeskip=-30pt, 
    % afterskip : 5pt est trop petit face au double interligne. 
    % Essayons 20pt ou une valeur relative comme 1.5ex afterskip=20pt 
]{section}

\RedeclareSectionCommands[
  beforeskip=-15pt,
  afterskip=10pt
]{subsection, subsubsection}

% --- Personnalisation des paragraphes (\paragraph) ---
\RedeclareSectionCommand[
    indent=5mm,      % Décale le titre vers la droite (indentation)
    %beforeskip=-12pt,  % Espace AVANT le paragraphe
    afterskip=-1em,    % Espace APRÈS négatif = le texte suit sur la même ligne
    font={\color{black}\bfseries\textbullet~} % Ajoute la puce (bullet) devant
]{paragraph}

% --- Numérotation personnalisée ---
\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}

%----------------------------------------------------------------------------------
%	TABLE DES MATIERES, LISTE FIGURES, LISTE TABLEAUX, AJOUT BIBLIO A TDM
%----------------------------------------------------------------------------------
\KOMAoptions{
    % --- Éléments à inclure ---
    toc=listof,                 % Ajoute les listes (figures, tableaux) à la TdM
    toc=index,                  % Ajoute l'index à la TdM
    toc=bibliography,           % Ajoute la biblio à la TdM
    listof=totoc,               % Ajoute les listes dans la TdM
    appendixprefix=true,        %
    % --- Apparence ---
    %toc=bibliographynumbered   % Numéroter la bibliographie
    %toc=flat,                  % Format aligné à gauche
    % toc=chapterentrywithdots, % (Optionnel) Ajoute des points (...) même pour les chapitres
    listof=entryprefix,          % (Optionnel) Ajoute "Fig." ou "Tab." devant les numéros dans la liste
    numbers=noenddot            % pas de "." à la fin des suite de chiffre de section.
}

\BeforeStartingTOC{\singlespacing}

%----------------------------------------------------------------------------------
%   TYPOGRAPHIE AVANCÉE & PÉNALITÉS
%----------------------------------------------------------------------------------
% 1. MICROTYPE : La baguette magique de la justification
% Améliore le gris typographique et réduit le besoin de césures.
\RequirePackage{microtype} 

% 2. GESTION DES VEUVES ET ORPHELINES (Lignes isolées)
% On demande à LaTeX de faire tout son possible pour les éviter (valeur 10000 = interdit).
% Note : KOMA-Script n'a pas d'option dédiée qui remplace ceci, c'est donc la bonne méthode.
\clubpenalty=10000          % Pas de ligne seule en bas de page (Orpheline)
\widowpenalty=10000         % Pas de ligne seule en haut de page (Veuve)
\displaywidowpenalty=10000  % Pas de ligne seule avant une formule mathématique

% 3. CÉSURES (HYPHENATION)
% On NE TOUCHE PAS à \hyphenpenalty ni \tolerance (laissez LaTeX gérer).
% Par contre, on évite les situations moches :
\doublehyphendemerits=10000 % Interdit deux lignes consécutives finissant par un tiret (-)
\brokenpenalty=10000        % Interdit la coupure d'un mot si c'est entre deux pages

% 4. NOTES DE BAS DE PAGE
% On évite de les couper, mais on n'interdit pas totalement (9999 au lieu de 10000)
% au cas où une note serait vraiment gigantesque.
\interfootnotelinepenalty=9999

%----------------------------------------------------------------------------------
%   FIGURES, TABLEAUX, FLOTTANTS ET LISTES
%----------------------------------------------------------------------------------
\RequirePackage{adjustbox}      % Outils pour redimensionner/rogner
\RequirePackage{tcolorbox}      % pour faire de jolis cadres
\RequirePackage{rotating}       % Pour les figures tournées (sidewaysfigure)
\RequirePackage{float}          % Pour l'option [H] (Placez-le ICI impérativement)
\RequirePackage{tocbasic}       % Equivalent de float pour KOMA
\DeclareNewTOC[%
  type=illustration,
  float,
  name=Illustration,
  listname={Liste des illustrations},
]{loi}

% --- Tableaux ---
\RequirePackage{array}          % Améliore les colonnes standards
\RequirePackage{booktabs}       % Lignes professionnelles (\toprule, \midrule)
\RequirePackage{longtable}      % Tableaux sur plusieurs pages
\RequirePackage{tabularx}       % Tableaux à largeur fixe (ex: largeur du texte)
\RequirePackage{multirow}       % Fusion verticale de cellules

% --- Images ---
\RequirePackage{graphicx}
% Note : Dans une classe, le chemin est relatif au fichier .tex qui l'utilise, pas au .cls
\graphicspath{{images/}{./}}
\RequirePackage{pdfpages}

% --- Légendes (Captions) ---
% KOMA-Script : On prévient que les légendes de tableaux sont au-dessus
\KOMAoptions{captions=tableheading} 

% Package Caption (Prend le dessus sur KOMA pour plus de flexibilité avec subcaption)
\RequirePackage{caption}
\captionsetup{
    format = hang,              % Classique
    justification = centerlast, % Esthétique : la dernière ligne est centrée
    singlelinecheck = true,     % Centre si ça tient sur une ligne
    font = {small, sf},         % Police un peu plus petite et Sans-Serif
    % labelfont = sc,           % ATTENTION à la police utilisée
    labelfont = {bf, sf},       % Alternative sûre : Gras et Sans-Serif
    labelsep = period,          % Point après le numéro
    margin = {1cm, 1cm},        % Marge interne pour que la légende ne touche pas les bords
    skip = 10pt                 % Espace vertical un peu plus généreux entre l'image et la légende
}

\captionsetup[table]{
    position = above,           % Dit au package : "Pour les tables, l'espace 'skip' doit être APRÈS la légende"
}

% Sous-figures (a, b, c...)
\RequirePackage{subcaption}
\captionsetup[sub]{
    labelfont={bf, sf},
    labelformat=simple,         % a, b, c...
    justification=centering
}
% Petite astuce pour avoir "(a)" dans le texte quand on fait \ref{}, mais "a" sous l'image
\renewcommand\thesubfigure{(\alph{subfigure})}

\RequirePackage{enumitem}
\setlist{
    %before=\singlespacing, % 1. Force l'interligne simple DANS la liste
    %listparindent=\parindent, % (Optionnel) Garde l'indentation des paragraphes
    %parsep=0pt,            % (Optionnel) Pas d'espace entre les paragraphes d'un item
    noitemsep
}
% --- Options de configuration pour enumitem (via \setlist) ---
% \setlist[enumerate,1]{label=\arabic*.}        % Change le style du premier niveau des listes numérotées.
% \setlist[itemize]{leftmargin=*}               % Aligne les listes à puces sur la marge du paragraphe.
% \setlist{nosep}                               % Supprime tout espacement vertical dans les listes.

%----------------------------------------------------------------------------------
%   GUILLEMETS ET CITATIONS
%----------------------------------------------------------------------------------
\RequirePackage[
    autostyle=true,    % S'adapte à la langue courante (babel)
    style=french       % Guillemets français par défaut
]{csquotes}

%----------------------------------------------------------------------------------
%   BIBLIOGRAPHIE
%----------------------------------------------------------------------------------
% 1. On sauvegarde votre vraie commande (celle de la classe) dans une copie
\let\oldtheauthor\theauthor

% 2. On "efface" temporairement la commande. 
% Ainsi, quand biblatex va s'installer, il ne verra pas de conflit !
\let\theauthor\relax

% 3. On charge biblatex normalement avec vos options
\RequirePackage[
    backend=biber,     % Le moteur moderne
    style=vancouver,   % Auteur-Année (APA 7th ed). Si tu veux des numéros [1], mets 'numeric'.
    %sorting=nyt,      % Inutile avec style=apa (qui gère son propre tri strict)
    url=true,          % (Optionnel) Affiche ou non les URL dans la biblio
    urldate=long,      % (Optionnel) Force le format "17 février 2026"
    doi=true,          % (Optionnel) Affiche les DOI (recommandé scientifique)
    hyperref=true,     % <--- AJOUTER CECI : Force la création des liens
    backref=true       % (Optionnel) Ajoute "cité page X" dans la bibliographie
]{biblatex}

\addbibresource{bibliographie.bib}

% 4. On remet en place votre vraie commande pour que votre page de garde fonctionne
\let\theauthor\oldtheauthor

% Si et seulement si on utilise la style vancouver :
% 1. On définit nos traductions proprement
\DefineBibliographyStrings{french}{
  urlseen = {consulté le},
  urlfrom = {disponible sur}, % Pour traduire "Available from:"
}

% 2. On écrase le formatage anglais codé en dur par le style Vancouver
\DeclareFieldFormat{urldate}{\mkbibbrackets{\bibstring{urlseen}\space#1}}
\DeclareFieldFormat{url}{\bibstring{urlfrom}\addcolon\space\url{#1}}

% 3. On demande à Vancouver d'afficher ces nouvelles versions
\renewbibmacro*{url+urldate}{%
  \usebibmacro{urldate}%
  \setunit{\adddot\space}%
  \usebibmacro{url}%
}

%----------------------------------------------------------------------------------
%	NOTES TODO COLOREES
%----------------------------------------------------------------------------------

\ifusetodos
  \RequirePackage[colorinlistoftodos]{todonotes}
\else
  \RequirePackage[colorinlistoftodos, disable]{todonotes}
\fi

\setuptodonotes{size=\tiny, color=red!30}
\RequirePackage{soul}

\RequirePackage{pdfcomment} % Pour générer l'info-bulle au survol
\RequirePackage{xstring}    % Pour couper automatiquement le texte du commentaire

\makeatletter
\newcommand{\todoH}[4]{%
    \if@todonotes@disabled
        #4%
    \else
        % On "gèle" le commentaire (#3) et on cherche s'il contient un anti-slash "\"
        \IfSubStr{\detokenize{#3}}{\@backslashchar}{%
            % ==========================================
            % CAS 1 : UNE COMMANDE EST DÉTECTÉE (\url, etc.)
            % ==========================================
            % On ne coupe pas ! On affiche le tout normalement.
            % (xurl s'occupera de couper l'URL proprement dans la marge)
            \todo[#1,color=#2]{#3}%
        }{%
            % ==========================================
            % CAS 2 : C'EST DU TEXTE NORMAL
            % ==========================================
            % On peut couper sans danger et faire l'info-bulle
            \StrLeft{#3}{30}[\apercu]%
            \todo[#1,color=#2]{\pdftooltip{\apercu...}{#3}}%
        }%
        %
        % On surligne le texte dans le document
        \sethlcolor{#2}%
        \hyperref[table_todos]{\hl{#4}}%
    \fi
}
\makeatother

\todostyle{BlancStyle}{}
\todostyle{TestStyle}{author=test}
\todostyle{GuillaumeStyle}{author=Guillaume}
\todostyle{FloraStyle}{}

%----------------------------------------------------------------------------------
%   CONFIGURATION DES HYPERLIENS ET DES MÉTA-DONNÉES PDF (via hyperref)
%----------------------------------------------------------------------------------
% PAS ICI : On utilise \AtEndPreamble pour s'assurer que 'hyperref' est le DERNIER package chargé.
% C'est une recommandation cruciale pour éviter les conflits, car il doit redéfinir
% de nombreuses commandes d'autres packages.
\RequirePackage{xurl}

\RequirePackage{hyperref}
\hypersetup{%
    % --- COMPORTEMENT GÉNÉRAL DU PDF ---
    pdfcreator = GW,
    pdfsubject = {portefolio},                     % Sujet du document.
    pdfkeywords = {portefolio},                    % Mots-clés.
    pdflang = {fr-FR},                             % Langue du document (accessibilité).
    pdfdisplaydoctitle = true,                     % Affiche le titre dans la barre de la fenêtre au lieu du nom de fichier.
    pdfstartview = {FitH},               % Vue au démarrage : 'FitV' ajuste la page verticalement.
    pdfpagemode = {UseOutlines},         % Affiche le panneau des signets (table des matières) à l'ouverture.
    %
    % --- GESTION DES SIGNETS (BOOKMARKS) ---
    bookmarksopen = true,                % Développe les niveaux de signets.
    bookmarksopenlevel = 1,              % Développe les signets jusqu'au niveau 1 (chapitres).
    hypertexnames = true,               % Simplifie les noms de liens internes pour éviter les erreurs.
    plainpages = false,                 % <--- Ajoutez ceci pour gérer Roman vs Arabic
    %
    % --- APPARENCE DES LIENS ---
    hidelinks,
    colorlinks = false,                  % colore le texte des liens.
    linkcolor = black,                   % Couleur pour les liens internes
    citecolor = magenta,                 % Couleur pour les citations
    urlcolor = mdtRed,                   % Couleur pour les liens externes
    %
    % --- OPTIONS TECHNIQUES ---
    unicode,                             % Permet les caractères Unicode dans les signets PDF.
    breaklinks = true                   % Permet aux longs liens (URL) de se couper et de passer à la ligne.
}

% 2. On récupère le titre et l'auteur de façon sécurisée
\makeatletter
\AtBeginDocument{
    \hypersetup{
        pdftitle = {\@title},
        pdfauthor = {\@author}
    }
}
\makeatother

\pdfstringdefDisableCommands{\let\\\space}

\RequirePackage{cleveref}


\endinput