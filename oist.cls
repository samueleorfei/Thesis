\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{oist}
\LoadClass[12pt,twoside]{report}

\RequirePackage[a4paper, headheight=0.6cm, inner=3cm ,outer=3cm, top=3cm, bottom=3cm]{geometry}  % Changing size of document
\RequirePackage{silence}
\WarningFilter{auxhook}{Cannot patch}
\RequirePackage[table]{xcolor}
\RequirePackage[bf]{caption} % caption: FIG in bold
\RequirePackage[T1]{fontenc}
\RequirePackage{subfiles}
\providecommand{\main}{.}
\RequirePackage[italian]{babel} % The document is in English
\RequirePackage[utf8]{inputenc} % UTF8 encoding
\RequirePackage[T1]{fontenc} % Font 

\RequirePackage{graphicx}
\graphicspath{{\main/images/}}

\RequirePackage{eso-pic} % For the background picture on the title page
\RequirePackage{titlesec}
\RequirePackage{amsthm,amsmath,amssymb,amsfonts,bbm}
\RequirePackage{fancyhdr} % For the headers
\RequirePackage{hyperref} % Adds clickable links at references
\RequirePackage{float}
\RequirePackage{algpseudocode}
\RequirePackage{algorithm}
\RequirePackage{bussproofs}\EnableBpAbbreviations
\RequirePackage{tikz}
\RequirePackage{xifthen}
\RequirePackage{stmaryrd}
\RequirePackage{enumitem}
\RequirePackage{url}
\RequirePackage{parskip}
\RequirePackage{booktabs}
\RequirePackage{xstring}
\RequirePackage{stringstrings}
\RequirePackage{xparse}
\RequirePackage{etoolbox}
\RequirePackage{csquotes}
%\RequirePackage{subfigure}
\RequirePackage{subcaption}
\RequirePackage{bm}
\RequirePackage[backend=biber, style=alphabetic, sorting=ynt]{biblatex}
\addbibresource{\main/bibtex.bib}
\RequirePackage{verbatim}
\RequirePackage{comment}
\RequirePackage{parskip}
\RequirePackage{lipsum}
\RequirePackage{mathrsfs}
\RequirePackage{theorem}

\newcounter{mytaskscounter}
\newcounter{mybrieftaskscounter}
\newcounter{mycelllinescounter}
\newcounter{mybalancingmodescounter}
\newcounter{examplecounter}

\newenvironment{example}{\begin{quote}%
        \refstepcounter{examplecounter}%
        \textbf{Esempio \arabic{examplecounter}}%
        \quad
        }{%
    \end{quote}%
}

\def\savetask#1{%
    \stepcounter{mytaskscounter}%
    \expandafter\def\csname mytaskslist\themytaskscounter\endcsname{#1}}

\def\savebrieftask#1{%
    \stepcounter{mybrieftaskscounter}%
    \expandafter\def\csname mybrieftaskslist\themybrieftaskscounter\endcsname{#1}}

\def\savecellline#1{%
    \stepcounter{mycelllinescounter}%
    \expandafter\def\csname mycelllineslist\themycelllinescounter\endcsname{#1}}

\def\savebalancingmodes#1{%
    \stepcounter{mybalancingmodescounter}%
    \expandafter\def\csname mybalancingmodeslist\themybalancingmodescounter\endcsname{#1}}

\forcsvlist{\savetask}{%
    Active enhancers vs active promoters,
    Active promoters vs inactive promoters,
    Active enhancers vs inactive enhancers,
    Inactive enhancers vs inactive promoters,
    Active enhancers and promoters vs anything else,
}%

\forcsvlist{\savebrieftask}{%
    AE vs AP,
    AP vs IP,
    AE vs IE,
    IE vs IP,
    AE \& AP vs else,
}%

\forcsvlist{\savecellline}{%
    GM12878,
    HelaS3,
    HepG2,
    K562,
}%

\forcsvlist{\savebalancingmodes}{%
    unbalanced,
    balanced,
    full balanced,
}%

\def\getnthtask#1{\csname mytaskslist#1\endcsname}
\def\getnthbrieftask#1{\csname mybrieftaskslist#1\endcsname}
\def\getnthcellline#1{\csname mycelllineslist#1\endcsname}
\def\getnthbalancingmode#1{\csname mybalancingmodeslist#1\endcsname}

\NewDocumentCommand{\decompositions}{mmm}{
    %
    % #1 -> cell line number
    % #2 -> balancing mode number
    % #3 -> task number
    %
    \def\cellline{\getnthcellline{#1}}
    \def\task{\getnthtask{#2}}
    \def\brieftask{\getnthbrieftask{#2}}
    \def\balancingmode{\getnthbalancingmode{#3}}
    \StrSubstitute{\task}{ }{_}[\pathtask]%
    \StrSubstitute{\balancingmode}{ }{_}[\balancingmodepath]%

    \begin{figure}[H]
        \centering
        \includegraphics[width=\textwidth]{decompositions/\cellline/\cellline-\balancingmodepath-\pathtask.png}
        \caption{Task \brieftask{}, cell line \cellline{} and \balancingmode{} mode - Two figures on the left: MCA decomposition for the sequence data (train and test sets); two figures on the right: \(t\)-SNE decomposition for the epigenomic data (train and test sets).}
        \label{fig:decompositions-#1-#2-#3}
    \end{figure}
}

\NewDocumentCommand{\tsne}{m}{
    %
    % #1 -> cell line number
    %
    \def\cellline{\getnthcellline{#1}}

    \begin{figure}[H]
        \centering
        \includegraphics[width=0.9\textwidth]{decompositions/\cellline/big-tsne.png}
        \caption{TSNE for \cellline{} epigenomic data}
        \label{fig:big-tsne-#1}
    \end{figure}
    \begin{figure}[H]
        \centering
        \includegraphics[width=\textwidth]{decompositions/\cellline/tsne.png}
        \caption{Per class TSNE for \cellline{} epigenomic data}
        \label{fig:tsne-#1}
    \end{figure}
}

\NewDocumentCommand{\mca}{m}{
    %
    % #1 -> cell line number
    %
    \def\cellline{\getnthcellline{#1}}

    \begin{figure}[H]
        \centering
        \includegraphics[width=0.9\textwidth]{decompositions/\cellline/big-mca.png}
        \caption{MCA for \cellline{} epigenomic data}
        \label{fig:big-mca-#1}
    \end{figure}
    \begin{figure}[H]
        \centering
        \includegraphics[width=\textwidth]{decompositions/\cellline/mca.png}
        \caption{Per class MCA for \cellline{} sequence data}
        \label{fig:mca-#1}
    \end{figure}
}

\NewDocumentCommand{\history}{mmmm}{
    %
    % #1 -> cell line number
    % #2 -> balancing mode number
    % #3 -> task number
    % #4 -> kind
    %
    \def\cellline{\getnthcellline{#1}}
    \def\task{\getnthtask{#2}}
    \def\brieftask{\getnthbrieftask{#2}}
    \def\balancingmode{\getnthbalancingmode{#3}}
    \StrSubstitute{\task}{ }{_}[\pathtask]%
    \StrSubstitute{#4}{ }{_}[\kind]%
    \StrSubstitute{\balancingmode}{ }{_}[\balancingmodepath]%

    \begin{figure}[H]
        \centering
        \includegraphics[width=\textwidth]{cnn/\kind/\cellline/\cellline-\balancingmodepath-\pathtask.png}
        \caption{Average history of #4 for \brieftask, \cellline, \balancingmode}
        \label{fig:\kind-#1-#2-#3}
    \end{figure}
}

\NewDocumentCommand{\bestmodel}{mmm}{
    %
    % #1 -> cell line number
    % #2 -> balancing mode number
    % #3 -> task number
    %
    \history{#1}{#2}{#3}{best models}
}

\NewDocumentCommand{\gaussianprocess}{mmm}{
    %
    % #1 -> cell line number
    % #2 -> balancing mode number
    % #3 -> task number
    %
    \history{#1}{#2}{#3}{gaussian process}
}

\NewDocumentCommand{\wilcoxon}{mm}{
    %
    % #1 -> Table path
    % #2 -> Caption
    %
    \begin{table}[H]
        \centering
        {\small \input{chapters/tables/wilcoxon/#1.tex}}
        \caption{Wilcoxon signed rank test win-tie-loss at 0.01 significance level to compare #2.}
        \label{tab:wilcoxon-#1}
    \end{table}
}

\NewDocumentCommand{\pearson}{mm}{
    %
    % #1 -> Table path
    % #2 -> Caption
    %
    \begin{table}[H]
        \centering
        \input{chapters/tables/pearson/pearson-#1.tex}
        \caption{Pearson coefficient table for AUPRC, AUROC, total required time and dataset cardinality for #2 in the unbalanced mode.}
        \label{tab:pearson-#1}
    \end{table}
}

\NewDocumentCommand{\histogram}{mmm}{
    %
    % #1 -> Image path
    % #2 -> Caption
    % #3 -> label
    %
    \StrSubstitute{#1}{ }{_}[\path]%
    \StrSubstitute{#2}{cnn}{CNN}[\cnncaption]%
    \StrSubstitute{\cnncaption}{mlp}{MLP}[\mlpcaption]%
    \begin{figure}[H]
        \centering
        \includegraphics[width=\textwidth]{histograms/\path.png}
        \caption{\mlpcaption}
        \label{fig:#3}
    \end{figure}
    \begin{table}[H]
        \centering
        {\small \input{chapters/tables/\path.tex}}
        \caption{\mlpcaption}
        \label{tab:#3}
    \end{table}
}

\NewDocumentCommand{\comparisonhistogram}{mmmmG{}}{
    %
    % #1 -> Metric
    % #2 -> Models
    % #3 -> Caption
    % #4 -> Label
    % #5 -> Grouping, optional
    %
    \histogram{#1, comparison between #2 models#5}{#3}{#4}
}

\NewDocumentCommand{\groupedcomparisonhistogram}{mmmmm}{
    %
    % #1 -> Metric
    % #2 -> Group
    % #3 -> Models
    % #4 -> Caption
    % #5 -> Label
    %
    \comparisonhistogram{#1}{#3}{#4}{#5}{, grouped by #2}
}


\NewDocumentCommand{\modecomparisonhistogram}{mmmmm}{
    %
    % #1 -> Metric
    % #2 -> Mode
    % #3 -> Models
    % #4 -> Caption
    % #5 -> Label
    %
    \comparisonhistogram{#1 for \getnthbalancingmode{#2} mode}{#3}{#4}{#5}
}

\makeatletter
\patchcmd{\@makechapterhead}{\vspace*{50\p@}}{}{}{}
%\patchcmd{\@makeschapterhead}{\vspace*{100\p@}}{}{}{}
\makeatother

\newcommand{\funcdef}[3]{#1:#2\longrightarrow #3}
\newcommand{\R}{\mathbb{R}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\abs}[1]{\left\lvert#1\right\rvert}
\newcommand{\norm}[1]{\left\lVert#1\right\rVert}
\newcommand{\rnd}[1]{\left(#1\right)}
\newcommand{\sqr}[1]{\left[#1\right]}
\newcommand{\ssqr}[1]{\llbracket#1\rrbracket}
\newcommand{\crl}[1]{\left\{#1\right\}}

% STANDARD SEQUENT
\newcommand{\emptySet}{\cdot}
\newcommand{\seqsArrow}{\vdash}
\newcommand{\seqs}[2]{
    \ifthenelse{\isempty{#1}}{\emptySet}{#1} % left 
    \seqsArrow
    \ifthenelse{\isempty{#2}}{\emptySet}{#2}
}

\newcommand{\seqslj}[2]{
    \ifthenelse{\isempty{#1}}{\emptySet}{#1} % left 
    \Rightarrow
    \ifthenelse{\isempty{#2}}{\emptySet}{#2}
}

\newcommand{\Lhs}[1]{\mathrm{Lhs}(#1)} % left side  of seq.
\newcommand{\Rhs}[1]{\mathrm{Rhs}(#1)} % right side of seq.

% LOGICS AND CALCOLI
\newcommand{\CPL}{\mathrm{CPL}\xspace}
\newcommand{\IPL}{\mathrm{IPL}\xspace}
\newcommand{\GD}[1]{\mathrm{GD}_{#1}\xspace}
\newcommand{\LC}{\mathrm{LC}\xspace}
\newcommand{\RBU}{\mathbf{Rbu}\xspace}
\newcommand{\FRJname}{\mathbf{FRJ}\xspace} % Frj 
\newcommand{\FRJof}[1]{\mathbf{FRJ}(#1)\xspace} % Frj(G)
\newcommand{\GBUof}[1]{\mathbf{Gbu}(#1)\xspace} % Gbu(G)
%%%\newcommand{\GBUof}[1]{\mathbf{Gbu}\xspace} % Gbu - G non viene visualizzato
\newcommand{\GBUTab}{\mathbf{Gbu}\xspace} % Gbu(G)
\newcommand{\SF}{\mathbf{S4}}
\newcommand{\SV}{\mathbf{S5}}
\newcommand{\KL}{\mathbf{K}}

% FRDUM SEQUENT
\newcommand{\seqfrdArrow}{\nRightarrow}

\newcommand{\seqfrd}[4]{
    \ifthenelse{\isempty{#2}}{\emptySet}{#2}
    \seqfrdArrow_{#1}
    \ifthenelse{\isempty{#3}}{\emptySet}{#3}
    \,;\,
    \ifthenelse{\isempty{#4}}{\emptySet}{#4}
}

\newcommand{\tseqfrd}[4]{
    \ifthenelse{\isempty{#2}}{\emptySet}{#2}
    & \; \seqfrdArrow_{#1}\;
    \ifthenelse{\isempty{#3}}{\emptySet}{#3}
    \,;\,
    \ifthenelse{\isempty{#4}}{\emptySet}{#4}
}

%%  RULE NAMES
\newcommand{\ruleAX}{\mathrm{Ax}\xspace}
\newcommand{\ruleS}{\mathrm{Succ}\xspace}

% LOGICAL SYMBOLS
\newcommand{\imp}{\supset}
\newcommand{\proves}[3]{\vdash^{#1}_{#2} #3}
\newcommand{\nproves}[2]{{\not\vdash}_{#1} #2}

% KRIPKE MODELS
\newcommand{\K}{\Kcal}
\newcommand{\forcing}{\Vdash}
\newcommand{\forcings}{\Vdash^*}
\newcommand{\nforcing}{\nVdash}
\newcommand{\nforcings}{\nVdash^*}
\newcommand{\Modname}{\mathrm{Mod}}
\newcommand{\Mod}[1]{\Modname(#1)}
\newcommand{\Rcalc}[1]{\mathbf{R{\mbox{\smallfont {\bf GD}}}}(#1)}

% CALLIGRAPHICS
\newcommand{\Acal}{\mathcal{A}}
\newcommand{\Bcal}{\mathcal{B}}
\newcommand{\Ccal}{\mathcal{C}}
\newcommand{\Dcal}{\mathcal{D}}
\newcommand{\Ecal}{\mathcal{E}}
\newcommand{\Fcal}{\mathcal{F}}
\newcommand{\Gcal}{\mathcal{G}}
\newcommand{\Hcal}{\mathcal{H}}
\newcommand{\Kcal}{\mathcal{K}}
\newcommand{\Ical}{\mathcal{I}}
\newcommand{\Jcal}{\mathcal{J}}
\newcommand{\Lcal}{\mathcal{L}}
\newcommand{\Mcal}{\mathcal{M}}
\newcommand{\Ncal}{\mathcal{N}}
\newcommand{\Pcal}{\mathcal{P}}
\newcommand{\Qcal}{\mathcal{Q}}
\newcommand{\Rcal}{\mathcal{R}}
\newcommand{\Scal}{\mathcal{S}}
\newcommand{\Tcal}{\mathcal{T}}
\newcommand{\Vcal}{\mathcal{V}}
\newcommand{\Xcal}{\mathcal{X}}
\newcommand{\Ycal}{\mathcal{Y}}

% GREEKS
\renewcommand{\a}{\alpha}
\renewcommand{\b}{\beta}
\newcommand{\g}{\gamma}
\renewcommand{\d}{\delta}
\newcommand{\s}{\sigma}
\newcommand{\D}{\Delta}
\newcommand{\G}{\Gamma}

% MATHBF
\newcommand{\Cbo}{\mathbf{C}}

\newcommand{\EndEs}{\mbox{}~\hfill$\Diamond$}

% GENERIC MATH
\newcommand{\stru}[1]{\langle #1 \rangle} % struttura


% FUNCTIONS 
\newcommand{\depth}[1]{\mathrm{d}(#1)}  %
\newcommand{\wgname}{\mathrm{wg}}
\newcommand{\wg}[1]{\wgname(#1)}
\newcommand{\tp}[1]{\mathrm{tp}(#1)}
\newcommand{\tpm}[1]{\mathrm{tp}^-(#1)}
\newcommand{\card}[1]{||#1||}
\newcommand{\size}[1]{| #1|}
\newcommand{\height}[1]{\mathrm{h}(#1)}
\newcommand{\Star}[1]{(#1)^*}
\newcommand{\Sat}[2]{\mathrm{Sat}_{#1}(#2)}

% NAMES FOR SETS and funztions
\newcommand{\PV}{\mbox{$\mathcal{V}$}\xspace} % Prop. variables
\newcommand{\Prime}{\PV^\bot\xspace}  % Prime formuals

% subformulas
\newcommand{\Sf}[1]{\mathrm{Sf}(#1)}
\newcommand{\Sfat}[1]{\mathrm{Sf}^{\mathrm{At}}(#1)}

\newcommand{\Sfgname}{\mathscr{Sx}}
\newcommand{\Sfg}[1]{\Sfgname(#1)}
% \newcommand{\Sfm}[1]{\mathrm{Sf}^-(#1)}
\newcommand{\Sflname}{\mathscr{Sl}}
\newcommand{\Sfl}[1]{\Sflname(#1)}
\newcommand{\Sflat}[1]{\Sflname^{\mathrm{At}}(#1)}
\newcommand{\Sflimp}[1]{\Sflname^{\imp}(#1)}
\newcommand{\Sflatimp}[1]{\Sflname^{\mathrm{At},\imp}(#1)}
\newcommand{\Sfrname}{\mathscr{Sr}}
\newcommand{\Sfr}[1]{\Sfrname(#1)}
\newcommand{\Sfrat}[1]{\Sfrname^{\mathrm{At}}(#1)}
\newcommand{\Sfrimp}[1]{\Sfrname^{\imp}(#1)}
\newcommand{\Sfratimp}[1]{\Sfrname^{\mathrm{At},\imp}(#1)}
\newcommand{\Sfgat}[1]{\Sfgname^{\mathrm{At}}(#1)}
\newcommand{\Sfgimp}[1]{\Sfgname^{\imp}(#1)}
\newcommand{\Sfgatimp}[1]{\Sfgname^{\mathrm{At},\imp}(#1)}

\newcommand{\Gat}{\G^{\mathrm{At}}}
\newcommand{\Dat}{\D^{\mathrm{At}}}
\newcommand{\Lat}{\Lambda^{\mathrm{At}}}
\newcommand{\Gimp}{\G^\imp}
\newcommand{\Oat}{\Omega^{\mathrm{At}}}
\newcommand{\Oimp}{\Omega^{\mathrm{\imp}}}
\newcommand{\Xat}{\Xi^{\mathrm{At}}}
\newcommand{\Ximp}{\Xi^{\mathrm{\imp}}}
\newcommand{\bG}{{\overline\G}}
\newcommand{\bD}{{\overline\D}}
\newcommand{\bGat}{{\overline\G}^{\mathrm{At}}}
\newcommand{\bGimp}{{\overline\G}^\imp}
\newcommand{\bDat}{{\overline\D}^{\mathrm{At}}}
\newcommand{\bDimp}{{\overline\D}^\imp}
% \newcommand{\Dat}{{\D}^{\mathrm{At}}}
% \newcommand{\Gat}{{\G}^{\mathrm{At}}}

\newcommand{\That}{\Theta^{\mathrm{At}}}
\newcommand{\Omegaat}{\Omega^{\mathrm{At}}}
\newcommand{\Omegaimp}{\Omega^{\imp}}
\newcommand{\Thimp}{\Theta^\imp}
\newcommand{\Thimpt}{{\tilde{\Theta}}^\imp}
\newcommand{\Sigat}{\Sigma^{\mathrm{At}}}
\newcommand{\Sigimp}{\Sigma^\imp}
%\newcommand{\Lat}{\Lambda^{\mathrm{At}}}
\newcommand{\Limp}{\Lambda^\imp}
\newcommand{\Lambdas}{\Lambda^*}
\newcommand{\Lambdasi}{\Lambda^{*_\imp}}
\newcommand{\Fmimp}{\Lcal^\imp}

\newcommand{\Clop}[1]{\Ccal l^+(#1)}
\newcommand{\Clom}[1]{\Ccal l^-(#1)}
%\newcommand{\Clog}[1]{\overline{\Ccal l}(#1)}
%\newcommand{\Restr}[2]{#1/#2}

\newcommand{\PS}[1]{\mathrm{P}(#1)}

\newcommand{\mapstoz}{\mapsto_0}
\newcommand{\mapstozn}{\stackrel{-}{\mapsto}_0}
\newcommand{\mapstozr}[1]{\stackrel{#1}{\mapsto_0}}
\newcommand{\mapston}{\stackrel{-}{\mapsto}}
\newcommand{\mapstos}{\mapsto_*}
\newcommand{\mapstosn}{\stackrel{-}{\mapsto}_*}
\newcommand{\mapstois}{\mapsto^\mathtt{Ir}_*}

\newcommand{\Upsilonat}{\Upsilon^{\mathrm{At}}}
\newcommand{\Upsilonimp}{\Upsilon^\imp}
\newcommand{\Omat}{\Omega^{\mathrm{At}}}
\newcommand{\Omimp}{\Omega^\imp}
\newcommand{\Uat}{\Upsilon^{\mathrm{At}}}
\newcommand{\Uimp}{\Upsilon^\imp}

\newcommand{\Psiat}{\Psi^{\mathrm{At}}}
\newcommand{\Psiimp}{\Psi^\imp}

%% Macro for algorithm2e
\newcommand{\ass}{\;\leftarrow\;}

\makeatletter  %% used in align 
\newcommand{\leqnomode}{\tagsleft@true}
\newcommand{\reqnomode}{\tagsleft@false}
\makeatother

%%% MODELLI DI KRIPKE
\newcommand{\Val}{V}