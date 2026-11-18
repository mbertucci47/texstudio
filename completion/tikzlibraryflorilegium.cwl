# florilegium tikzlibrary
# Matthew Bertucci 2026/11/13 for v2.0.1

#include:tikzlibraryfpu

\florilegiumspecies[options%keyvals]{seed}{role}
\florilegiumspecies{seed}{role}
\florilegiumtrait{trait}
\florilegiumvisitor[traits]{seed}{role}
\florilegiumvisitortrait{trait}
\florilegiumvisitor{seed}{role}

\florilegiumspecieslogfalse#S
\florilegiumspecieslogtrue#S
\ifflorilegiumspecieslog#S