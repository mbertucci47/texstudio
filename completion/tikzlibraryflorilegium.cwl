# florilegium tikzlibrary
# Matthew Bertucci 2026/11/19 for v2.1.0

#include:tikzlibraryfpu

\florilegiumspecies[options%keyvals]{seed}{role}
\florilegiumspecies{seed}{role}
\florilegiumtrait{trait}
\florilegiumvisitor[traits]{seed}{role}
\florilegiumvisitortrait{trait}
\florilegiumvisitor{seed}{role}
\florilegiumtracery{seed}{role}
\florilegiumshell{seed}{role}
\florilegiumtracerytrait{trait}
\florilegiumshelltrait{trait}

\florilegiumspecieslogfalse#S
\florilegiumspecieslogtrue#S
\ifflorilegiumspecieslog#S