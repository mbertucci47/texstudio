# jsbook class
# Matthew Bertucci 2023/02/12 for v2023/02/12

#include:platex
#include:jslogo

#keyvals:\documentclass/jsbook#c
a3paper
a4paper
a5paper
a6paper
b4paper
b5paper
b6paper
a4j
a5j
b4j
b5j
a4var
b5var
letterpaper
legalpaper
executivepaper
landscape
8pt
9pt
10pt
11pt
12pt
14pt
17pt
20pt
21pt
25pt
30pt
36pt
43pt
12Q
14Q
10ptj
10.5ptj
11ptj
12ptj
usemag
nomag
nomag*
tombow
tombo
mentuke
oneside
twoside
vartwoside
onecolumn
twocolumn
titlepage
notitlepage
openright
openleft
openany
leqno
fleqn
disablejfam
draft
final
mingoth
jis
platex
uplatex
autodetect
papersize
english
report
jslogo
nojslogo
#endkeyvals

#ifOption:tombow
\stockheight#L
\stockwidth#L
#endif
#ifOption:tombo
\stockheight#L
\stockwidth#L
#endif
#ifOption:mentuke
\stockheight#L
\stockwidth#L
#endif

#ifOption:nomag*
#include:type1cm
#endif

#ifOption:uplatex
#include:uplatex
#endif

\alsoname#*
\backmatter
\bibname
\chapter*{title}#L1
\chapter[short title]{title}#L1
\chapter{title}#L1
\chaptermark{code}#*
\Cjascale
\everyparhook#*
\frontmatter
\fullwidth#L
\headfont#*
\heisei#*
\HUGE
\ifjisfont#*
\ifmingoth#*
\ifnarrowbaselines#*
\ifpapersize#*
\if西暦#*
\jisfontfalse#*
\jisfonttrue#*
\jsParagraphMark#*
\jsTocLine#*
\mainmatter
\mingothfalse#*
\mingothtrue#*
\narrowbaselines
\narrowbaselinesfalse#*
\narrowbaselinestrue#*
\papersizefalse#*
\papersizetrue#*
\plainifnotempty#*
\postchaptername#*
\postpartname#*
\postsectionname#*
\prechaptername#*
\prepartname#*
\presectionname#*
\seename#*
\thechapter#*
\theHchapter#*
\widebaselines
\上小{text}
\和暦
\小{text}
\西暦
\西暦false#*
\西暦true#*

# deprecated
\mc#S
\gt#S
