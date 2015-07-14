%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% s
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wmthesis}[2015/01/22 v2.0
              College of William and Mary Thesis LaTeX class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load the bookclass and go from there

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Packages which are required prior to running this class
\RequirePackage{ifthen} % For the boolean macros
\RequirePackage[usenames]{xcolor} % For color definitions
\RequirePackage{fancyhdr} %% So we can later change the header/footer
\RequirePackage{xparse} %% For better declaration of commands
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Global variables

%% Define some tokens
\newtoks\title
\newtoks\author
\newtoks\hometown
\newtoks\previousdegrees
\newtoks\graduationmonth
\newtoks\graduationyear
\newtoks\defensemonth
\newtoks\defenseyear
\newtoks\wmcommitteechair
\newtoks\wmcommitteefirst
\newtoks\wmcommitteesecond
\newtoks\wmcommitteethird
\newtoks\wmcommitteefourth
\newtoks\wmcommitteefifth
\newtoks\wmPackageOptionsgeometry
\newtoks\wmPackageOptionstodonotes

%% Colors by name
\definecolor{WMSilver}  {RGB}{208, 211, 212} % W&M Silver
\definecolor{Folly}     {RGB}{255,   0,  79} % Some pastel red I like

\newcommand{\wmDefaultFontSize}{12pt}

%% Various Flags
\newboolean{@wmResetPages}
\setboolean{@wmResetPages}{false}
\newboolean{@wmResetChapters}
\setboolean{@wmResetChapters}{false}
\newboolean{@wmListTables}
\newboolean{@wmListFigures}
\newboolean{@wmListContents}
\newboolean{@wmPrintTitle}
\newboolean{@wmPrintExtraPages}
\newboolean{@wmDisplayTodos}
\setboolean{@wmDisplayTodos}{true}
\newboolean{@wmDisplayNotes}
\setboolean{@wmDisplayNotes}{false}
\newboolean{@wmDisplayCopyrightPage}
\setboolean{@wmDisplayCopyrightPage}{false}
\newboolean{@wmPrintAbstract}
\setboolean{@wmPrintAbstract}{false}
\newboolean{@wmPrintApproval}
\setboolean{@wmPrintApproval}{false}
\newboolean{@wmPrintDedication}
\setboolean{@wmPrintDedication}{false}
\newboolean{@wmPrintAcknowledgements}
\setboolean{@wmPrintAcknowledgements}{false}


\newboolean{@wmCommitteeChairSet}
\newboolean{@wmCommitteeFirstSet}
\newboolean{@wmCommitteeSecondSet}
\newboolean{@wmCommitteeThirdSet}
\newboolean{@wmCommitteeFourthSet}
\newboolean{@wmCommitteeFifthSet}
\setboolean{@wmCommitteeChairSet}{false}
\setboolean{@wmCommitteeFirstSet}{false}
\setboolean{@wmCommitteeSecondSet}{false}
\setboolean{@wmCommitteeThirdSet}{false}
\setboolean{@wmCommitteeFourthSet}{false}
\setboolean{@wmCommitteeFifthSet}{false}
%%

%% User thesis settings
%% Previous Degrees
%\newcommand{\previousdegrees}[1]{\def\@previousdegrees{#1}}%
%% Hometown
%\newcommand{\hometown}[1]{\def\@hometown{#1}}%
%% Graduation Month and Year
%\newcommand{\graduationmonth}[1]{\def\@graduationmonth{#1}}%
%\newcommand{\graduationyear}[1]{\def\@graduationyear{#1}}%
%%

%% These are the required margins as of 01/22/2015
%% Which uses the revised rules of 02/25/2014
%% Margins:
%% Left:   1.5 to 2.0  inches
%% Right:  1.0 to 1.25 inches
%% Top:    1.0 to 1.25 inches
%% Bottom: 1.0 to 1.25 inches
\newcommand{\wmDissertationPhysicalStandardMargins}{letterpaper,top=1.05in,right=1.05in,bottom=1.05in,left=1.55in,includehead,includefoot}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% These are the options which are allowed to be passed, and will configure the thesis accordingly
%%
%% Final copy to be turned in to University
\DeclareOption{final}{
  \PassOptionsToClass{\wmDefaultFontSize,oneside,openany}{book}
  \wmPackageOptionsgeometry{\wmDissertationPhysicalStandardMargins}
  %\PassOptionsToPackage{\wmDissertationPhysicalStandardMargins}{geometry}
  \AtEndOfClass{\doublespacing}
  \setboolean{@wmResetPages}{false}
  \setboolean{@wmListTables}{true}
  \setboolean{@wmListFigures}{true}
  \setboolean{@wmListContents}{true}
  \setboolean{@wmPrintTitle}{true}
  \setboolean{@wmPrintExtraPages}{true}
  \setboolean{@wmDisplayTodos}{false}
  \wmPackageOptionstodonotes{disable}
  \setboolean{@wmDisplayCopyrightPage}{true}
  \setboolean{@wmPrintAbstract}{true}
  \setboolean{@wmPrintApproval}{true}
  \setboolean{@wmPrintDedication}{true}
  \setboolean{@wmPrintAcknowledgements}{true}
}
%% Draft/personal copy to review
\DeclareOption{personal}{
  \PassOptionsToClass{\wmDefaultFontSize,twoside,openany}{book}
  \wmPackageOptionsgeometry{\wmDissertationPhysicalStandardMargins}
%  \PassOptionsToPackage{\wmDissertationPhysicalStandardMargins}{geometry}
  \AtEndOfClass{\doublespacing}
  \setboolean{@wmListTables}{false}
  \setboolean{@wmListFigures}{false}
  \setboolean{@wmListContents}{false}
  \setboolean{@wmPrintTitle}{false}
  \setboolean{@wmPrintExtraPages}{false}
  \setboolean{@wmDisplayTodos}{false}
  \wmPackageOptionstodonotes{disable}
}
%% Reviewer Version
\DeclareOption{reviewer}{
  \PassOptionsToClass{\wmDefaultFontSize,twoside}{book}
  \wmPackageOptionsgeometry{letterpaper,top=1.0in,right=1.0in,bottom=1.0in,left=1.0in}
  \AtEndOfClass{\doublespacing}
  \setboolean{@wmListTables}{false}
  \setboolean{@wmListFigures}{false}
  \setboolean{@wmListContents}{false}
  \setboolean{@wmPrintTitle}{false}
  \setboolean{@wmPrintExtraPages}{false}
  \setboolean{@wmResetPages}{true}
  \setboolean{@wmDisplayTodos}{false}
  \wmPackageOptionstodonotes{disable}
  \setboolean{@wmDisplayCopyrightPage}{false}
  \setboolean{@wmPrintAbstract}{false}
  \setboolean{@wmPrintApproval}{false}
  \setboolean{@wmPrintDedication}{false}
  \setboolean{@wmPrintAcknowledgements}{false}
}
%% Useful while developing/writting
\DeclareOption{devel}{
  \PassOptionsToClass{\wmDefaultFontSize,twoside}{book}
  \wmPackageOptionsgeometry{letterpaper,top=1.0in,right=1.0in,bottom=1.0in,left=1.0in}
  %% For development purposes set all margins to 1.0in all around
  \AtEndOfClass{\onehalfspacing}
  \AtEndOfClass{  \setlength{\marginparwidth}{2cm}}
  \setboolean{@wmListTables}{false}
  \setboolean{@wmListFigures}{false}
  \setboolean{@wmListContents}{false}
  \setboolean{@wmPrintTitle}{false}
  \setboolean{@wmPrintExtraPages}{false}
  \setboolean{@wmDisplayTodos}{true}
  \wmPackageOptionstodonotes{} %% Clear out the disable todo thing
  \setboolean{@wmDisplayCopyrightPage}{false}
  \setboolean{@wmPrintAbstract}{false}
  \setboolean{@wmPrintApproval}{false}
  \setboolean{@wmPrintDedication}{false}
  \setboolean{@wmPrintAcknowledgements}{false}
}
%% Reset the chapter counter?
\DeclareOption{resetchapters}{
  \setboolean{@wmResetChapters}{true}
}
%% Reset page counter for chapters, appendices and bibliography?
\DeclareOption{resetpages}{
  \setboolean{@wmResetPages}{true}
}
%% Force Double line spacing even in devel mode?
\DeclareOption{doublespacing}{%
  %\setboolean{@wmDoubleLineSpacing}{true}%
  \AtEndOfClass{\doublespacing}
}%
%% Fallback - Pass unknown options to the book class
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{book}%
}

%% Execute default options
\ExecuteOptions{final}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Process given options
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load the base class (books) with configured options
\LoadClass{book}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Final package requirements

%% Set some basic geometry configurations
\RequirePackage[\the\wmPackageOptionsgeometry]{geometry}

%% Configure the line spacing (double should be for final)
\RequirePackage{setspace} %% So we can set the line spacing

%% We need math, of course ;)
\RequirePackage{amsmath}

%% Require a TODO package
\RequirePackage[colorinlistoftodos,\the\wmPackageOptionstodonotes]{todonotes}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Now for some fun commands

%% Declare commands to parse committee information
\DeclareDocumentCommand{\committeechair}{m m m}{%
  \setboolean{@wmCommitteeChairSet}{true}%
  \wmcommitteechair{Committee Chair\\#1,~#2\\#3}%
}%
\DeclareDocumentCommand{\committeefirst}{m m m}{%
  \setboolean{@wmCommitteeFirstSet}{true}%
  \wmcommitteefirst{#1,~#2\\#3}%
}%
\DeclareDocumentCommand{\committeesecond}{m m m}{%
  \setboolean{@wmCommitteeSecondSet}{true}%
  \wmcommitteesecond{#1,~#2\\#3}%
}%
\DeclareDocumentCommand{\committeethird}{m m m}{%
  \setboolean{@wmCommitteeThirdSet}{true}%
  \wmcommitteethird{#1,~#2\\#3}%
}%
\DeclareDocumentCommand{\committeefourth}{m m m}{%
  \setboolean{@wmCommitteeFourthSet}{true}%
  \wmcommitteefourth{#1,~#2\\#3}%
}%
\DeclareDocumentCommand{\committeefifth}{m m m}{%
  \setboolean{@wmCommitteeFifthSet}{true}%
  \wmcommitteefifth{#1,~#2\\#3}%
}%

%%% And the rest of the commands

%% Reset page counter if necessary
\newcommand{\wmResetPages}{%
  \ifthenelse{\boolean{@wmResetPages}}{%
    \@namedef{thepage}{\@nameuse{thechapter}.\arabic{page}}%
    \setcounter{page}{1}%
  }{}%
}

%% Include Abstract command
\newcommand{\wmAbstract}[1]{%
  \ifthenelse{\boolean{@wmPrintAbstract}}{%
    \clearpage%
    \begin{center}ABSTRACT\end{center}%
    {\singlespacing\raggedright\input{#1}}\hfill\\%
  }{}%
}%

%% Include Dedication page command
\newcommand{\wmDedication}[1]{%
  \ifthenelse{\boolean{@wmPrintDedication}}{%
    \clearpage%
    \addcontentsline{toc}{chapter}{Dedication}%
    \vspace*{\fill}%
    \begin{center}%\hfill\\[3cm]%
      {\singlespacing#1}\hfill\\%
    \end{center}%
    \vspace*{\fill}%
  }{}%
}%

%% Include Abstract command
\newcommand{\wmAcknowledgements}[1]{%
  \ifthenelse{\boolean{@wmPrintAcknowledgements}}{%
    \clearpage%
    \addcontentsline{toc}{chapter}{Acknowledgements}%
    \begin{center}ACKNOWLEDGEMENTS\end{center}%
    {\singlespacing\input{#1}}\hfill\\%
  }{}%
}%

%% Include chapter command
\newcounter{wmChapterCounter}
\newcommand{\wmChapter}[1]{%
  \setcounter{chapter}{\value{wmChapterCounter}}%
  \ifthenelse{\boolean{@wmResetChapters}}{%
    \setcounter{chapter}{0}%
  }{%
    \setcounter{chapter}{\value{wmChapterCounter}}
  }%
  \wmResetPages%
  \include{#1}%
  \stepcounter{wmChapterCounter}%
}%

%% Include Appendix command
\newcounter{wmAppendixCounter}
\newcommand{\wmAppendix}[1]{%
  \ifthenelse{\boolean{@wmResetChapters}}{%
    \setcounter{chapter}{0}%
    %\setcounter{page}{0}%
  }{%
    \setcounter{chapter}{\value{wmAppendixCounter}}%
  }%
  \wmResetPages%
  \include{#1}%
  \stepcounter{wmAppendixCounter}%
}%

%% Prints the bibliography
\newcommand{\wmBibliography}{%
  \ifthenelse{\boolean{@wmResetPages}}{%
    \setcounter{chapter}{1}%
  }{}%
  \wmResetPages%
  \renewcommand{\thechapter}{Bib}
  \printbibliography%
}%

%% Specify a TODO macro
\newcommand{\wmTodo}[1]{%
%  \ifthenelse{\boolean{@wmDisplayTodos}}{%
%    {\color{red}[[ \uppercase{#1} ]]}%
%  }{%
%  }%
  \todo{\textbf{TODO:} #1}%
}%

%% Specify a COMMENT macro
\newcommand{\wmComment}[1]{%
  \todo[color=WMSilver]{\textbf{COMMENT:} #1}%
}%

%% Specify a FIXME macro
\newcommand{\wmFixMe}[1]{%
  \todo[color=Folly]{\textbf{FIXME:} #1}%
}%

%% Change MissingFigure macro to draw a mini-figure
%% in the todolist
\makeatletter
\newcommand*{\myMiniMissingFigureDraw}{%
\begin{tikzpicture}[scale=0.1]%
\draw[red, fill=white, rounded corners = 0.5pt, line width=1pt] 
    (30:2cm) -- (150:2cm) -- (270:2cm) -- cycle;
\end{tikzpicture}%
}%
\renewcommand{\missingfigure}[2][]{%
\setkeys{todonotes}{#1}%
\addcontentsline{tdo}{todo}{{\protect \myMiniMissingFigureDraw} #2}%
\par
\noindent
\begin{tikzpicture}
\draw[fill=\@todonotes@currentfigcolor, draw = black!40, line width=2pt]
    (-2, -2.5) rectangle +(\@todonotes@currentfigwidth, \@todonotes@currentfigheight);
\draw (2, -0.3) node[right, text
    width=\@todonotes@currentfigwidth-4.5cm] {#2};
\draw[red, fill=white, rounded corners = 5pt, line width=10pt] 
    (30:2cm) -- (150:2cm) -- (270:2cm) -- cycle;
\draw (0, 0.3) node {\@todonotes@MissingFigureUp};
\draw (0, -0.3) node {\@todonotes@MissingFigureDown};
\end{tikzpicture}\hfill
}% Ending \missingfigure command
\makeatother
%% Specify a MissingFigure macro
\newcommand{\wmMissingFigure}[1]{%
  \missingfigure[figcolor=white,caption={\textbf{MissingFigure:} #1}]{#1}
}

%%
%% Commands to make specific pages
%%
%% List of Tables page
\newcommand{\wmListOfTables}{%
  \ifthenelse{\boolean{@wmListTables}}{%
    \clearpage%
    \addcontentsline{toc}{chapter}{\listtablename}
    {\singlespacing\listoftables}%
  }{}%
}
%% List of Figures page
\newcommand{\wmListOfFigures}{%
  \ifthenelse{\boolean{@wmListFigures}}{%
    \clearpage%
    \addcontentsline{toc}{chapter}{\listfigurename}
    {\singlespacing\listoffigures}%
  }{}%
}
%% Table of Contents
\newcommand{\wmTableOfContents}{%
  \ifthenelse{\boolean{@wmListContents}}{%
    {\singlespacing\tableofcontents}%
  }{}%
}
%% Title Page
\newcommand{\wmMakeTitle}{%
  \ifthenelse{\boolean{@wmPrintTitle}}{%
    \begin{titlepage}\begin{center}%
      %\hfill\\[0.5cm]%
      {\large\the\title}%
      \vfill%
      {\large\the\author\\*%
      \the\hometown}%
      \vfill%
      {\large\the\previousdegrees}%
      \vfill%
      {\large%
      A Dissertation presented to the Graduate Faculty\\*%
      of the College of William and Mary in Candidacy for the Degree of\\*%
      Doctor of Philosophy}%
      \vfill%
      {\large Department of Physics}%
      \vfill%
      {\large The College of William and Mary\\*%
      \the\graduationmonth~\the\graduationyear}%
      \hfill\\[1cm]%
    \end{center}\end{titlepage}%
  }{}%
}

%% Copyright Page (if requested)
\newcommand{\wmMakeCopyrightPage}{%
  \ifthenelse{\boolean{@wmDisplayCopyrightPage}}{%
    %% Clear the page if it hasn't already
    \clearpage%
    \begin{center}%
      \hfill\vfill%
      {\copyright~\the\graduationyear}\\*%
      \the\author\\*%
      All Rights Reserved\\[1in]%
    \end{center}%
  }{}%
}%

\newcommand{\makeCommitteeSignLine}[2]{%
 \ifthenelse{#2}{%
   \noindent\rule{4.5in}{0.4pt}\\
    #1\\[1.5em]\vfill%
 }{}%
}%

%% Copyright Page (if requested)
\newcommand{\wmMakeApprovalPage}{%
  \ifthenelse{\boolean{@wmPrintApproval}}{%
    \clearpage%
    \begin{center}{\singlespacing%
      APPROVAL PAGE\\[2em]
      This Dissertation is submitted in partial fulfillment of\\
      the requirements for the degree of\\
      Doctor of Philosophy\\[2em]
      \noindent\rule{4.75in}{0.4pt}\\
      \the\author\\[2em]
      Approved by the Committee \the\defensemonth~\the\defenseyear\\[1.5em]%
      \vfill%
      \makeCommitteeSignLine{\the\wmcommitteechair}%
        {\boolean{@wmCommitteeChairSet}}%
      \makeCommitteeSignLine{\the\wmcommitteefirst}%
        {\boolean{@wmCommitteeFirstSet}}%
      \makeCommitteeSignLine{\the\wmcommitteesecond}%
        {\boolean{@wmCommitteeSecondSet}}%
      \makeCommitteeSignLine{\the\wmcommitteethird}%
        {\boolean{@wmCommitteeThirdSet}}%
      \makeCommitteeSignLine{\the\wmcommitteefourth}%
        {\boolean{@wmCommitteeFourthSet}}%
      \makeCommitteeSignLine{\the\wmcommitteefifth}%
        {\boolean{@wmCommitteeFifthSet}}%
    }\end{center}%
  }{}%
}%

%% Extra pages?
\newcommand{\wmMakeExtraPages}{%
  \ifthenelse{\boolean{@wmPrintExtraPages}}{%
    %% Clear page number
    \pagenumbering{gobble}
    \wmMakeCopyrightPage%
    \wmMakeApprovalPage%
  }{}%
}

%% List of Todos page
\newcommand{\wmListOfTodos}{%
  \ifthenelse{\boolean{@wmDisplayTodos}}{%
%    \ifthenelse{\boolean{@wmResetPages}}{%
%      \setcounter{chapter}{0}%
%    }{}%
%    \wmResetPages%
%    \renewcommand{\thechapter}{Todos}
    \listoftodos[List of Things to do, Things to Fix and Things That...are...Comments...yeah that last one doesn't sound right]%
  }{}%
}

%% Reset count and start Roman Numbering
\newcommand{\wmStartRomanNumbering}{%
  \clearpage%
  \wmResetPages%
  \pagenumbering{Roman}%
%  \fancyhf{}
%  \cfoot{\thepage}
  \pagestyle{plain}
  \cfoot{\thepage}
}%
%%

%% Reset count and start Arabic Numbering
\newcommand{\wmStartNormalNumbering}{%
  \clearpage%
  \wmResetPages%
  \pagenumbering{arabic}%
%  \cfoot{}
%  \renewcommand{\chaptermark}[1]{%
%    \markboth{\MakeUppercase{%
%      \chaptername}\ \thechapter.%
%      \ #1
%    }{}%
%  }%
%  \fancyhead[LE,RO]{\thepage}
%  \fancyhead[LO,RE]{\leftmark}
  \fancyhead[R]{\thepage}
  \fancyhead[L]{\leftmark}
  \pagestyle{fancy}
  \cfoot{}
}%
%%

\endinput
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                            %%% DONE %%%                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%