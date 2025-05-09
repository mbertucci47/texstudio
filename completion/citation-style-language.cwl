# citation-style-language package
# Matthew Bertucci 2025/04/28 for v0.8.0

#include:filehook
#include:url

\cslsetup{options%keyvals}

#keyvals:\cslsetup,\usepackage/citation-style-language#c
regression-test#true,false
style=#american-chemical-society,american-medical-association,american-political-science-association,american-sociological-association,apa,chicago-author-date,chicago-fullnote-bibliography,chicago-note-bibliography,elsevier-harvard,harvard-cite-them-right,ieee,modern-humanities-research-association,modern-language-association,nature,vancouver
bib-resource=%<resource%>
locale=%<language code%>
ref-section=#none,part,chapter,chapter+,section,section+,subsection,subsection+
backref=#true,page,section,false
bib-font=%<font commands%>
bib-entry-page-break#true,false
bib-item-sep=%<<length> or <glue>%>
bib-hang=##L
bib-par-indent=##L
prefix-separator=%<separator%>
suffix-separator=%<separator%>
#endkeyvals

\addbibresource{bib file}
\addbibresource[options%keyvals]{bib file}

#keyvals:\addbibresource
journal-abbreviation#true,false
#endkeyvals

\cite[options%keyvals]{keylist}
\cite*[options%keyvals]{keylist}
\parencite{keylist}#*
\parencite[options%keyvals]{keylist}#*
\parencite*{keylist}#*
\parencite*[options%keyvals]{keylist}#*
\citep{keylist}#*
\citep[options%keyvals]{keylist}#*
\textcite{keylist}
\textcite[options%keyvals]{keylist}
\citet{keylist}#*
\citet[options%keyvals]{keylist}#*
\footcite{keylist}
\footcite[options%keyvals]{keylist}
\cites{%<key1%>}{%<key2%>}%<...{keyN}%>
\cites[%<options%>]{%<key1%>}[%<options%>]{%<key2%>}%<...[options]{keyN}%>
\citeauthor{keylist}
\citeyear{keylist}
\citeyearpar{keylist}
\citeyearpar[options%keyvals]{keylist}
\fullcite{keylist}
\fullcite[options%keyvals]{keylist}

#keyvals:\cite,\cite*,\parencite,\parencite*,\citep,\textcite,\citet,\cites,\citeyearpar,\citeyearpar*,\fullcite
prefix=%<text%>
suffix=%<text%>
act=%<number%>
appendix=%<number%>
article=%<number%>
book=%<number%>
canon=%<number%>
chapter=%<number%>
column=%<number%>
elocation=%<number%>
equation=%<number%>
figure=%<number%>
folio=%<number%>
infix=%<text%>
issue=%<number%>
line=%<number%>
note=%<number%>
opus=%<number%>
page=%<number%>
paragraph=%<number%>
part=%<number%>
rule=%<number%>
scene=%<number%>
section=%<number%>
sub-verbo=%<number%>
supplement=%<number%>
table=%<number%>
timestamp=%<number%>
title=%<number%>
unsorted#true,false
verse=%<number%>
version=%<number%>
volume=%<number%>
#endkeyvals

\printbibliography
\printbibliography[options%keyvals]

#keyvals:\printbibliography
heading=%<text%>
title=%<text%>
prenote=%<text%>
postnote=%<text%>
type=%<entry type%>
nottype=%<entry type%>
keyword=%<keyword%>
notkeyword=%<keyword%>
category=%<category%>
notcategory=%<category%>
#endkeyvals

\begin{refsection}
\begin{refsection}[options%keyvals]
\end{refsection}
\newrefsection
\newrefsection[options%keyvals]
\endrefsection

#keyvals:\begin{refsection},\newrefsection
style=%<style id%>
bib-resource=%<resource%>
locale=%<language code%>
#endkeyvals

\defbibheading{name}{code}#*
\defbibheading{name}[title%text]{code}#*

# not documented
\addtocategory{category}{keys%plain}#S
\autocite{keylist}#S
\autocite[options%keyvals]{keylist}#S
\backref{arg}#S
\cslcitation{arg1}{arg2}#S
\cslcite{arg1}{arg2}#S
\csloptions{arg1}{arg2}#S
\cslundefinedcite{arg}#S
\DeclareBibliographyCategory{category}#S
\defbibenvironment{name}{begdef}{enddef}{item code}#S
\defbibnote{name}{text}#S
\parencites{%<key1%>}{%<key2%>}%<...{keyN}%>#S
\parencites[%<options%>]{%<key1%>}[%<options%>]{%<key2%>}%<...[options]{keyN}%>#S
\printbibheading#S
\printbibheading[options%keyvals]#S
#keyvals:\printbibheading
heading=%<text%>
title=%<text%>
#endkeyvals
