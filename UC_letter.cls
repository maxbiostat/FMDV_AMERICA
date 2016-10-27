% UC letterhead class
%
% Revision 2010.03.03 Sobel
% Added sender name to "from" fields.
% Fixed major issue with footer on first page.
% Slightly modified margins.
% Now uses school name if center name is blank.
%
% $Log: ucletter.cls,v $
% Revision 1.7  2005/12/20 18:15:54  elm
% *** empty log message ***
%
% Revision 1.6  2005/03/02 22:46:08  elm
% Moved departments to E2.
%
% Revision 1.5  2003/07/25 20:31:42  elm
% Major changes to ucletter.cls to make it look more like the standard
% UC letterhead.
%
% Added a class for doing biobibs.
%
% Revision 1.4  2003/05/11 18:04:19  elm
% Changed size of subcaption figures.
%
% Revision 1.3  2002/12/17 00:01:26  elm
% Minor formatting changes for UC letterhead.
%
% Revision 1.2  2002/12/09 19:15:30  elm
% Made changes including the use of "noaddress" to omit the
% return address.
%
% Revision 1.1  2002/06/07 21:58:38  elm
% This class is for printing letters on UC letterhead.  It's similar to
% the old ucletter style, but is updated to use LaTeX2e stuff.
%
%
%
%
% Example usage of ucletter:
%
% \documentclass[ucsc,cs,11pt,addrfooterall,shortfrom]{UC_letter}
% \from{Dr Elm}
% \phone{+1 (831) 459-1222}
% \email{elm@cs.ucsc.edu}
% \fax{+1 (831) 459-4829}
% \signature{David Elm}
%
% Footer options are: addrfooter, addrfooterall, and noaddrfooter (default).
% From options are: nofrom, datefrom, fullfrom, and shortfrom (default).
%
% Default dept and univ will set the document up for Computer Science at UCSC.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UC_letter}

\RequirePackage{ifthen}
\RequirePackage{graphics}
\RequirePackage{mathptm}
\RequirePackage{times}

% Default is short return address
\newcommand{\ucl@fromaddr}{short}

% Defaults are for the Computer Science Department at UCSC...
\newcommand{\ucl@univ}{UCSC}
\newcommand{\ucl@campus}{Santa Cruz}
\newcommand{\ucl@school}{Baskin School of Engineering}
\newcommand{\ucl@univstreet}{Engineering 2 Building}
\newcommand{\ucl@univtown}{Santa Cruz, California 95064}
\newcommand{\ucl@dept}{Computer Science Department}
\newcommand{\ucl@deptphone}{+1 (831) 459-2158}
\newcommand{\ucl@deptfax}{+1 (831) 459-4829}
\newcommand{\ucl@depturl}{http://www.cs.ucsc.edu/}
\newcommand{\ucl@center}{}
\newcommand{\ucl@sender}{}
\newcommand{\ucl@phone}{}
\newcommand{\ucl@email}{}
\newcommand{\ucl@fax}{}
\newcommand{\ucl@pagetitle}{}
\newboolean{ucl@firstfooter}
\setboolean{ucl@firstfooter}{false}
\newboolean{ucl@otherfooter}
\setboolean{ucl@otherfooter}{false}

% These commands show up in the return address, but NOT in the footer on each page
\newcommand{\from}[1]{\renewcommand{\ucl@sender}{#1}}
\newcommand{\phone}[1]{\renewcommand{\ucl@phone}{#1}}
\newcommand{\email}[1]{\renewcommand{\ucl@email}{#1}}
\newcommand{\fax}[1]{\renewcommand{\ucl@fax}{#1}}

\newcommand{\pagetitle}[1]{\renewcommand{\ucl@pagetitle}{#1}}


\DeclareOption{ucsc}{
  \renewcommand{\ucl@univ}{UCSC}
  \renewcommand{\ucl@campus}{Santa Cruz}
  \renewcommand{\ucl@univtown}{Santa Cruz, California 95064}
  \DeclareOption{soe}{
    \renewcommand{\ucl@dept}{}
    \renewcommand{\ucl@deptphone}{+1 (831) 459-2158}
    \renewcommand{\ucl@school}{Jack Baskin School of Engineering}
    \renewcommand{\ucl@deptfax}{+1 (831) 459-4829}
    \renewcommand{\ucl@depturl}{http://www.soe.ucsc.edu/}
  }
  \DeclareOption{cs}{
    \renewcommand{\ucl@dept}{Computer Science Department}
    \renewcommand{\ucl@deptphone}{+1 (831) 459-5745}
    \renewcommand{\ucl@school}{Jack Baskin School of Engineering}
    \renewcommand{\ucl@univstreet}{Engineering 2 Building}
    \renewcommand{\ucl@deptfax}{+1 (831) 459-4829}
    \renewcommand{\ucl@depturl}{http://www.cs.ucsc.edu/}
  }
  \DeclareOption{ce}{
    \renewcommand{\ucl@dept}{Computer Engineering Department}
    \renewcommand{\ucl@school}{Jack Baskin School of Engineering}
    \renewcommand{\ucl@univstreet}{Engineering 2 Building}
    \renewcommand{\ucl@deptphone}{+1 (831) 459-5745}
    \renewcommand{\ucl@deptfax}{+1 (831) 459-4829}
    \renewcommand{\ucl@depturl}{http://www.ce.ucsc.edu/}
  }
  \DeclareOption{ee}{
    \renewcommand{\ucl@dept}{Electrical Engineering Department}
    \renewcommand{\ucl@school}{Jack Baskin School of Engineering}
    \renewcommand{\ucl@deptphone}{+1 (831) 459-5745}
    \renewcommand{\ucl@deptfax}{+1 (831) 459-4829}
    \renewcommand{\ucl@depturl}{http://www.ee.ucsc.edu/}
  }
  \DeclareOption{ams}{
    \renewcommand{\ucl@dept}{Applied Mathematics \& Statistics}
    \renewcommand{\ucl@school}{Jack Baskin School of Engineering}
    \renewcommand{\ucl@deptphone}{+1 (831) 459-4822}
    \renewcommand{\ucl@deptfax}{+1 (831) 459-4829}
    \renewcommand{\ucl@depturl}{http://www.ams.ucsc.edu/}
  }
}

\DeclareOption{ucsb}{
  \renewcommand{\ucl@univ}{UCSB}
  \renewcommand{\ucl@campus}{Santa Barbara}
  \DeclareOption{cs}{
    \renewcommand{\ucl@dept}{Computer Science Department}
    \renewcommand{\ucl@school}{}
    \renewcommand{\ucl@univstreet}{}
    \renewcommand{\ucl@univtown}{Santa Barbara, California 93106-5110}
    \renewcommand{\ucl@deptphone}{+1 (805) 893-4321}
    \renewcommand{\ucl@depturl}{http://www.cs.ucsb.edu/}
  }
}

\DeclareOption{ucla}{
  \renewcommand{\ucl@univ}{UCLA}
  \renewcommand{\ucl@campus}{Los Angeles}
  \DeclareOption{hg}{
    \renewcommand{\ucl@dept}{Department of Human Genetics}
    \renewcommand{\ucl@school}{David Geffen School of Medicine at UCLA}
    \renewcommand{\ucl@univstreet}{695 Charles E. Young Drive South}
    \renewcommand{\ucl@univtown}{Los Angeles, California 90095-7088}
    \renewcommand{\ucl@center}{}
    \renewcommand{\ucl@deptphone}{+1.310.794.5423}
    \renewcommand{\ucl@deptfax}{+1.310.794.5446}
    \renewcommand{\ucl@depturl}{http://www.genetics.ucla.edu}
  }
  \DeclareOption{biomath}{
    \renewcommand{\ucl@dept}{Department of Biomathematics}
    \renewcommand{\ucl@school}{David Geffen School of Medicine at UCLA}
    \renewcommand{\ucl@univstreet}{AV-617 Center for Health Sciences}
    \renewcommand{\ucl@univtown}{Los Angeles, California 90095-1766}
    \renewcommand{\ucl@center}{}
    \renewcommand{\ucl@deptphone}{+1.310.825.5554}
    \renewcommand{\ucl@deptfax}{+1.310.825.8685}
    \renewcommand{\ucl@depturl}{http://www.biomath.ucla.edu}
  }
  \DeclareOption{biostat}{
    \renewcommand{\ucl@dept}{Department of Biostatistics}
    \renewcommand{\ucl@school}{UCLA School of Public Health}
    \renewcommand{\ucl@univstreet}{51-254 Center for Health Sciences}
    \renewcommand{\ucl@univtown}{Los Angeles, California 90095-1772}
    \renewcommand{\ucl@center}{}
    \renewcommand{\ucl@deptphone}{+1.310.825.5250}
    \renewcommand{\ucl@deptfax}{+1.310.267.2113}
    \renewcommand{\ucl@depturl}{http://www.biostat.ucla.edu}
  }
  \DeclareOption{stats}{
    \renewcommand{\ucl@dept}{Department of Statistics}
    \renewcommand{\ucl@center}{Administrative Office}
    \renewcommand{\ucl@univstreet}{8125 Mathematical Sciences Building}
    \renewcommand{\ucl@univtown}{Los Angeles, California 90095-1554}
    \renewcommand{\ucl@school}{}
    \renewcommand{\ucl@deptphone}{+1 (310) 825-8430}
    \renewcommand{\ucl@deptfax}{+1 (310) 206-5658}
    \renewcommand{\ucl@depturl}{http://www.stat.ucla.edu/}
  }
  \DeclareOption{scc}{
    \renewcommand{\ucl@dept}{Department of Statistics}
    \renewcommand{\ucl@center}{Statistical Consulting Center}
    \renewcommand{\ucl@univstreet}{9434 Boelter Hall}
    \renewcommand{\ucl@univtown}{Los Angeles, California 90095-1554}
    \renewcommand{\ucl@school}{}
    \renewcommand{\ucl@deptphone}{+1 (310) 267-4710}
    \renewcommand{\ucl@deptfax}{+1 (310) 206-5658}
    \renewcommand{\ucl@depturl}{http://scc.stat.ucla.edu/}
  }
  \DeclareOption{ces}{
    \renewcommand{\ucl@dept}{Department of Statistics}
    \renewcommand{\ucl@center}{Center for Environmental Statistics}
    \renewcommand{\ucl@univstreet}{8209 Mathematical Sciences Building}
    \renewcommand{\ucl@univtown}{Los Angeles, California 90095-1554}
    \renewcommand{\ucl@school}{}
    \renewcommand{\ucl@deptphone}{+1 (310) 825-8430}
    \renewcommand{\ucl@deptfax}{+1 (310) 206-5658}
    \renewcommand{\ucl@depturl}{http://ces.stat.ucla.edu/}
  }
}

\DeclareOption{ucd}{
  \renewcommand{\ucl@univ}{UCD}
  \renewcommand{\ucl@campus}{Davis}
  \renewcommand{\ucl@school}{College of Engineering}
  \renewcommand{\ucl@univstreet}{2064 Kemper Hall, One Shields Avenue}
  \renewcommand{\ucl@univtown}{Davis, California 95616}
  \DeclareOption{ece}{
    \renewcommand{\ucl@dept}{Department of Electrical and Computer Engineering}
    \renewcommand{\ucl@deptphone}{+1 (530) 752-0583}
    \renewcommand{\ucl@school}{College of Engineering}
    \renewcommand{\ucl@deptfax}{+1 (530) 752-8428}
    \renewcommand{\ucl@depturl}{http://www.ece.ucdavis.edu/}
  }
}

\DeclareOption{uci}{
  \renewcommand{\ucl@univ}{UCI}
  \renewcommand{\ucl@campus}{Irvine}
  \renewcommand{\ucl@school}{Henri Samueli School of Engineering}
  \DeclareOption{eecs}{
    \renewcommand{\ucl@dept}{Department of Electrical Engineering and Computer Science}
    \renewcommand{\ucl@deptphone}{949-824-4821}
    \renewcommand{\ucl@deptfax}{}
    \renewcommand{\ucl@depturl}{http://www.eng.uci.edu/}
    \renewcommand{\ucl@univstreet}{325 Engineering Tower}
    \renewcommand{\ucl@univtown}{Irvine, California 92697-2625}
  }
}

\DeclareOption{nofrom}{
  \renewcommand{\ucl@fromaddr}{none}
}

\DeclareOption{shortfrom}{
  \renewcommand{\ucl@fromaddr}{short}
}

\DeclareOption{fullfrom}{
  \renewcommand{\ucl@fromaddr}{full}
}

\DeclareOption{datefrom}{
  \renewcommand{\ucl@fromaddr}{date}
}

\DeclareOption{noaddrfooter}{
  \setboolean{ucl@firstfooter}{false}
  \setboolean{ucl@otherfooter}{false}
}

\DeclareOption{addrfooterall}{
  \setboolean{ucl@firstfooter}{true}
  \setboolean{ucl@otherfooter}{true}
}

\DeclareOption{addrfooter}{
  \setboolean{ucl@firstfooter}{false}
  \setboolean{ucl@otherfooter}{true}
}
  
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions

\LoadClass{letter}
\RequirePackage{fullpage}

\newcommand{\@sixrm}{\fontfamily{ptm}\fontsize{6}{8}\selectfont}
\newcommand{\@svnrm}{\fontfamily{ptm}\fontsize{7}{9}\selectfont}
\newcommand{\@egtrm}{\fontfamily{ptm}\fontsize{8}{10}\selectfont}
\newcommand{\@twlrm}{\fontfamily{ptm}\fontsize{12}{14}\selectfont}
\newcommand{\@ctrdot}{\hspace*{1.4pt}$\cdot$\hspace*{1.4pt}}


% Build the UC letterhead
\newsavebox{\@ucletterhead}
\sbox{\@ucletterhead}{\parbox[b]{7in}{
    \begin{tabular*}{7in}{@{}l@{\extracolsep\fill}r@{}}
      \@twlrm\selectfont UNIVERSITY OF CALIFORNIA, {\MakeUppercase \ucl@campus} &
    \end{tabular*}\\
    \begin{tabular*}{7in}{@{}l@{}c@{}r@{}}
      \parbox{4.60in}{\rule{4.55in}{0.25pt} \\
        \@svnrm BERKELEY\@ctrdot DAVIS\@ctrdot IRVINE\@ctrdot
        LOS ANGELES\@ctrdot MERCED\@ctrdot RIVERSIDE\@ctrdot
        SAN DIEGO\@ctrdot SAN FRANCISCO\hspace\fill \\
        \rule[3pt]{4.55in}{0.25pt}} &
      \parbox{0.75in}{\resizebox{0.75in}{!}{\includegraphics{UC_seal_large}}}
      \parbox{1.6in}{\rule{1.6in}{0.25pt} \\
        \rule{0mm}{4pt}\hspace\fill
        \@svnrm SANTA BARBARA\@ctrdot SANTA CRUZ\hspace*{1pt} \\
        \rule[3pt]{1.6in}{0.25pt}}
    \end{tabular*}
    \vspace*{24pt}
    \begin{minipage}{7in}
%      \@egtrm\MakeUppercase \ucl@dept \hspace\fill \ucl@deptphone \\
%      \@egtrm\MakeUppercase \ucl@univstreet \hspace\fill FAX \ucl@deptfax \\
%      \@egtrm\MakeUppercase \ucl@univtown \\
      \@egtrm\MakeUppercase \ucl@dept \\
      \ifthenelse{\equal{\ucl@center}{}}
         {\@egtrm\MakeUppercase \ucl@school
            \ifthenelse{\equal{\ucl@deptphone}{}}{}{\hspace\fill \ucl@deptphone \\}
         }
         {\@egtrm\MakeUppercase \ucl@center
            \ifthenelse{\equal{\ucl@deptphone}{}}{}{\hspace\fill \ucl@deptphone \\}
         }
      \ifthenelse{\equal{\ucl@univstreet\ucl@deptfax}{}}{}
         {\@egtrm\MakeUppercase \ucl@univstreet
            \ifthenelse{\equal{\ucl@deptfax}{}}{}{\hspace\fill FAX: \ucl@deptfax \\}
         }
      \@egtrm\MakeUppercase \ucl@univtown \\
    \end{minipage}
  }
}

% \ucl@fromaddr is either none, date, full, or short.
\newcommand{\@ucaddress}{
  \begin{minipage}[t]{3.0in}
    \ifthenelse{\equal{\ucl@fromaddr}{date}}{}{
      \ifthenelse{\equal{\ucl@sender}{}}{}{\ucl@sender \\}
    }
    \ifthenelse{\equal{\ucl@fromaddr}{full}}{
      \ifthenelse{\equal{\ucl@dept}{}}{}{\ucl@dept \\}
      \ifthenelse{\equal{\ucl@center}{}}{\ucl@school}{\ucl@center} \\
      University of California \\
      \ifthenelse{\equal{\ucl@univstreet}{}}{}{\ucl@univstreet \\}
      \ucl@univtown \\
    }{}
    \ifthenelse{\equal{\ucl@fromaddr}{date}}{}{
      \ifthenelse{\equal{\ucl@phone}{}}{}{{\sc Phone:} \ucl@phone\\}
      \ifthenelse{\equal{\ucl@fax}{}}{}{{\sc Fax:} \ucl@fax\\}
      \ifthenelse{\equal{\ucl@email}{}}{}{{\sc Email:} \ucl@email\\}
    }
    \@date
  \end{minipage}
}

% Dot with spacing around it
\newcommand{\@spcdot}{\hspace{7pt}$\cdot$\hspace{7pt}}

% Return address in 9 point font
\newcommand{\@addrfoot}[1]{
 % The argument is for a page number,
 % in case you want to print the page number at the bottom of the page
  \begin{tabular}{c}
    \fontfamily{ptm}\fontsize{8}{10}\selectfont
    % \sc \ucl@dept\@spcdot\ucl@univstreet\@spcdot\ucl@univtown \\
      \sc \ucl@dept\@spcdot
         \ifthenelse{\equal{\ucl@center}{}}{\ucl@school}{\ucl@center}
         \@spcdot\ucl@univtown \\
    \fontfamily{ptm}\fontsize{8}{10}\selectfont
    \sc Phone: \ucl@deptphone{\@spcdot}Fax: \ucl@deptfax\@spcdot\ucl@depturl
  \end{tabular}
}


\setlength{\headheight}{0.9in}
\setlength{\headsep}{0.25in}
\setlength{\topmargin}{-0.5in}
\setlength{\footskip}{0.65in}
\setlength{\textwidth}{7.0in}
\setlength{\textheight}{8.0in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}


\newlength{\@ucaddrht}
\renewcommand{\ps@firstpage}
{
  \renewcommand{\@oddhead}{\centerline{\parbox{7in}{\usebox{\@ucletterhead}}}}
  \renewcommand{\@evenhead}{}
  % Use a blank for the page number - no number on the first page of the letter
  \renewcommand{\@oddfoot}{\ifthenelse{\boolean{ucl@firstfooter}}{\@addrfoot{~}}{}}
  \renewcommand{\@evenfoot}{\@oddfoot}
}

\renewcommand{\ps@headings}{
  % Right justify the page number
  \renewcommand{\@oddhead}{\hspace*{\fill}\ucl@pagetitle\hspace*{\fill}\thepage}
  \renewcommand{\@evenhead}{\@oddhead}
  % Pass the page number to the footer, which doesn't do anything currently
  \renewcommand{\@oddfoot}{\ifthenelse{\boolean{ucl@otherfooter}}{\@addrfoot{\thepage}}{}}
  \renewcommand{\@evenfoot}{\@oddfoot}
}

\pagestyle{headings}

\renewcommand{\opening}[1]{
  \thispagestyle{firstpage}
  \vspace*{0.25in}
  \ifthenelse{\equal{\ucl@fromaddr}{none}}{}{
    \noindent\rule{4.25in}{0mm}
    \@ucaddress
  }
  \par\noindent\toname \\ \toaddress

  \vspace{1ex}

  \noindent #1
}
