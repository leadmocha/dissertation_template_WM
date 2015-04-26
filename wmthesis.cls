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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Global variables

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
%%

%% User thesis settings
%% Previous Degrees
\newcommand{\previousdegrees}[1]{\def\@wmPreviousDegrees{#1}}%
%% Hometown
\newcommand{\hometown}[1]{\def\@wmHometown{#1}}%
%% Graduation Month and Year
\newcommand{\graduationmonth}[1]{\def\@wmGradMonth{#1}}%
\newcommand{\graduationyear}[1]{\def\@wmGradYear{#1}}%
%%

%% These are the required margins as of 01/22/2015
%% Which uses the revised rules of 02/25/2014
%% Margins:
%% Left:   1.5 to 2.0  inches
%% Right:  1.0 to 1.25 inches
%% Top:    1.0 to 1.25 inches
%% Bottom: 1.0 to 1.25 inches
\newcommand{\wmDissertationPhysicalStandardMargins}{letterpaper,top=1.0in,right=1.0in,bottom=1.0in,left=1.5in}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% These are the options which are allowed to be passed, and will configure the thesis accordingly
%%
%% Final copy to be turned in to University
\DeclareOption{final}{
  \PassOptionsToClass{\wmDefaultFontSize,oneside,openany}{book}
  \PassOptionsToPackage{\wmDissertationPhysicalStandardMargins}{geometry}
  \AtEndOfClass{\doublespacing}
  \setboolean{@wmListTables}{true}
  \setboolean{@wmListFigures}{true}
  \setboolean{@wmListContents}{true}
  \setboolean{@wmPrintTitle}{true}
  \setboolean{@wmPrintExtraPages}{true}
}
%% Draft/personal copy to review
\DeclareOption{personal}{
  \PassOptionsToClass{\wmDefaultFontSize,oneside,openany}{book}
  \PassOptionsToPackage{\wmDissertationPhysicalStandardMargins}{geometry}
  \AtEndOfClass{\doublespacing}
  \setboolean{@wmListTables}{false}
  \setboolean{@wmListFigures}{false}
  \setboolean{@wmListContents}{false}
  \setboolean{@wmPrintTitle}{false}
  \setboolean{@wmPrintExtraPages}{false}
}
%% Reviewer Version
\DeclareOption{reviewer}{
  \PassOptionsToClass{\wmDefaultFontSize,oneside}{book}
  \PassOptionsToPackage{letterpaper,top=1.0in,right=1.0in,bottom=1.0in,left=1.0in}{geometry}
  \AtEndOfClass{\doublespacing}
  \setboolean{@wmListTables}{false}
  \setboolean{@wmListFigures}{false}
  \setboolean{@wmListContents}{false}
  \setboolean{@wmPrintTitle}{false}
  \setboolean{@wmPrintExtraPages}{false}
  \setboolean{@wmResetPages}{true}
}
%% Useful while developing/writting
\DeclareOption{devel}{
  \PassOptionsToClass{\wmDefaultFontSize,twoside}{book}
  \PassOptionsToPackage{letterpaper,top=1.0in,right=1.0in,bottom=1.0in,left=1.0in}{geometry}
  %% For development purposes set all margins to 1.0in all around
  \AtEndOfClass{\onehalfspacing}
  \setboolean{@wmListTables}{false}
  \setboolean{@wmListFigures}{false}
  \setboolean{@wmListContents}{false}
  \setboolean{@wmPrintTitle}{false}
  \setboolean{@wmPrintExtraPages}{false}
}
%% Reset the chapter counter?
\DeclareOption{resetchapters}{
  \setboolean{@wmResetChapters}{true}
}
%% Reset page counter for chapters, appendices and bibliography?
\DeclareOption{resetpages}{
  %\AtEndOfClass{\counterwithin{page}{chapter}}
  \setboolean{@wmResetPages}{true}
}
%% Fallback - Pass unkown options to the book class
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
\RequirePackage{geometry}

%% Configure the line spacing (double should be for final)
\RequirePackage{setspace} %% So we can set the line spacing

%% We need math, of course ;)
\RequirePackage{amsmath}

%% To change counters I guess
%% I no longer need this package, as it resets everything to zero.
%% I preffer to do this manually in that case.
%\RequirePackage{chngcntr}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Now for some fun commands

%% Reset page counter if necessary
\newcommand{\wmResetPages}{%
  \ifthenelse{\boolean{@wmResetPages}}{%
    \setcounter{page}{1}%
  }{}%
}

%% Include chapter command
\newcounter{wmChapterCounter}
\newcommand{\wmChapter}[1]{%
  \setcounter{chapter}{\value{wmChapterCounter}}%
  \ifthenelse{\boolean{@wmResetChapters}}{%
    \setcounter{chapter}{0}%
  }{%
    \setcounter{chapter}{\value{wmChapterCounter}}
  }%
  \wmResetPages
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
  %\ifthenelse{\boolean{@wmResetPages}}{%
  %  \setcounter{chapter}{0}%
  %}{}%
  \wmResetPages%
  \renewcommand{\thechapter}{Bib}
  \printbibliography%
}%

%%
%% Commands to make specific pages
%%
%% List of Tables page
\newcommand{\wmListOfTables}{%
  \ifthenelse{\boolean{@wmListTables}}{%
    \listoftables%
  }{}%
}
%% List of Figures page
\newcommand{\wmListOfFigures}{%
  \ifthenelse{\boolean{@wmListFigures}}{%
    \listoffigures%
  }{}%
}
%% Table of Contents
\newcommand{\wmTableOfContents}{%
  \ifthenelse{\boolean{@wmListContents}}{%
    \tableofcontents%
  }{}%
}
%% Title Page
\newcommand{\wmMakeTitle}{%
  \ifthenelse{\boolean{@wmPrintTitle}}{%
    \begin{titlepage}\begin{center}%
      \ \vfill
      {\LARGE\@title}
      \vfill
      {\Large\@author\\*
      \@wmHometown}
      \vfill
      {\large\@wmPreviousDegrees}
      \vfill
      {\large A Dissertation presented to the Graduate Faculty of the College of William and Mary in Candidacy for the Degree of Doctor of Philosophy}
      \vfill
      {\large Department of Physics}
      \vfill
      {\large The College of William and Mary\\*
      \@wmGradMonth~\@wmGradYear}
      \vfill
    \end{center}\end{titlepage}
  }{}%
}
%% Extra pages?
\newcommand{\wmMakeExtraPages}{%
  \ifthenelse{\boolean{@wmPrintExtraPages}}{%
    %\maketitle%
  }{}%
}

\endinput
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                            %%% DONE %%%                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%