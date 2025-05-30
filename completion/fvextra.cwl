# fvextra package
# Matthew Bertucci 2025/05/15 for v1.13.0

#include:etoolbox
#include:fancyvrb
#include:pdftexcmds
#include:upquote
#include:lineno

#keyvals:\Verb,\Verb*,\DefineShortVerb,\begin{Verbatim},\begin{Verbatim*},\begin{BVerbatim},\begin{BVerbatim*},\begin{LVerbatim},\begin{LVerbatim*},\fvset,\DefineVerbatimEnvironment,\CustomVerbatimEnvironment,\RecustomVerbatimEnvironment,\CustomVerbatimCommand,\RecustomVerbatimCommand,\SaveVerb,\SaveVerb*,\UseVerb,\UseVerb*,\begin{SaveVerbatim},\UseVerbatim,\BUseVerbatim,\LUseVerbatim,\VerbatimInput,\BVerbatimInput,\LLVerbatimInput,\fvinlineset,\EscVerb,\EscVerb*,\begin{VerbEnv},\VerbatimInsertBuffer,\VerbatimClearBuffer,\InsertBuffer,\ClearBuffer,\IterateBuffer,\RobustVerb,\RobustVerb*,\RobustUseVerb,\RobustUseVerb*,\RobustEscVerb,\RobustEscVerb*
backgroundcolor=#%color
backgroundcolorboxoverlap=##L
backgroundcolorpadding=##L
backgroundcolorvphantom=%<macro%>
bgcolor=#%color
bgcolorboxoverlap=##L
bgcolorpadding=##L
bgcolorvphantom=%<macro%>
beameroverlays#true,false
curlyquotes#true,false
extra#true,false
fontencoding=%<encoding%>
highlightcolor=#%color
highlightlines={%<line ranges%>}
linenos#true,false
mathescape#true,false
numberfirstline#true,false
numbers=#none,left,right,both
retokenize#true,false
space=%<macro%>
spacecolor=#%color
stepnumberfromfirst#true,false
stepnumberoffsetvalues#true,false
tab=%<macro%>
tabcolor=#%color
vargsingleline#true,false
breakafter=%<string%>
breakafterinrun#true,false
breakaftersymbolpre=%<string%>
breakaftersymbolpost=%<string%>
breakanywhere#true,false
breakanywheresymbolpre=%<string%>
breakanywhereinlinestretch=##L
breakanywheresymbolpost=%<string%>
breakautoindent#true,false
breakbefore=%<string%>
breakbeforeinrun#true,false
breakbeforesymbolpre=%<string%>
breakbeforesymbolpost=%<string%>
breakcollapsespaces#true,false
breakindent=##L
breakindentnchars=%<integer%>
breaklines#true,false
breaknonspaceingroup#true,false
breakpreferspaces#true,false
breaksymbol=%<string%>
breaksymbolleft=%<string%>
breaksymbolright=%<string%>
breaksymbolindent=##L
breaksymbolindentnchars=%<integer%>
breaksymbolindentleft=##L
breaksymbolindentleftnchars=%<integer%>
breaksymbolindentright=##L
breaksymbolindentrightnchars=%<integer%>
breaksymbolsep=##L
breaksymbolsepnchars=%<integer%>
breaksymbolsepleft=##L
breaksymbolsepleftnchars=%<integer%>
breaksymbolsepright=##L
breaksymbolseprightnchars=%<integer%>
spacebreak=%<macro%>
breakbytoken#true,false
breakbytokenanywhere#true,false
texcomments#true,false
#endkeyvals

\fvinlineset{options%keyvals}

# keys from fancyvrb for fvextra commands
#keyvals:\fvinlineset,\EscVerb,\EscVerb*,\begin{VerbEnv},\VerbatimInsertBuffer,\VerbatimClearBuffer,\InsertBuffer,\ClearBuffer,\IterateBuffer,\RobustVerb,\RobustVerb*,\RobustUseVerb,\RobustUseVerb*,\RobustEscVerb,\RobustEscVerb*
commentchar=%<single char%>
gobble=%<integer%>
formatcom=%<commands%>
formatcom*=%<commands%>
fontfamily=%<family%>
fontsize=%<size macro%>
fontshape=%<shape%>
fontseries=%<series%>
frame=#none,leftline,topline,bottomline,lines,single
framerule=##L
framesep=##L
rulecolor=%<color cmd%>
fillcolor=%<color cmd%>
label=%<label text%>
labelposition=#none,topline,bottomline,all
numbers=#none,left,right
numbersep=##L
firstnumber=%<auto|last|<integer>%>
stepnumber=%<integer%>
numberblanklines#true,false
firstline=%<integer%>
lastline=%<integer%>
showspaces#true,false
showtabs#true,false
obeytabs#true,false
tabsize=%<integer%>
baselinestretch=%<factor%>
commandchars=%<three chars%>
xleftmargin=##L
xrightmargin=##L
resetmargins#true,false
hfuzz=##L
samepage#true,false
codes={%<code%>}
codes*={%<code%>}
defineactive={%<code%>}
defineactive*={%<code%>}
reflabel=##l
fileext=%<extension%>
vspace=##L
listparameters={%<code%>}
#endkeyvals

# the aftersave key also makes sense in \fvinlineset
#keyvals:\fvinlineset
aftersave={%<code%>}
#endkeyvals

\FancyVerbFormatInline{text%plain}#*
\FancyVerbFormatText#*

\EscVerb{backslash-escaped text}
\EscVerb[options%keyvals]{backslash-escaped text}
\EscVerb*{backslash-escaped text}
\EscVerb*[options%keyvals]{backslash-escaped text}

\begin{VerbEnv}#V
\begin{VerbEnv}[options%keyvals]#V
\end{VerbEnv}

\begin{VerbatimWrite}#V
\begin{VerbatimWrite}[options%keyvals]#V
\end{VerbatimWrite}

#keyvals:\begin{VerbatimWrite}
writefilehandle=%<file handle%>
writer=%<macro%>
#endkeyvals

\FancyVerbWriteFileHandle#*
\FancyVerbDefaultWriter#*

\begin{VerbatimBuffer}#V
\begin{VerbatimBuffer}[options%keyvals]#V
\end{VerbatimBuffer}

\FancyVerbDefaultBufferer#*
\FancyVerbBufferLineName#*

\VerbatimInsertBuffer
\VerbatimInsertBuffer[options%keyvals]
\VerbatimClearBuffer
\VerbatimClearBuffer[options%keyvals]
\InsertBuffer
\InsertBuffer[options%keyvals]
\ClearBuffer
\ClearBuffer[options%keyvals]
\BufferMdfivesum
\IterateBuffer{macro}
\IterateBuffer[options%keyvals]{macro}
\IterateBufferBreak#*
\WriteBuffer
\WriteBuffer[options%keyvals]

#keyvals:\begin{VerbatimBuffer},\VerbatimInsertBuffer,\VerbatimClearBuffer,\InsertBuffer,\ClearBuffer,\IterateBuffer,\fvset
afterbuffer=%<macro%>
bufferer=%<macro%>
bufferlengthname=%<string%>
bufferlinename=%<string%>
buffername=%<string%>
globalbuffer#true,false
#endkeyvals

#keyvals:\VerbatimInsertBuffer,\InsertBuffer
insertenvname=%<string%>
wrapperenvname=%<envname%>
wrapperenvopt=%<optional argument%>
wrapperenvarg=%<argument%>
#endkeyvals

\FancyVerbBreakStart#*
\FancyVerbBreakStop#*
\FancyVerbBreakAnywhereBreak#*
\FancyVerbBreakBeforeBreak#*
\FancyVerbBreakAfterBreak#*
\FancyVerbBreakByTokenAnywhereBreak#*

\VerbatimPygments{literal macro%cmd}{actual macro%cmd}#*

FancyVerbHighlightColor#B

\FVExtraAlwaysUnexpanded{arg}#*
\FVExtraDetokenizeEscVArg{arg1}{arg2}#*
\FVExtraDetokenizeREscVArg{arg1}{arg2}#*
\FVExtraDetokenizeVArg{arg1}{arg2}#*
\FVExtraDoSpecials#*
\FVExtraEscapedVerbatimDetokenize{arg}#*
\FVExtraPDFStringEscapeChars{arg}#*
\FVExtraPDFStringEscapeChar{arg}#*
\FVExtraPDFStringEscapedVerbatimDetokenize{arg}#*
\FVExtraPDFStringVerbatimDetokenize{arg}#*
\FVExtraReadOArgBeforeVArg[opt]{arg}#*
\FVExtraReadOArgBeforeVArg{arg}#*
\FVExtraReadOArgBeforeVEnv[opt]{arg}#*
\FVExtraReadOArgBeforeVEnv{arg}#*
\FVExtraReadVArgSingleLine{arg}#*
\FVExtraReadVArg{arg}#*
\FVExtraRetokenizeVArg{macro%cmd}{code}{chars}#*d
\FVExtraRobustCommand{arg1}{arg2}#*
\FVExtraSaveCodes[package]{name}#*
\FVExtraSaveCodes{name}#*
\FVExtraUnexpandedReadStarOArgBEscVArg{arg}#*
\FVExtraUnexpandedReadStarOArgBVArg{arg}#*
\FVExtraUnexpandedReadStarOArgMArgBVArg{arg}#*
\FVExtraUnexpandedReadStarOArgMArg{arg}#*
\FVExtraUseCodes[package]{name}#*
\FVExtraUseCodes{name}#*
\FVExtraUseVerbUnexpandedReadStarOArgMArg{arg}#*
\FVExtraVerbatimDetokenize{arg}#*
\FVExtrapdfstringdefDisableCommands#*
\FVExtrapdfstringdef{arg1}{arg2}#*
\FancyVerbBackgroundColor#*
\FancyVerbBackgroundColorPadding#*
\FancyVerbBackgroundColorVPhantom#*
\FancyVerbBeamerOverlays#*
\FancyVerbBreakAfterSymbolPost#*
\FancyVerbBreakAfterSymbolPre#*
\FancyVerbBreakAnywhereSymbolPost#*
\FancyVerbBreakAnywhereSymbolPre#*
\FancyVerbBreakBeforeSymbolPost#*
\FancyVerbBreakBeforeSymbolPre#*
\FancyVerbBreakSymbolLeft#*
\FancyVerbBreakSymbolLeftLogic{arg}#*
\FancyVerbBreakSymbolRight#*
\FancyVerbBreakSymbolRightLogic{arg}#*
\FancyVerbBufferDepth#*
\FancyVerbBufferIndex#*
\FancyVerbBufferLengthName#*
\FancyVerbCurlyQuotes#*
\FancyVerbFillColor#*
\FancyVerbHighlightColor#*
\FancyVerbHighlightLineFirst{arg}#*
\FancyVerbHighlightLineLast{arg}#*
\FancyVerbHighlightLineMiddle{arg}#*
\FancyVerbHighlightLineNormal{arg}#*
\FancyVerbHighlightLineSingle{arg}#*
\FancyVerbHighlightLine{arg}#*
\FancyVerbMathEscape#*
\FancyVerbRestoreCodes#*
\FancyVerbSpaceBreak#*
\RobustEscVerb*[options%keyvals]{backslash-escaped text}#*
\RobustEscVerb*{backslash-escaped text}#*
\RobustEscVerb[options%keyvals]{backslash-escaped text}#*
\RobustEscVerb{backslash-escaped text}#*
\RobustUseVerb*[options%keyvals]{name}#*
\RobustUseVerb*{name}#*
\RobustUseVerb[options%keyvals]{name}#*
\RobustUseVerb{name}#*
\RobustVerb*|%<code%>|#*
\RobustVerb*[%<options%>]|%<code%>|#*
\RobustVerb*[options%keyvals]{verbatimSymbol}#S
\RobustVerb|%<code%>|#*
\RobustVerb[%<options%>]|%<code%>|#*
\RobustVerb[options%keyvals]{verbatimSymbol}#S
\theFancyVerbLineBreakLast#*
