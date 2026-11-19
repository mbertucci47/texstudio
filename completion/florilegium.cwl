# florilegium package
# Matthew Bertucci 2026/11/19 for v2.1.0

#include:luatex
#include:tikz
#include:eso-pic

#keyvals:\usepackage/florilegium#c
aging
authored
grown
headpieces
intensity=%<factor%>
nomargin
noshells
novisitors
sections
theme=#geometric,math,shells
#endkeyvals

\florilegiumage{factor}
\florilegiumbloom
\florilegiumbloom[type]
\florilegiumdraw{type}{number}
\florilegiumframe[opt]{k}{n}
\florilegiumframe{k}{n}
\florilegiumheadpiece
\florilegiumheadpiece[options%keyvals]
\florilegiumhide
\florilegiumhide[pages]
\florilegiuminitial[lines]{letter}
\florilegiuminitialfont{font file%file}
\florilegiuminitialframe{type}
\florilegiuminitial{letter}
\florilegiumoff
\florilegiumon
\florilegiumornament{type}
\florilegiumseed#*
\florilegiumtextend
\florilegiumtheme{theme}

accent#B
ink#B
