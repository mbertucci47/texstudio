# longdivision package
# Matthew Bertucci 9/16/2021 for v1.0

\longdivision{dividend}{divisor}
\longdivision[options%keyvals]{dividend}{divisor}
\intlongdivision{dividend}{divisor}
\intlongdivision[options%keyvals]{dividend}{divisor}
\longdivisionkeys{options%keyvals}

#keyvals:\longdivision,\intlongdivision,\longdivisionkeys
max extra digits=%<integer%>
stage=%<integer%>
style=#default,standard,tikz,german
repeating decimal style=#overline,dots,dots all,parentheses,none#c
decimal separator=%<character%>
digit separator=%<character%>
digit group length=%<integer%>
separators in work#true,false
german division sign=
#endkeyvals

\longdivisiondefinestyle{style name}{definition}#*