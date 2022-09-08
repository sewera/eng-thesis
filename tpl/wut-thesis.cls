%%-------------------------------------------------%%
%%  Engineer's & Master's Thesis Template          %%
%%  Copyleft by Artur M. Brodzki & Piotr Woźniak   %%
%%  Improvements and refactoring by Błażej Sewera  %%
%%  Warsaw University of Technology, 2019-2022     %%
%%-------------------------------------------------%%

\ProvidesClass{tpl/wut-thesis}

\LoadClass[
    12pt,
    twoside
]{mwart}

%----------------------------
% Document class parameters
%----------------------------
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
    family=wut/wut-thesis.cls,
    prefix=wut
}
\DeclareStringOption[5mm]{bindingoffset}
\DeclareStringOption[4mm]{footnoteindent}
\DeclareBoolOption[true]{hyphenation}
\ProcessKeyvalOptions*
% Hyphenation
\ifwuthyphenation
\else
    \tolerance=1
    \emergencystretch=\maxdimen
    \hyphenpenalty=10000
    \hbadness=10000
\fi

%---------------------
% Basic dependencies
%---------------------
\RequirePackage{acronym}
\RequirePackage{amsmath}       % Basic mathematical typesetting
\RequirePackage{amssymb}       % Advanced math symbols
\RequirePackage{amsthm}        % Theorems typesetting
\RequirePackage{array}         % Advanced table column formats
\RequirePackage{enumitem}      % Itemize/enumrate
\RequirePackage{fancyhdr}      % Custom header/footer styles
\RequirePackage{lmodern}
\RequirePackage{tgschola}      % TeX Gyre Schola font (Serif, document default), family name: 'qcs'
\RequirePackage{tgheros}       % TeX Gyre Heros font (Sans-serif),               family name: 'qhv'
\RequirePackage[T1]{fontenc}
\RequirePackage{graphicx}      % Enhanced images support
\RequirePackage{longtable}     % Multi-page tables
\RequirePackage{multirow}      % Advanced table cells
\RequirePackage{setspace}      % Set space between lines
\RequirePackage{scrextend}     % Allows \addmargin environment
\RequirePackage{tablefootnote} % Table footnotes
\RequirePackage{tocloft}       % Custom ToC/LoF/LoT
\RequirePackage[hyphens]{url}  % URL-sensitive line breaks
\RequirePackage{xspace}        % Remove duplicated spaces

%----------------------------
% Parametrized dependencies
%----------------------------
% Bibliography in biber
\RequirePackage[
    backend=biber,
    style=ieee,
    dashed=false,
    maxnames=4,
    sorting=nty,
    date=ymd,
    urldate=ymd
]{biblatex}
% Break URLs in the middle if necessary
\setcounter{biburllcpenalty}{7000}
\setcounter{biburlucpenalty}{8000}
% Custom figure and table captions
\RequirePackage[
    font=small,
    labelfont=bf,
    labelsep=period
]{caption}
% Custom footnote typesetting
\RequirePackage[
    hang
]{footmisc}
\setlength{\footnotemargin}{\wutfootnoteindent}
% A4 paper and margins
\RequirePackage[
    a4paper,
    left=25mm,
    right=25mm,
    top=25mm,
    bottom=25mm,
    bindingoffset=\wutbindingoffset
]{geometry}
% Clickable hyperlinks
\RequirePackage{hyperref}
\hypersetup{
    breaklinks,
    colorlinks,
    citecolor=black,
    filecolor=black,
    linkcolor=black,
    urlcolor=black
}
% Advanced interword spacing
\RequirePackage[
    protrusion=true,
    expansion=true
]{microtype}
% Code listings
\RequirePackage[dvipsnames]{xcolor} % 68 additional named colors (CMYK)
\RequirePackage{listings}
\lstdefinestyle{codestyle}{
    commentstyle=\color{Gray},
    keywordstyle=\color{Mulberry},
    stringstyle=\color{RoyalBlue},
    numberstyle=\tiny\color{Gray},
    basicstyle=\footnotesize\bfseries\ttfamily,
    breakatwhitespace=false,
    breaklines=true,
    prebreak=\space\raisebox{0ex}[0ex][0ex]{\ensuremath{\hookleftarrow}},
    postbreak=\raisebox{0ex}[0ex][0ex]{\ensuremath{\hookrightarrow}}\space,
    captionpos=b,
    keepspaces=true,
    numbers=left,
    numbersep=5pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=4,
}
\lstset{style=codestyle}
% listings custom syntax
%% diff
\lstdefinelanguage{diff}{
    morecomment=[f][\color{RoyalBlue}]{@@}, % group identifier
    morecomment=[f][\color{BrickRed}]-,     % deleted lines 
    morecomment=[f][\color{OliveGreen}]+,   % added lines
    morecomment=[f][\color{Mulberry}]{---}, % diff header lines (must appear after +,-)
    morecomment=[f][\color{Mulberry}]{+++},
}
\lstdefinelanguage{dockerfile}{
    morekeywords={[1]FROM, AS, ARG, ENV, WORKDIR, COPY, RUN, EXPOSE, STOPSIGNAL, ENTRYPOINT},
    morecomment=[l]\#,
    morestring=[b]",
}
\lstdefinelanguage{yaml}{
    morecomment=[l]\#,
    basicstyle=\footnotesize\bfseries\ttfamily\color{Mulberry},
    moredelim=**[il][\color{Mulberry}{:}\color{Black}]{:},
}
\lstdefinelanguage{systemd}{
    morecomment=[f][\color{RoyalBlue}]{\[},
    basicstyle=\footnotesize\bfseries\ttfamily\color{Mulberry},
    moredelim=**[il][\color{Mulberry}{=}\color{Black}]{=},
}
\lstdefinelanguage{gotest}{
    morecomment=[l]{\$},
    morekeywords={[1]ok},
}

%----------------------
% Basic configuration
%----------------------
\setstretch{1.15}
\setlength{\parindent}{5mm}
\counterwithin{equation}{section}
\counterwithin{figure}{section}
\counterwithin{table}{section}
\setcounter{tocdepth}{5}
\setcounter{secnumdepth}{5}
% List formatting
\setlist[itemize,1]{topsep=2pt,label=\large$\bullet$, leftmargin=28pt}
\setlist[itemize,2]{topsep=2pt,leftmargin=18pt}
\setlist[itemize,3]{topsep=2pt,leftmargin=18pt}
\setlist[enumerate,1]{topsep=2pt,leftmargin=24pt}
\setlist[enumerate,2]{topsep=2pt,leftmargin=16pt}
\setlist[enumerate,3]{topsep=2pt,leftmargin=16pt}
% Section header formatting
\SetSectionFormatting{section}{0.5cm}{\FormatHangHeading{\Large}}{0.5cm}
\let\oldsection\section
\renewcommand{\section}{
	\thispagestyle{plain}
	\oldsection
}
\newcommand{\tgherosfont}{\fontfamily{qhv}\selectfont}

%------------------
% Header & footer
%------------------
\fancypagestyle{plain}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[LE,RO]{\thepage}
}
\fancypagestyle{headings}{
	\fancyhead{}
	\renewcommand{\headrulewidth}{1pt}
	\fancyheadoffset{0cm}
	\fancyhead[RO]{\nouppercase{\thesection.\hspace{8pt}\leftmark}}
	\fancyhead[LE]{\nouppercase{\thesection.\hspace{8pt}\leftmark}}
	\fancyfoot[LE,RO]{\thepage}
}
% Section number in header
\renewcommand{\sectionmark}[1]{
	\markboth{#1}{#1}
}

%---------------------
% Language choice
%---------------------
\newcommand{\langpol}{
    \newcommand{\@lang}{pl}
    \usepackage[polish]{babel}
    \usepackage{csquotes}

	\newtheorem{theorem}{Twierdzenie}
	\newtheorem{lemma}{Lemat}
	\newtheorem{corollary}{Wniosek}
	\newtheorem{definition}{Definicja}
	\newtheorem{axiom}{Aksjomat}
	\newtheorem{assumption}{Założenie}

	\AtBeginDocument{
		\renewcommand{\listfigurename}{Spis rysunków}
		\renewcommand{\listtablename}{Spis tabel}
		\renewcommand{\tablename}{Tabela}
	}
}
\newcommand{\langeng}{
    \newcommand{\@lang}{en}
    \usepackage[english]{babel}
    \usepackage{csquotes}

	\newtheorem{theorem}{Theorem}
	\newtheorem{lemma}{Lemma}
	\newtheorem{corollary}{Corollary}
	\newtheorem{definition}{Definition}
	\newtheorem{axiom}{Axiom}
	\newtheorem{assumption}{Assumption}

	\AtBeginDocument{
		\renewcommand{\listfigurename}{List of Figures}
		\renewcommand{\listtablename}{List of Tables}
		\renewcommand{\tablename}{Table}
	}
}

%--------------------------
% Title page - macros
%--------------------------
\newcommand{\EngineerThesis}{
    \newcommand{\@ThesisType}{inz}
}
\newcommand{\MasterThesis}{
    \newcommand{\@ThesisType}{mgr}
}
\newcommand{\institute}[1]{
    \newcommand{\@institute}{#1}
}
\newcommand{\fieldofstudy}[1]{
    \newcommand{\@fieldofstudy}{#1}
}
\newcommand{\specialization}[1]{
    \newcommand{\@specialization}{#1}
}
\newcommand{\studentnumber}[1]{
    \newcommand{\@studentnumber}{#1}
}
\newcommand{\supervisor}[1]{
    \newcommand{\@supervisor}{#1}
}
\newcommand{\engtitle}[1]{
    \newcommand{\@engtitle}{#1}
}
\newcommand{\poltitle}[1]{
    \newcommand{\@poltitle}{#1}
}

%------------------
% Title page
%------------------
\renewcommand{\maketitle}{
    \linespread{1.15}

    \thispagestyle{empty}
    \pagenumbering{gobble}

    \begin{center}
        { \tgherosfont
            \includegraphics[width=\textwidth]{tpl/pl/header/eiti.pdf} \\
            \vspace{3em}
                Instytut \@institute \\
            \vspace{4em}
            \includegraphics[width=\textwidth]{tpl/pl/title/\@ThesisType.pdf} \\
            \vspace{2em}
                na~kierunku \@fieldofstudy \\
                w~specjalności \@specialization \\
            \vspace{4em}
            \large \textbf{\@title} \\
            \vspace{4em}
            \LARGE \@author \\
            \normalsize
                Numer~albumu \@studentnumber \\
            \vspace{4em}
                promotor \\
            \@supervisor \\
            \vfill
                WARSZAWA \@date
        } % \tgherosfont
    \end{center}

    \pagenumbering{arabic}
    \setcounter{page}{1}
}

%-------------------------
% Polish abstract
%-------------------------
\renewcommand{\abstract}{
    \thispagestyle{plain}
    \begin{center}\textbf{\large\@title}\end{center}
    \ifnum \pdf@strcmp{\@lang}{pl} = 0
        \textbf{\\ Streszczenie.\xspace}
    \fi
    \ifnum \pdf@strcmp{\@lang}{en} = 0
        \textbf{\\ Abstract.\xspace}
    \fi
}
\newcommand{\keywords}{
    \ifnum \pdf@strcmp{\@lang}{pl} = 0
        \vspace{0.5cm}\par\noindent \textbf{Słowa kluczowe:\xspace}
    \fi
    \ifnum \pdf@strcmp{\@lang}{en} = 0
        \vspace{0.5cm}\par\noindent \textbf{Keywords:\xspace}
    \fi
}

%----------------------------
% English abstract
%----------------------------
\newcommand{\secondabstract}{
    \thispagestyle{plain}
    \ifnum \pdf@strcmp{\@lang}{pl} = 0
        \begin{center}\textbf{\large\@engtitle}\end{center}
        \textbf{\\ Abstract.\xspace}
    \fi
    \ifnum \pdf@strcmp{\@lang}{en} = 0
        \begin{center}\textbf{\large\@poltitle}\end{center}
        \textbf{\\ Streszczenie.\xspace}
    \fi
}
\newcommand{\secondkeywords}{
    \ifnum \pdf@strcmp{\@lang}{pl} = 0
        \vspace{0.5cm}\par\noindent \textbf{Keywords:\xspace}
    \fi
    \ifnum \pdf@strcmp{\@lang}{en} = 0
        \vspace{0.5cm}\par\noindent \textbf{Słowa kluczowe:\xspace}
    \fi
}

%----------------------------
% Authorship statement
%----------------------------
\newcommand{\makeauthorship}{
    \thispagestyle{empty}
    \pagenumbering{gobble}

    \begin{figure}[ht]
        \vspace{-55pt}
        \noindent\makebox[\textwidth]{
        \includegraphics[width=1.19\textwidth]{tpl/\@lang/authorship/eiti.pdf}
        }
    \end{figure}
}

%----------------------------
% License statement
%----------------------------
\newcommand{\makelicense}{
    \thispagestyle{empty}
    \pagenumbering{gobble}

    \begin{figure}[ht]
        \vspace{-55pt}
        \noindent\makebox[\textwidth]{
        \includegraphics[width=1.19\textwidth]{tpl/\@lang/license/eiti.pdf}
        }
    \end{figure}
}

%--------------------------
% Table of Contents setup
%--------------------------
\setlength{\cftbeforesecskip}{2pt}
\renewcommand{\cftsecfont}{\bf\normalsize}
\renewcommand{\cftsecpagefont}{\normalfont}
\renewcommand{\cftsecleader}{\cftdotfill{\cftsecdotsep}}
\renewcommand{\cftsecdotsep}{\cftdotsep}

%------------------------
% List of Figures setup
%------------------------
\renewcommand*\l@figure{\@dottedtocline{1}{0.5em}{2.25em}}
\newcommand{\listoffigurestoc}{
    \listoffigures
    \addcontentsline{toc}{section}{\listfigurename}
}

%-----------------------
% List of Tables setup
%-----------------------
\renewcommand*\l@table{\@dottedtocline{1}{0.5em}{2.25em}}
\newcommand{\listoftablestoc}{
    \listoftables
    \addcontentsline{toc}{section}{\listtablename}
}

%-------------------
% Appendix list
%-------------------
\newcommand{\nocontentsline}[3]{}
\newcommand{\tocless}[2]{%
    \bgroup\let\addcontentsline=\nocontentsline#1{#2}\egroup
}

\newcommand{\@appendixtitle}{
    \ifnum \pdf@strcmp{\@lang}{pl} = 0
        Załącznik
    \fi
    \ifnum \pdf@strcmp{\@lang}{en} = 0
        Appendix
    \fi
}

\let\standardappendix\appendix
\renewcommand\appendix[1]{%
    \refstepcounter{section}
    \tocless{\section*}{\@appendixtitle~\arabic{section}.\hspace*{0.5em} #1}
    \addcontentsline{app}{subsection}{\hspace*{-1.1em}\arabic{section}.\hspace*{0.5em} #1}
}

\newcommand\listofappendicestoc{
    \ifnum \pdf@strcmp{\@lang}{pl} = 0
        \section*{Spis załączników}\@starttoc{app}
    \fi
    \ifnum \pdf@strcmp{\@lang}{en} = 0
        \section*{List of Appendices}\@starttoc{app}
    \fi

    \standardappendix
    \renewcommand{\thesection}{\arabic{section}}
}
