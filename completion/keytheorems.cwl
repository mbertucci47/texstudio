# keytheorems package
# Matthew Bertucci 2024/09/12 for v0.1.1

#include:aliascnt
#include:amsthm
#include:refcount
#include:translations

#keyvals:\usepackage/key-theorems#c
overload
thmtools-compat
store-all
#endkeyvals

#ifOption:thmtools-compat
\declaretheorem{envname}#N
\declaretheorem[options%keyvals]{envname}#N
\declaretheoremstyle{style}
\declaretheoremstyle[options%keyvals]{style}
\begin{restatable}{envname}{tag}
\begin{restatable}[options%keyvals]{envname}{tag}
\end{restatable}
\listoftheorems
\listoftheorems[options%keyvals]
\addtotheorempreheadhook{code}#*
\addtotheorempreheadhook[envname]{code}#*
\addtotheorempostheadhook{code}#*
\addtotheorempostheadhook[envname]{code}#*
\addtotheoremprefoothook{code}#*
\addtotheoremprefoothook[envname]{code}#*
\addtotheorempostfoothook{code}#*
\addtotheorempostfoothook[envname]{code}#*
#endif

\keytheoremset{options%keyvals}

#keyvals:\usepackage/keytheorems#c,\keytheoremset#c
overload
thmtools-compat
store-all
restate-counter
qed-symbol=%<symbol%>
auto-translate#true,false
#endkeyvals

#keyvals:\keytheoremset#c
continues-code=%<code%>
#endkeyvals

\newkeytheorem{envname}#N
\newkeytheorem{envname}[options%keyvals]#N

#keyvals:\newkeytheorem#c,\declaretheorem#c
name=%<display name%>
numbered=#true,false,unless-unique
parent=%<counter%>
sibling=%<counter%>
preheadhook=%<code%>
postheadhook=%<code%>
prefoothook=%<code%>
postfoothook=%<code%>
refname=%<ref name%>
Refname=%<ref name%>
qed
qed=%<symbol%>
tcolorbox
tcolorbox={%<tcolorbox options%>}
tcolorbox-no-titlebar
tcolorbox-no-titlebar={%<tcolorbox options%>}
#endkeyvals

\newkeytheoremstyle{style}{options%keyvals}#s#%keytheoremstyle
\renewkeytheoremstyle{style}{options%keyvals}
\providekeytheoremstyle{style}{options%keyvals}#s#%keytheoremstyle
\declarekeytheoremstyle{style}{options%keyvals}#s#%keytheoremstyle

#keyvals:\newkeytheoremstyle#c,\renewkeytheoremstyle#c,\providekeytheoremstyle#c,\declarekeytheoremstyle#c,\declaretheoremstyle#c
spaceabove=##L
spacebelow=##L
bodyfont=%<font commands%>
headindent=##L
headfont=%<font commands%>
headpunct=%<code%>
postheadspace=##L
break
notefont=%<font commands%>
notebraces={%<left brace%>}{%<right brace%>}
headstyle=#margin,swapnumber,%<code%>
inherit-style=%<style name%>
#endkeyvals

\NAME#*
\NUMBER#*
\NOTE#*

\getkeytheorem{tag}
\getkeytheorem[property%keyvals]{tag}

#keyvals:\getkeytheorem#c
body
#endkeyvals

\IfRestatingTF{true}{false}#*

\listofkeytheorems
\listofkeytheorems[options%keyvals]
\keytheoremlistset{options%keyvals}

#keyvals:\listofkeytheorems#c,\keytheoremlistset#c,\listoftheorems#c
numwidth=##L
ignore={%<env1,env2,...%>}
show={%<env1,env2,...%>}
onlynamed
onlynamed={%<env1,env2,...%>}
ignoreall
showall
title=%<text%>
swapnumber#true,false
onlynumbered
onlynumbered={%<env1,env2,...%>}
seq=%<name%>
title-code=%<code%>
no-title#true,false
note-code=%<code%>
print-body
no-continues#true,false
no-chapter-skip#true,false
chapter-skip-length=##L
#endkeyvals

\addtheoremcontentsline{level}{text}#*
\addtotheoremcontents{code}#*

\addtotheoremhook{hook name}{code}
\addtotheoremhook[envname]{hook name}{code}

\Autoref{label}#r
\Autoref*{label}#r