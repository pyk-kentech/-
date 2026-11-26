%% -*- TeX:UTF-8 -*-
%% KENTECH Thesis Template for LaTeX Users
%% @version 0.1
%% @releasedate May 31st 2025
%% @author  Sumyeong Ahn 안수명
%%          mailto:sumyeongahn@kentech.ac.kr
%% @requirements
%%  current distribution of TeXLive
%%    + ko.TeX
%% 본 템플릿은 KAIST Latex Thesis template 기반으로 작성되었음을 밝힙니다.

%%%%%%%%%%%%%%%%%%%%%%
%% 템플릿 기본 정보 세팅 %%
%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{kentech-ucs}[2025/05/30 v0.1 KENTECH Thesis document class]


%% 옵션 설정을 위한 boolean 변수선언
\RequirePackage{ifthen} 
\newcommand{\@setDegree}[1]{
    \ifthenelse{\equal{#1}{phd}}{\@isPhDtrue \@isMasterfalse \@isBachelorfalse}
    {
        \ifthenelse{\equal{#1}{master}}{\@isPhDfalse \@isMastertrue \@isBachelorfalse}
        {
            \ifthenelse{\equal{#1}{bachelor}}{\@isPhDfalse \@isMasterfalse \@isBachelortrue}
            {
                \ClassError{kentech-thesis}{Unknown degree option '#1'}{Use phd, master, or bachelor only.}
            }
        }
    }
}



\newif\if@isPhD \@isPhDfalse
\newif\if@isMaster \@isMasterfalse
\newif\if@isBachelor \@isBachelorfalse
\newif\if@isKorean
\newif\if@isFinal
\newif\if@PDFdoc\@PDFdocfalse
\newif\if@dvips\@dvipsfalse

%% 새 옵션 모음 - phd|master|bachelor, korean|english, final|draft
\DeclareOption{phd}   {\@setDegree{phd}}
\DeclareOption{master}   {\@setDegree{master}}
\DeclareOption{bachelor} {\@setDegree{bachelor}}

\DeclareOption{korean} {\@isKoreantrue}
\DeclareOption{english} {\@isKoreanfalse}

\DeclareOption{final}  {\@isFinaltrue}
\DeclareOption{draft}  {\@isFinalfalse}

\DeclareOption{pdfdoc} {\@PDFdoctrue}
\DeclareOption{dvips}  {\@dvipstrue}

%% leqno,fleqn,openbib 옵션은 그대로 report 클래스에 전달
\DeclareOption{leqno}  {\PassOptionsToClass{leqno}  {report}}
\DeclareOption{fleqn}  {\PassOptionsToClass{fleqn}  {report}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{report}}

\ExecuteOptions{bachelor,korean,final}         % phd,korean,final이 기본값
\ProcessOptions

%% 11pt,onecolumn,oneside 옵션으로 report 클래스 불러오기
\LoadClass[10pt,a4paper,onecolumn,oneside]{report} % ver0.2 : 본문 글자 크기 11pt

%%들여쓰기
\usepackage{indentfirst}
\setlength\parindent{2.0em}


%% 추가 패키지 설정
\RequirePackage{ifthen}       

%%%% Korean typesetting and graphics driver
\RequirePackage{iftex}
\RequirePackage{ifpdf}
\ifXeTeX
  \RequirePackage{xetexko}
  \def\@drivername{xetex}
\else
  \RequirePackage[nonfrench]{dhucs}
  \ifpdf
    \def\@drivername{pdftex}
  \else
    \def\@drivername{dvipdfmx}
  \fi
  \if@dvips
    \def\@drivername{dvips}
  \fi
\fi

\RequirePackage[\@drivername]{graphicx,xcolor}

\usepackage{color}
\definecolor{cyan}{cmyk}{1,0,0,0}
\definecolor{darkgreen}{rgb}{0,0.5,0}
\definecolor{orange}{rgb}{1,0.5,0}
\definecolor{magenta}{cmyk}{0,1,0,0}
\definecolor{darkyellow}{cmyk}{0,0,0.75,0}
\definecolor{darkred}{rgb}{0.4,0,0}
\definecolor{darkgreen}{rgb}{0,0.25,0}
\definecolor{darkblue}{rgb}{0,0,0.55}
\definecolor{darkcyan}{cmyk}{0.75,0,0,0}
\definecolor{darkmagenta}{cmyk}{0,0.75,0,0}
\definecolor{darkyellow}{cmyk}{0,0,0.75,0}

\if@PDFdoc
    \RequirePackage[final,unicode,%
    \@drivername,%
    bookmarks=true,%
    colorlinks=true,%
    linkcolor=black,      %black
    anchorcolor=black,      %black
    citecolor=blue,        %green
    filecolor=darkmagenta,      %magenta
    menucolor=darkred,      %red
    urlcolor=darkcyan,          %cyan
    ]{hyperref}
\else
    \RequirePackage[final,unicode,%
    \@drivername,%
    bookmarks=false,%
    colorlinks=false,%
    colorlinks=true,    %remove square
    linkcolor=black,      %black
    anchorcolor=black,      %black
    citecolor=blue,        %green
    filecolor=darkmagenta,      %magenta
    menucolor=darkred,      %red
    urlcolor=darkcyan,          %cyan
    ]{hyperref}
\fi


%% for compatability to HLaTeX
\let\gt\sffamily
\DeclareTextFontCommand{\textgt}{\gt}
%%%% end of Hangul-ucs preamble

\AtBeginDocument{%
    \if@isFinal
        \checkparameters
        \makefrontcover
        \makeinnercover
        \makeapproval
    \fi
    \renewcommand\thesection{\thechapter-\arabic{section}}%
}
\AtEndDocument{}                       % \end{document}와 함께 실행

%% 편집용지 설정
\usepackage[left=25.4mm,right=25.4mm,top=30mm,bottom=25.4mm,a4paper]{geometry}

%% 줄간격 설정
% 작성 안내(2026-2): 본문·Abstract·국문초록은 2배수, 각주·표·그림·인용·두 줄 이상의 제목은 1배수.
% 표지·목차 같은 앞부분은 원래의 130%로 두고, \makecontents 끝에서 본문을 2배수로 바꾼다.
% setspace 는 각주와 떠다니는 표·그림(캡션 포함)을 1배수로 둔다.
\RequirePackage{setspace}
\setstretch{1.3}			                     % ver1.0 : 줄간격 130 (앞부분)
\newcommand{\@kentechdouble}{1.667}           % setspace 의 10pt 2배수(\doublespacing)와 같은 값
% 절 제목이 두 줄로 넘어가도 1배수가 되게 report 의 정의에 \setstretch{1}만 더한다.
\renewcommand\section{\@startsection {section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}{2.3ex \@plus.2ex}%
  {\normalfont\Large\bfseries\setstretch{1}}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}{1.5ex \@plus .2ex}%
  {\normalfont\large\bfseries\setstretch{1}}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}{1.5ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries\setstretch{1}}}

%% 본문이 영어로 되어있는지 한글로 되어있는지 설정
\newcommand{\@korean}{korean}
\newcommand{\@english}{english}
\newcommand{\@textlang}{}                       % 텍스트 기본언어 변수선언
\if@isKorean                                    % korean 옵션이 지정되어 있으면
    \let\@textlang\@korean                      % 텍스트 기본언어는 한글
\else                                           % english 옵션이 지정되어 있으면
    \let\@textlang\@english                     % 텍스트 기본언어는 영문
\fi

%% KENTECH 공식 영문명칭
\newcommand{\@kentech}{Korea Institute of Energy Technology}

%% pagestyle
\def\ps@kentech{\let\@mkboth\@gobbletwo
     \let\@oddhead\@empty
     \def\@oddfoot{\reset@font\hfil--\ \thepage\ --
     \hfil}%
     \let\@evenhead\@empty\let\@evenfoot\@oddfoot
}
\pagestyle{kentech}

%%%%%%%%%%%%%%%%%%%%%
%% 문서 정보 변수 정의 %%
%%%%%%%%%%%%%%%%%%%%%

% @command title 논문 제목
% @options [default: (none)]
% - kor: 한글제목 | eng_full: 영문제목 | eng_sub: 영문서브
\renewcommand{\title}[2][eng-full] {%
    \ifthenelse{\equal{#1}{eng-full}}%
        {\newcommand{\@titleFull}{#2}}{}%
    \ifthenelse{\equal{#1}{eng-sub}}%
        {\newcommand{\@titleSub}{#2}}{}%
    \ifthenelse{\equal{#1}{kor}}%
        {\newcommand{\@titleKor}{#2}}{}%
}
\@onlypreamble{\title}

% @command author 저자 이름
% @param family_name, given_name 성, 이름을 구분해서 입력
% @options [default: (none)]
% - korean: 한글이름 english: 영문이름
\renewcommand{\author}[3][korean] {%
    \ifthenelse{\equal{#1}{korean}}
        {\newcommand{\@authorKorFN}{#2}
         \newcommand{\@authorKorGN}{#3}
         \newcommand{\@authorKor}{#2\ #3}}{}%
    \ifthenelse{\equal{#1}{english}}
        {\newcommand{\@authorEngFN}{#2}
         \newcommand{\@authorEngGN}{#3}
         \newcommand{\@authorEng}{#3 #2}}{}%
}
\@onlypreamble{\author}

% @command advisor 지도교수 이름 (복수가능)
% @options [default: major]
% - major: 주 지도교수  | coopr: 부 지도교수 (공동지도교수 경우)
\newcommand{\advisor}[4][major]{%
    \ifthenelse{\equal{#1}{major}} {%                    % 주 지도교수이면
        \newcommand{\@advisorMajorKor}{#2}          % 한글이름 저장
        \newcommand{\@advisorMajorEng}{#3}          % 영문이름 저장
        % nosign을 명시하지 않으면 주 지도교수가 서명한 것으로 간주
        \ifthenelse{\equal{#4}{nosign}}{}{%
            \newcommand{\@advisorSigned}{\@advisorMajorEng}} }{}%
    \ifthenelse{\equal{#1}{coopr}} {%               % 부 지도교수이면
        \newcommand{\@advisorCooprKor}{#2}          % 한글이름 저장
        \newcommand{\@advisorCooprEng}{#3}          % 영문이름 저장
        % signed를 명시해야 부 지도교수가 서명한 것으로 간주
        \ifthenelse{\equal{#4}{signed}}{%
            \newcommand{\@advisorSigned}{\@advisorCooprEng}}{} }{}%
}
\@onlypreamble{\advisor}


% @command department 트랙 정보
% @option
% - AI: Energy AI | GR : Grid Modernization | MA : Energy Materials and Devices
% - HY: Hydrogen Energy | EN : Environment & Climate Technology 
% - BA : Bachelor (무트랙)
% \newcommand{\@degreeCode}{}
\newcommand{\@childDeptNameKor}{} 
\newcommand{\@parentDeptNameKor}{}
\newcommand{\@parentDeptNameEng}{}      
\newcommand{\@childDeptNameEng}{}       
\newcommand{\@programDeptNameEng}{}		
\newcommand{\@affFullNameKor}{}      
\newcommand{\@affFullNameEng}{}      
\newcommand{\@affFullNameEngCover}{} 
% \newcommand{\@degreePrefix}{\ifthenelse{\boolean{@isPhD}}{D}{M}}

\newcommand{\department}[1]{%
  \ifthenelse{\equal{#1}{AI}}{%
    % \renewcommand{\@degreeCode}{\@degreePrefix#1}%
    \renewcommand{\@childDeptNameKor}{에너지 AI 트랙}%
    \renewcommand{\@childDeptNameEng}{Energy AI Track}%
    \renewcommand{\@parentDeptNameKor}{에너지공학부}%
    \renewcommand{\@parentDeptNameEng}{Department of Energy Engineering}%
    }{}
    
  \ifthenelse{\equal{#1}{GR}}{%
    % \renewcommand{\@degreeCode}{\@degreePrefix#1}%
    \renewcommand{\@childDeptNameKor}{차세대 그리드}%
    \renewcommand{\@childDeptNameEng}{Grid Modernization Track}%
    \renewcommand{\@parentDeptNameKor}{에너지공학부}%
    \renewcommand{\@parentDeptNameEng}{Department of Energy Engineering}%
  }{}
    
  \ifthenelse{\equal{#1}{MA}}{%
    % \renewcommand{\@degreeCode}{\@degreePrefix#1}%
    \renewcommand{\@childDeptNameKor}{에너지 신소재}%
    \renewcommand{\@childDeptNameEng}{Energy Materials and Devices}%
    \renewcommand{\@parentDeptNameKor}{에너지공학부}%
    \renewcommand{\@parentDeptNameEng}{Department of Energy Engineering}%
  }{}
    
  \ifthenelse{\equal{#1}{HY}}{%
    % \renewcommand{\@degreeCode}{\@degreePrefix#1}%
    \renewcommand{\@childDeptNameKor}{수소 에너지}%
    \renewcommand{\@childDeptNameEng}{Hydrogen Energy}%
    \renewcommand{\@parentDeptNameKor}{에너지공학부}%
    \renewcommand{\@parentDeptNameEng}{Department of Energy Engineering}%
  }{}
    
  \ifthenelse{\equal{#1}{EN}}{%
    % \renewcommand{\@degreeCode}{\@degreePrefix#1}%
    \renewcommand{\@childDeptNameKor}{환경 기후 기술}%
    \renewcommand{\@childDeptNameEng}{Environmental \& Climate Technology}%
    \renewcommand{\@parentDeptNameKor}{에너지공학부}%
    \renewcommand{\@parentDeptNameEng}{Department of Energy Engineering}%
  }{}
    
  \ifthenelse{\equal{#1}{BA}}{%
    % \renewcommand{\@degreeCode}{\@degreePrefix#1}%
    \renewcommand{\@childDeptNameKor}{\@empty}%
    \renewcommand{\@childDeptNameEng}{\@empty}%
    \renewcommand{\@parentDeptNameKor}{에너지공학부}%
    \renewcommand{\@parentDeptNameEng}{Department of Energy Engineering}%
  }{}

    \renewcommand{\@affFullNameKor}{%
      \ifthenelse{\equal{\@parentDeptNameKor}{}}%
        {\@childDeptNameKor}%
        {\@parentDeptNameKor, \@childDeptNameKor}%
    }%

    \renewcommand{\@affFullNameEng}{%
      \ifthenelse{\equal{\@parentDeptNameEng}{}}%
        {\@childDeptNameEng}%
        {\@parentDeptNameEng, \@childDeptNameEng}%
    }%
}
  % {}
  
% }
\@onlypreamble{\department}



% @command studentid 학번
\newcommand{\studentid}[1]{\newcommand{\@studentID}{#1}}
\@onlypreamble{\studentid}

% @command referee 심사위원 (학사과정 2인, 석사과정 3인, 박사과정 5인)
\newcommand{\referee}[2][1] {%
	\ifthenelse{\equal{#1}{1}}{\newcommand{\@refereeChief} {#2}} {}%
	\ifthenelse{\equal{#1}{2}}{\newcommand{\@refereeSecond}{#2}} {}%
	\ifthenelse{\equal{#1}{3}}{\newcommand{\@refereeThird} {#2}} {}%
	\ifthenelse{\equal{#1}{4}}{\newcommand{\@refereeFourth}{#2}} {}%
	\ifthenelse{\equal{#1}{5}}{\newcommand{\@refereeFifth} {#2}} {}%
}
\@onlypreamble{\referee}

% @command approvaldate 지도교수논문승인일
% @param year,month,day 연,월,일 순으로 입력
\newcommand{\approvaldate}[3] {%
    \newcommand{\@approvalYear}{#1}
    \newcommand{\@approvalMonth}{#2}
    \newcommand{\@approvalDay}{#3}
}
\@onlypreamble{\approvaldate}

% @command refereedate 심사위원논문심사일
% @param year,month,day 연,월,일 순으로 입력
\newcommand{\refereedate}[3] {%
    \newcommand{\@refereeYear}{#1}
    \newcommand{\@refereeMonth}{#2}
    \newcommand{\@refereeDay}{#3}
}
\@onlypreamble{\refereedate}

% @command gradyear 졸업년도
\newcommand{\gradyear}[1]{\newcommand{\@gradYear}{#1}}
\@onlypreamble{\gradyear}


%% 필요한 정보 중에 누락된 것이 없는지 점검 --> 제작중. 
\newcommand{\checkparameters}{%
    \@ifundefined{@titleFull}{%
        \ClassError{kentech}{The korean title is not found}{}}{}
    \@ifundefined{@authorKor}{%
        \ClassError{kentech}{The korean name of the author is not found}{}}{}
    \@ifundefined{@authorEng}{%
        \ClassError{kentech}{The english name of the author is not found}{}}{}
    \@ifundefined{@advisorMajorKor}{%
        \ClassError{kentech}{The korean name of the major advisor is not found}{}}{}
    \@ifundefined{@advisorMajorEng}{%
        \ClassError{kentech}{The english name of the major advisor is not found}{}}{}
}


%%%%%%%%%%%%%
%% 표지 생성 %%
%%%%%%%%%%%%%


%% 논문 표지 생성
%% Don't change size of letters.
\newcommand{\makefrontcover}{%
    \renewcommand{\baselinestretch}{1.1}%
    \thispagestyle{empty} \noindent%
    
    % 상단: 논문 종류
    \begin{center}
        \if@isPhD
            \fontsize{14pt}{14pt}\selectfont Doctoral Dissertation \\
        \else
            \if@isMaster
                \fontsize{14pt}{14pt}\selectfont Master's Thesis \\
            \else
                \fontsize{14pt}{14pt}\selectfont Bachelor's Thesis \\
            \fi
        \fi
    \end{center}
    \vspace*{3cm}

    % 제목
    \begin{center}
        \fontsize{22pt}{22pt}\selectfont \@titleFull \\[0.2em]
        \ifdefined\@titleSub
            \fontsize{16pt}{16pt}\selectfont -~\@titleSub~- \\
        \fi
    \end{center}
    \vspace*{3.5cm}

    % 저자
    \begin{center}
        \fontsize{16pt}{16pt}\selectfont \@authorEng \\
    \end{center}
    \vspace*{3.5cm}

    % 학과
    \begin{center}
        \fontsize{14pt}{14pt}\selectfont \@parentDeptNameEng \\
    \end{center}
    \vspace*{2.5cm}

    % 학교 이름
    \begin{center}
        \fontsize{16pt}{16pt}\selectfont \@kentech \\
    \end{center}
    \vspace*{2cm}

    % 졸업년도
    \begin{center}
        \fontsize{14pt}{14pt}\selectfont \@gradYear
    \end{center}

    \newpage
}

%% 속표지: 작성 안내는 앞표지 다음, 인준서 앞에 둔다. 샘플처럼 앞표지와 같은 내용이다.
\newcommand{\makeinnercover}{\makefrontcover}

%% 학위논문 심사완료 검인서 및 제출승인서 생성
%%  Don't change size of letters.
\newcommand{\makeapproval}{%
  \thispagestyle{empty} \noindent
    \begin{center}
        % Title
        \fontsize{22pt}{22pt}\selectfont \@titleFull\\[0.2em]
        \ifdefined\@titleSub
            \fontsize{16pt}{16pt}\selectfont -~\@titleSub~- \\
        \fi
        \vspace*{3cm}

        % Author
        \fontsize{16pt}{16pt}\selectfont \@authorEng \\
        \vspace*{1.5cm}

        % Affiliation
        \fontsize{14pt}{14pt}\selectfont \@parentDeptNameEng \\
        % \fontsize{14pt}{14pt}\selectfont \@childDeptNameEng \\ % 트랙 고정 혹은 자동 삽입 가능

        \if@isBachelor\@empty
        \else
            \fontsize{14pt}{14pt}\selectfont \@childDeptNameEng \\
        \fi
        
        \fontsize{16pt}{16pt}\selectfont \@kentech \\
        \vspace*{1.5cm}

        \ifdefined\@advisorMajorEng
            \fontsize{14pt}{14pt}\selectfont
            \ifdefined\@advisorCooprEng
                Thesis Advisors: \@advisorMajorEng\ and \@advisorCooprEng \\
            \else
                Thesis Advisor: \@advisorMajorEng \\
            \fi
            \vspace*{1.2cm}
        \fi

        % Degree statement
        \fontsize{16pt}{16pt}\selectfont
        \if@isFinal
            Accepted in partial fulfillment of the requirements for the \\
        \else
            Submitted in partial fulfillment of the requirements for the \\
        \fi
        degree of
        \if@isPhD
            Doctor of Philosophy
        \else
            \if@isMaster
                Master of Science
            \else
                Bachelor of Science
            \fi
        \fi
        \vspace*{1.5cm}

        % Date
        \fontsize{14pt}{14pt}\selectfont
        \@ifundefined{@refereeYear}{[Examination date]}{%
            \@dateUSenglish{\@refereeYear}{\@refereeMonth}{\@refereeDay}} \\
        \vspace*{4cm}

        % Committee table
        \fontsize{14pt}{14pt}\selectfont
        \begin{tabular}{@{}l@{\hspace{1.2em}}l@{}}
              \fontsize{14pt}{14pt}\selectfont Committee Chair &
                \underline{%
                    \makebox[6.5cm][l]{%
                    \hfill
                        {\fontsize{14pt}{14pt}\selectfont \@refereeChief}%
                    \hfill
                        {\fontsize{10pt}{10pt}\selectfont (Signature)}%
                    }%
                } \\[1.2em]
    
                
            \if@isBachelor
                \fontsize{14pt}{14pt}\selectfont Committee Member &
                \underline{%
                    \makebox[6.5cm][l]{%
                    \hfill
                        {\fontsize{14pt}{14pt}\selectfont \@refereeSecond}%
                    \hfill
                        {\fontsize{10pt}{10pt}\selectfont (Signature)}%
                    }%
                } \\[1.2em]
            \fi
              
              \if@isMaster
                \fontsize{14pt}{14pt}\selectfont Committee Member &
                  \underline{%
                    \makebox[6.5cm][l]{%
                    \hfill
                        {\fontsize{14pt}{14pt}\selectfont \@refereeSecond}%
                    \hfill
                        {\fontsize{10pt}{10pt}\selectfont (Signature)}%
                    }%
                } \\[1.2em]
                \fontsize{14pt}{14pt}\selectfont Committee Member &
                  \underline{%
                    \makebox[6.5cm][l]{%
                    \hfill
                        {\fontsize{14pt}{14pt}\selectfont \@refereeThird}%
                    \hfill
                        {\fontsize{10pt}{10pt}\selectfont (Signature)}%
                    }%
                } \\[1.2em]
              \fi
            
              \if@isPhD
                \fontsize{14pt}{14pt}\selectfont Committee Member &
                  \underline{%
                    \makebox[6.5cm][l]{%
                    \hfill
                        {\fontsize{14pt}{14pt}\selectfont \@refereeSecond}%
                    \hfill
                        {\fontsize{10pt}{10pt}\selectfont (Signature)}%
                    }%
                } \\[1.2em]
                \fontsize{14pt}{14pt}\selectfont Committee Member &
                  \underline{%
                    \makebox[6.5cm][l]{%
                    \hfill
                        {\fontsize{14pt}{14pt}\selectfont \@refereeThird}%
                    \hfill
                        {\fontsize{10pt}{10pt}\selectfont (Signature)}%
                    }%
                } \\[1.2em]
                \fontsize{14pt}{14pt}\selectfont Committee Member &
                  \underline{%
                    \makebox[6.5cm][l]{%
                    \hfill
                        {\fontsize{14pt}{14pt}\selectfont \@refereeFourth}%
                    \hfill
                        {\fontsize{10pt}{10pt}\selectfont (Signature)}%
                    }%
                } \\[1.2em]
                \fontsize{14pt}{14pt}\selectfont Committee Member &
                  \underline{%
                    \makebox[6.5cm][l]{%
                    \hfill
                        {\fontsize{14pt}{14pt}\selectfont \@refereeFifth}%
                    \hfill
                        {\fontsize{10pt}{10pt}\selectfont (Signature)}%
                    }%
                } \\[1.2em]
              \fi
            
            \end{tabular}
  \end{center}
  \newpage
}


%%
%% 한글 초록과 영문 초록, 논문서지(Korean summary and abstract) 페이지 생성
%% Don't change size of letters. 

\newcounter{pagemarker}                           % 페이지 번호 임시 저장용
\newcommand{\@lastPage}{\pageref{paperlastpagelabel}} % 총 페이지 수 계산용
\newcommand{\@lastRomanPage}{\pageref{paperlastromanpagelabel}} % 총 로마자 페이지 수 계산용


\renewenvironment{abstract}{%
  \linespread{1.0}
  \clearpage
  \pagenumbering{roman}
  \setcounter{page}{1}
  \thispagestyle{plain}
  \vspace*{32pt}
  \begin{center}
    \fontsize{16pt}{16pt}\selectfont \textbf{\abstractname}
    \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\abstractname} % 목차(TOC)에 추가
  \end{center}
  \vspace{16pt}
  \setlength{\parindent}{2em}  % 들여쓰기
  \setlength{\parskip}{0pt}    % 문단 간 간격 없음
  % \setstretch 는 글자 크기를 \normalsize 로 되돌리므로 \linespread 를 먼저 두고 11pt 를 고른다.
  \linespread{\@kentechdouble}\fontsize{11pt}{13.2pt}\selectfont % 11pt, 2배수(작성 안내)
}{\par\vspace*{66pt}}

% Keywords 환경
\newenvironment{Engkeyword}{%
  \vspace{1.5em}
  \noindent
  \fontsize{11pt}{11pt}\selectfont
  \textbf{Keywords:}%
}{}

\newenvironment{korabstract}{%
  \linespread{1.0}
    \clearpage
    \thispagestyle{plain}
    \vspace*{32pt}
    \begin{center}
        \fontsize{16pt}{32pt}\selectfont \textbf{\korabstractname} \\
        \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\korabstractname} % 목차(TOC)에 추가
        \vspace{16pt}
        \@titleKor
    \end{center}
    \vspace{16pt}
    \setlength{\parindent}{2em}  % 들여쓰기
    \setlength{\parskip}{0pt}    % 문단 간 간격 없음
    \linespread{\@kentechdouble}\fontsize{11pt}{13.2pt}\selectfont % 11pt, 2배수(작성 안내)
}{\par\vspace*{66pt}}


%% Keywords 환경
\newenvironment{Korkeyword}{%
  \vspace{1.5em}
  \noindent
  \fontsize{11pt}{11pt}\selectfont
  \textbf{핵심어:}%
}{}

%%
%% 목차 일괄 생성
%%
\newcommand{\makecontents}{%
    \clearpage
    % 작성 안내·샘플: 앞부분(Abstract~그림 목차)의 쪽 번호는 로마자 소문자만 쓴다. 각 목차의 첫 쪽은
    % \thispagestyle{plain} 이라 "iii" 인데 이어지는 쪽은 본문 모양("-- iv --")으로 찍혀 섞였다.
    \pagestyle{plain}%
    \setcounter{pagemarker}{\value{page}}%
    \pagenumbering{roman}%
    \setcounter{page}{\value{pagemarker}}%
    \tableofcontents
    \listoftables
	\listoffigures
    \clearpage
    \pagestyle{kentech}% 본문부터 원래 쪽 번호 모양
    \setstretch{\@kentechdouble}% 본문부터 2배수(작성 안내)
}



% %%%%%%%%%%%%%%%%%%%%%%
% %% 논문 뒤 개인정보 생성 %%
% %%%%%%%%%%%%%%%%%%%%%%


%%
%% 사사 및 이력서 생성
%%
\newcommand{\acknowledgment}[1][default]{%     % 사사
	\newcommand{\@acklang}{#1}
	\ifthenelse{\equal{\@acklang}{1}}
	   {\chapter*{사 사} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{사 사}}{}                      % 본문과 사사가 둘 다 한글일 때
	\ifthenelse{\equal{\@acklang}{2}}
	   {\chapter*{영 문 사 사} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{영 문 사 사}}{}        % 본문은 한글인데 사사가 영어일 때
	\ifthenelse{\equal{\@acklang}{3}}
	   {\chapter*{Acknowledgment} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Acknowledgments}}{}           % 본문과 사사가 둘 다 영어일 때 
	\ifthenelse{\equal{\@acklang}{4}}
	   {\chapter*{Acknowledgments} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Acknowledgments}}{}\noindent} % 본문은 영어인데 사사가 한글일 때 

%%
%% 저자 약력 생성
%%
\newcommand{\curriculumvitae}[1][default]{%     % 약력
	\newcommand{\@ccvlang}{#1}
	\ifthenelse{\equal{\@ccvlang}{1}}
	   {\chapter*{약 력} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{약 력}}{}                 % 본문과 약력이 둘 다 한글일 때
	\ifthenelse{\equal{\@ccvlang}{2}}
	   {\chapter*{영 문 약 력} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{영 문 약 력}}{}         % 본문은 한글인데 약력이 영어일 때
	\ifthenelse{\equal{\@ccvlang}{3}}
	   {\chapter*{Curriculum Vitae} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Curriculum Vitae}}{}        % 본문과 약력이 둘 다 영어일 때 
	\ifthenelse{\equal{\@ccvlang}{4}}
	   {\chapter*{Curriculum Vitae} \if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{Curriculum Vitae in Korean}}{}}% 본문은 영어인데 약력이 한글일 때




%%
%% 이력서 내부 요소 생성
%%
\newenvironment{personaldata}{%            % 개인정보
	
	\begin{list}{}{%
			\setlength{\labelwidth}{70pt}
			\setlength{\leftmargin}{\labelwidth}
			\addtolength{\leftmargin}{\labelsep}
			\setlength{\parsep}{0pt}
			\renewcommand{\makelabel}[1]{\textgt{##1:\ }}}
        % 이름
		\newcommand{\name}[1]{%               
			\ifthenelse{\equal{\@ccvlang}{1}}
			     {\def\@arg{[이\hfill름]}}{}
			\ifthenelse{\equal{\@ccvlang}{4}}
			     {\def\@arg{[이\hfill름]}}{}
			\ifthenelse{\equal{\@ccvlang}{2}}
			     {\def\@arg{[Name\hfill]}}{}
			\ifthenelse{\equal{\@ccvlang}{3}}
			     {\def\@arg{[Name\hfill]}}{}
			\expandafter\item\@arg ##1}

        % 생년월일
		\newcommand{\dateofbirth}[3]{
			\ifthenelse{\equal{\@ccvlang}{1}}
			     {\def\@arg{[생\hfill년\hfill월\hfill일]}
				\expandafter\item\@arg ##1년 ##2월 ##3일}{}
			\ifthenelse{\equal{\@ccvlang}{4}}
			     {\def\@arg{[생\hfill년\hfill월\hfill일]}
				\expandafter\item\@arg ##1년 ##2월 ##3일}{}
			\ifthenelse{\equal{\@ccvlang}{2}}
			     {\def\@arg{[Date of Birth\hfill]}    \expandafter\item\@arg \@dateUSenglish{##1}{##2}{##3}}{}
			\ifthenelse{\equal{\@ccvlang}{3}}
			     {\def\@arg{[Date of Birth\hfill]}
				\expandafter\item\@arg \@dateUSenglish{##1}{##2}{##3}}{}
		}

        % 출생지
		\newcommand{\birthplace}[1]{
			\ifthenelse{\equal{\@ccvlang}{1}}
			     {\def\@arg{[출\hfill생\hfill지]}}{}
			\ifthenelse{\equal{\@ccvlang}{4}}
			     {\def\@arg{[출\hfill생\hfill지]}}{}
			\ifthenelse{\equal{\@ccvlang}{2}}
			     {\def\@arg{[Birthplace\hfill]}}{}
			\ifthenelse{\equal{\@ccvlang}{3}}
			     {\def\@arg{[Birthplace\hfill]}}{}
			\expandafter\item\@arg ##1}

        % 주소지
		\newcommand{\address}[1]{
			\ifthenelse{\equal{\@ccvlang}{1}}
			     {\def\@arg{[주\hfill소]}}{}
			\ifthenelse{\equal{\@ccvlang}{4}}
			     {\def\@arg{[주\hfill소]}}{}
			\ifthenelse{\equal{\@ccvlang}{2}}
			     {\def\@arg{[Address\hfill]}}{}
			\ifthenelse{\equal{\@ccvlang}{3}}
			     {\def\@arg{[Address\hfill]}}{}
			\expandafter\item\@arg ##1}

        % 이메일
		\newcommand{\email}[1]{
			\ifthenelse{\equal{\@ccvlang}{1}}
			{\def\@arg{[전\hfill자\hfill주\hfill소]}}{}
			\ifthenelse{\equal{\@ccvlang}{4}}
			{\def\@arg{[전\hfill자\hfill주\hfill소]}}{}
			\ifthenelse{\equal{\@ccvlang}{2}}
			{\def\@arg{[E-mail\hfill]}}{}
			\ifthenelse{\equal{\@ccvlang}{3}}
			{\def\@arg{[E-mail\hfill]}}{}
			\expandafter\item\@arg ##1}
		
		% 추가 필드 템플릿
		%이력서에 집어넣을 추가 필드가 필요하면 위를 참고하여 만들어 쓸 것.
		%\newcommand{(필드명령)}[1]{%
		%  \ifthenelse{\equal{\@ccvlang}{1}}
		%        {\def\@arg{[한글 필드 이름]}}{}
		%   \ifthenelse{\equal{\@ccvlang}{4}}
		%        {\def\@arg{[한글 필드 이름]}}{}
		%   \ifthenelse{\equal{\@ccvlang}{2}}
		%     {\def\@arg{[영어 필드 이름]}}{}
		%      
		%    \ifthenelse{\equal{\@ccvlang}{3}}
		%        {\def\@arg{[영어 필드 이름]}}{}
		%         \expandafter\item\@arg ##1}
	}{\end{list}}

% 학력정보
\newenvironment{education}{
	
	\vspace*{5mm} \noindent
	\ifthenelse{\equal{\@ccvlang}{1}}{
		\begin{center}
			\makebox[2cm][s]{\textbf{\large 학 력}}
		\end{center}
	}{}
	\ifthenelse{\equal{\@ccvlang}{4}}{
		\begin{center}
			\makebox[2cm][s]{\textbf{\large 학 력}}
		\end{center}
	}{} 
	\ifthenelse{\equal{\@ccvlang}{2}}{
		\textbf{\large Educations}
	}{} 
	\ifthenelse{\equal{\@ccvlang}{3}}{
		\textbf{\large Educations}
	}{}  
	\begin{list}{}{%
			\setlength{\labelwidth}{95pt}
			\setlength{\leftmargin}{\labelwidth}
			\addtolength{\leftmargin}{\labelsep}
			\setlength{\parsep}{0pt}
			\renewcommand{\makelabel}[1]{\textgt{##1\hfill\ }}}
	}{\end{list}}

% 경력 정보
\newenvironment{career}{
	\vspace*{5mm} \noindent
	\ifthenelse{\equal{\@ccvlang}{1}}
	{\begin{center}
			\makebox[2cm][s]{\textbf{\large 경 력}}
		\end{center}
	}{ }
	\ifthenelse{\equal{\@ccvlang}{4}}
	{\begin{center}
			\makebox[2cm][s]{\textbf{\large 경 력}}
		\end{center}
	}{ }
	\ifthenelse{\equal{\@ccvlang}{2}}
	{\textbf{\large Career}
	}{ }
	\ifthenelse{\equal{\@ccvlang}{3}}
	{\textbf{\large Career}
	}{ } 
	\begin{list}{}{%
			\setlength{\labelwidth}{95pt}
			\setlength{\leftmargin}{\labelwidth}
			\addtolength{\leftmargin}{\labelsep}
			\setlength{\parsep}{\z@}
			\renewcommand{\makelabel}[1]{\textgt{##1\hfill\ }}}
	}{\end{list}}
\newcounter{itemnum1}

% 외부 활동
\newenvironment{activity}{
        \vspace*{5mm} \noindent
\ifthenelse{\equal{\@ccvlang}{1}}
            {\begin{center}
                \makebox[2cm][s]{\textbf{\large 학 회 활 동}}
            \end{center}
        }{ }
\ifthenelse{\equal{\@ccvlang}{4}}
            {\begin{center}
                \makebox[2cm][s]{\textbf{\large 학 회 활 동}}
            \end{center}
        }{ } 
\ifthenelse{\equal{\@ccvlang}{2}}
           {\textbf{\large Academic Activities}
        }{ } 
\ifthenelse{\equal{\@ccvlang}{3}}
            {\textbf{\large Academic Activities}
        }{ }
 \begin{list}{}{%
            \usecounter{itemnum1}
            \setlength{\labelwidth}{1.5em}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{\z@}
            \renewcommand{\makelabel}{\textgt{\arabic{itemnum1}.\ }}}
    }{\end{list}}
\newcounter{itemnum2}

% 연구 결과 업적
\newenvironment{publication}{
	
	\vspace*{5mm} \noindent
	
	\ifthenelse{\equal{\@ccvlang}{1}}{
		\begin{center}
			\makebox[2cm][s]{\textbf{\large 연 구 업 적}}
		\end{center}}
		{}
		
		\ifthenelse{\equal{\@ccvlang}{4}}{
			\begin{center}
				\makebox[2cm][s]{\textbf{\large 연 구 업 적}}
			\end{center}}
			{}
			
			\ifthenelse{\equal{\@ccvlang}{2}}{ \textbf{\large Publications}}
			{}
			
			\ifthenelse{\equal{\@ccvlang}{3}}{ \textbf{\large Publications}}
			{}
			
			
			\begin{list}{}{%
					\usecounter{itemnum2}
					\setlength{\labelwidth}{1.5em}
					\setlength{\leftmargin}{\labelwidth}
					\addtolength{\leftmargin}{\labelsep}
					\setlength{\parsep}{\z@}
					\renewcommand{\makelabel}{\textgt{\arabic{itemnum2}.\ }}}
			}{
		\end{list}}
		
		%%
		%% 헤딩 재설정
		%%
		\renewcommand{\contentsname}{
			List of Contents}
		\renewcommand{\listfigurename}{
			List of Figures}
		\renewcommand{\listtablename}{
			List of Tables}
		\renewcommand{\bibname}{%
			References}% 작성 안내: 참고문헌(References)
		\renewcommand{\abstractname}{
			Abstract}
		\renewcommand{\figurename}{
			Figure}
		\renewcommand{\tablename}{
			Table}
		\newcommand{\korabstractname}{
			요약(국문초록)}
		%%
		%% \part 재정의 - 아예 쓰지 못하게 막아버림. 이 명령을 호출하면 에러 발생.
		%%
		\renewcommand\part{%
			\secdef\@part\@spart}
		\def\@part[#1]#2{%
			\ClassError{kentech}{The use of \protect\part\space is prohibited.
				\MessageBreak Consider the use of \protect\chapter\space instead}{}
		}
		\def\@spart#1{%
			\ClassError{kentech}{The use of \protect\part\space is prohibited.
				\MessageBreak Consider the use of \protect\chapter\space instead}{}
		}
		
        \renewcommand{\thechapter}{\Roman{chapter}}  % 로마 숫자로
		\renewcommand\chapter{%
			\if@openright\cleardoublepage\else\clearpage\fi
			%   \thispagestyle{plain}%
			\global\@topnum\z@
			\@afterindentfalse
			%   \if@isKorean \parindent\z@ \else \fi % <-- 추가할지 여부 고민중
			\secdef\@chapter\@schapter}
		\def\@chapter[#1]#2{%
			\ifnum \c@secnumdepth >\m@ne
			\refstepcounter{chapter}%
			\typeout{\@chapapp\space\thechapter.}%
			\addcontentsline{toc}{chapter}{%
                \protect\numberline{\thechapter.}#1
				}
			\else
			\addcontentsline{toc}{chapter}{#1}%
			\fi
			\chaptermark{#1}%
			\addtocontents{lof}{\protect\addvspace{10\p@}}%
			\addtocontents{lot}{\protect\addvspace{10\p@}}%
			\if@twocolumn
			\@topnewpage[\@makechapterhead{#2}]%
			\else
			\@makechapterhead{#2}%
			\@afterheading%
			\fi
		}
		\def\@makechapterhead#1{% <-- 전체 변경
			\vspace*{10\p@}
			{
            % \parindent\z@ 
            \hspace{-1.2cm}
            \setstretch{1}% 두 줄 이상의 제목은 1배수
            \fontsize{16pt}{16pt}\selectfont \bfseries
				\hspace{1.4ex}\thechapter.\hspace{1ex}
				#1\par
                }
			\vspace*{20\p@}
		}
		\def\@schapter#1{%
			\if@twocolumn
			\@topnewpage[\@makeschapterhead{#1}]%
			\else
			\@makeschapterhead{#1}%
			\@afterheading
			\fi}
		\def\@makeschapterhead#1{% <-- 전체 변경
			\vspace*{10\p@}
			{\centering \parindent\z@ \setstretch{1}\fontsize{14pt}{14pt}\selectfont \bfseries #1\par}
			\vspace*{20\p@}
		}
		
		%%
		%% \tableofcontents 재정의 - report 클래스로부터 복사하여 일부 수정
		\renewcommand\tableofcontents{%
			\thispagestyle{plain}
			\if@twocolumn
			\@restonecoltrue\onecolumn
			\else
			\@restonecolfalse
			\fi
            \chapter*{\contentsname
				\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}
			\if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\contentsname}
			\@starttoc{toc}%
			\if@restonecol\twocolumn\fi
			\newpage \setcounter{pagemarker}{\value{page}}
			\pagenumbering{arabic}                        
            
		}
		
		%%
		%% \listoftables 재정의 - report 클래스로부터 복사하여 일부 수정
		%%
		\renewcommand\listoftables{%
			\thispagestyle{plain}
			\if@twocolumn
			\@restonecoltrue\onecolumn
			\else
			\@restonecolfalse
			\fi
			\chapter*{\listtablename}%
			\@mkboth{\MakeUppercase\listtablename}{\MakeUppercase\listtablename}%
			\pagenumbering{roman}                         % roman 페이지번호로 복원
			\setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
			\if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\listtablename}% 목차(TOC)에 추가
			\@starttoc{lot}%
			\if@restonecol\twocolumn\fi
			\newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
			\pagenumbering{arabic}                        % arabic 페이지번호로 재시작
        }
            
		
        \renewcommand*\l@table{\@dottedtocline{1}{1.5em}{3em}}
        
		%%
		%% \listoffigures 재정의 - report 클래스로부터 복사하여 일부 수정
		%%
		\renewcommand\listoffigures{%
			\thispagestyle{plain}
			\if@twocolumn
			\@restonecoltrue\onecolumn
			\else
			\@restonecolfalse
			\fi
			\chapter*{\listfigurename}%
			\@mkboth{\MakeUppercase\listfigurename}{\MakeUppercase\listfigurename}%
			\pagenumbering{roman}                         % roman 페이지번호로 복원
			\setcounter{page}{\value{pagemarker}}         % pagemarker에 저장된 값으로
			\if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{\listfigurename}% 목차(TOC)에 추가
			\label{paperlastromanpagelabel}     % <-- 추가 부분: 마지막 페이지 위치 지정
			\@starttoc{lof}%
			\if@restonecol\twocolumn\fi
			\newpage \setcounter{pagemarker}{\value{page}}% pagemarker에 다시 저장
			\pagenumbering{arabic}                        % arabic 페이지번호로 재시작
		}

        \renewcommand*\l@figure{\@dottedtocline{1}{1.5em}{3em}}
        
		%%
		%% 목차에 나오는 형식 - report 클래스로부터 복사하여 일부 수정
		%%
		
		\newcommand{\l@content}{\large\bf\@dottedtocline{1}{0em}{0em}}
        \providecommand*{\toclevel@content}{0}
		\renewcommand{\@dotsep}{0.0}  
        \renewcommand*\l@chapter[2]{%
            \ifnum \c@tocdepth >\m@ne
            \addpenalty{-\@highpenalty}%
            \vskip 1.0em \@plus\p@
            \setlength\@tempdima{2.6em}
            \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode \large \sffamily \bfseries
            \advance\leftskip\@tempdima
            \hskip -\leftskip
            #1%
            \nobreak
            \leaders\hbox to .29em{\hss.\hss}\hfill
            \nobreak
            \hb@xt@\@pnumwidth{\hss #2}\par
            \penalty\@highpenalty
            \endgroup
          \fi
        }
		
		
        \renewcommand*\l@section{\@dottedtocline{0}{0em}{2.8em}}
		\renewcommand*\l@subsection{\@dottedtocline{1}{0.5em}{3.2em}}
		\renewcommand*\l@subsubsection{\@dottedtocline{2}{0.5em}{3.2em}}
		\renewcommand*\l@paragraph{\@dottedtocline{3}{0.5em}{3.2em}}
		\renewcommand*\l@subparagraph{\@dottedtocline{4}{0.5em}{3.2em}}
		
        %%
		%% thebibliography 환경 재정의 - report 클래스로부터 복사하여 일부 수정
		%%
		\renewenvironment{thebibliography}[1]{%
			\chapter*{\bibname}%
			\@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
			\if@PDFdoc\phantomsection\fi\addcontentsline{toc}{chapter}{\bibname}%
			\list{\@biblabel{\@arabic\c@enumiv}}%
			{\settowidth\labelwidth{\@biblabel{#1}}%
				\leftmargin\labelwidth
				\advance\leftmargin\labelsep
				\@openbib@code
				\usecounter{enumiv}%
				\let\p@enumiv\@empty
				\renewcommand\theenumiv{\@arabic\c@enumiv}}%
			\sloppy
			\clubpenalty4000
			\@clubpenalty \clubpenalty
			\widowpenalty4000%
			\sfcode`\.\@m%
		}{  %% \label{paperlastpagelabel}    %  <-- 추가 부분: 마지막 페이지 위치 지정
		\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
		\endlist
	}
	
	%%
	%% 한국식 날짜 표기 -> 영문식 날짜 표기
	%%
	\newcommand{\@dateUSenglish}[3]{%  % 미국식 날짜 표기
		\newcommand{\@year}{#1}%
		\newcommand{\@month}{#2}%
		\newcommand{\@day}{#3}%
		\ifcase\@month \or
		January \or February \or March \or April \or May \or June \or
		July \or August \or September \or October \or November \or December \fi
		\@day, \@year
	}
    
	\newcommand{\@dateBRenglish}[3]{%  % 영국식 날짜 표기
		\newcommand{\@year}{#1}%
		\newcommand{\@month}{#2}%
		\newcommand{\@day}{#3}%
		\@day\ifcase\@day \or
		st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
		st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
		st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or th\fi
		\space\ifcase\@month \or
		January\or February\or March\or April\or May\or June\or
		July\or August\or September\or October\or November\or December\fi,
		\@year
	}
