# tudscrposter class
# Matthew Bertucci 2022/08/15 for v2.06o

#include:tudscrbase
#include:class-scrartcl
#include:environ
#include:graphicx
#include:tudscrcolor
#include:mathastext
#include:newunicodechar
#include:bm
#include:geometry
#include:scrlayer-scrpage

#keyvals:\TUDoptions#c
cdfont=%<Einstellung%>
ttfont=%<Einstellung%>
cdmath=%<Ein-Aus-Wert%>
slantedgreek=%<Ein-Aus-Wert%>
relspacing=%<Ein-Aus-Wert%>
cdgeometry=%<Einstellung%>
extrabottommargin=##L
cd=%<Einstellung%>
headings=%<Einstellung%>
cdtitle=%<Einstellung%>
cdcover=%<Einstellung%>
cdpart=%<Einstellung%>
cdsection=%<Einstellung%>
pageheadingsvskip=##L
headingsvskip=##L
cdhead=%<Einstellung%>
cdfoot=%<Einstellung%>
footlogoheight=##L
ddc=%<Einstellung%>
ddchead=%<Einstellung%>
ddcfoot=%<Einstellung%>
subjectthesis=%<Ein-Aus-Wert%>
parttitle=%<Ein-Aus-Wert%>
abstract=%<Einstellung%>
declaration=%<Einstellung%>
tudbookmarks=%<Ein-Aus-Wert%>
tudscrver=%<Version%>
#endkeyvals

#keyvals:\TUDoption#c
cdfont
ttfont
cdmath
slantedgreek
relspacing
cdgeometry
extrabottommargin
cd
headings
cdtitle
cdcover
cdpart
cdsection
pageheadingsvskip
headingsvskip
cdhead
cdfoot
footlogoheight
ddc
ddchead
ddcfoot
subjectthesis
titlesignature
parttitle
abstract
declaration
tudbookmarks
tudscrver
#endkeyvals

\cdfont{Schriftart}
\textcd{Schriftart}{Text%text}
\cdfontln
\textcdln{Text%text}
\cdfontrn
\textcdrn{Text%text}
\cdfontsn
\textcdsn{Text%text}
\cdfontbn
\textcdbn{Text%text}
\cdfontxn
\textcdxn{Text%text}
\cdfontli
\textcdli{Text%text}
\cdfontri
\textcdri{Text%text}
\cdfontsi
\textcdsi{Text%text}
\cdfontbi
\textcdbi{Text%text}
\cdfontxi
\textcdxi{Text%text}
\upGamma#m
\itGamma#m
\upDelta#m
\itDelta#m
\upTheta#m
\itTheta#m
\upLambda#m
\itLambda#m
\upXi#m
\itXi#m
\upPi#m
\itPi#m
\upSigma#m
\itSigma#m
\upUpsilon#m
\itUpsilon#m
\upPhi#m
\itPhi#m
\upPsi#m
\itPsi#m
\upOmega#m
\itOmega#m
\upalpha#m
\italpha#m
\upbeta#m
\itbeta#m
\upgamma#m
\itgamma#m
\updelta#m
\itdelta#m
\upepsilon#m
\itepsilon#m
\upvarepsilon#m
\itvarepsilon#m
\upzeta#m
\itzeta#m
\upeta#m
\iteta#m
\uptheta#m
\ittheta#m
\upvartheta#m
\itvartheta#m
\upiota#m
\itiota#m
\upkappa#m
\itkappa#m
\uplambda#m
\itlambda#m
\upmu#m
\itmu#m
\upnu#m
\itnu#m
\upxi#m
\itxi#m
\uppi#m
\itpi#m
\upvarpi#m
\itvarpi#m
\uprho#m
\itrho#m
\upvarrho#m
\itvarrho#m
\upsigma#m
\itsigma#m
\upvarsigma#m
\itvarsigma#m
\uptau#m
\ittau#m
\upupsilon#m
\itupsilon#m
\upphi#m
\itphi#m
\upvarphi#m
\itvarphi#m
\upchi#m
\itchi#m
\uppsi#m
\itpsi#m
\upomega#m
\itomega#m
\otherGamma#*m
\otherDelta#*m
\otherTheta#*m
\otherLambda#*m
\otherXi#*m
\otherPi#*m
\otherSigma#*m
\otherUpsilon#*m
\otherPhi#*m
\otherPsi#*m
\otherOmega#*m
\otheralpha#*m
\otherbeta#*m
\othergamma#*m
\otherdelta#*m
\otherepsilon#*m
\othervarepsilon#*m
\otherzeta#*m
\othereta#*m
\othertheta#*m
\othervartheta#*m
\otheriota#*m
\otherkappa#*m
\otherlambda#*m
\othermu#*m
\othernu#*m
\otherxi#*m
\otherpi#*m
\othervarpi#*m
\otherrho#*m
\othervarrho#*m
\othersigma#*m
\othervarsigma#*m
\othertau#*m
\otherupsilon#*m
\otherphi#*m
\othervarphi#*m
\otherchi#*m
\otherpsi#*m
\otheromega#*m
\faculty{Fakultät}
\department{Einrichtung%text}
\institute{Institut%text}
\chair{Lehrstuhl}
\extraheadline{Textzeile%text}
#keyvals:\pagestyle#c,\thispagestyle#c
tudheadings
plain.tudheadings
empty.tudheadings
#endkeyvals
\headlogo{imagefile}#g
\headlogo[Parameterliste%keyvals]{imagefile}#g
\footlogo{imagefile}#g
\footlogo[Parameterliste%keyvals]{imagefile}#g
#keyvals:\headlogo,\footlogo
actualtext={%<text%>}
alt={%<alt text%>}
artifact#true,false
bb=%<llx lly urx ury%>
bbllx=
bblly=
bburx=
bbury=
natwidth=
natheight=
hiresbb#true,false
pagebox=#mediabox,cropbox,bleedbox,trimbox,artbox
viewport=%<llx lly urx ury%>
trim=%<llx lly urx ury%>
angle=%<degrees%>
origin=
width=##L
height=##L
totalheight=##L
keepaspectratio#true,false
scale=%<factor%>
clip#true,false
draft#true,false
type=%<file type%>
ext=%<file extension%>
read=%<read-file extension%>
command=
quiet
page=%<page number%>
interpolate#true,false
decodearray={%<color array%>}
#endkeyvals
\footlogosep
\footcontent{Inhalt%text}
\footcontent{linker Inhalt%text}[rechter Inhalt%text]
\footcontent[Anweisungen]{Inhalt%text}
\footcontent[Anweisungen]{linker Inhalt%text}[rechter Inhalt%text]
\maketitle[Parameterliste%keyvals]
\maketitleonecolumn{Einspaltentext%text}
\maketitleonecolumn[Parameterliste%keyvals]{Einspaltentext%text}
#keyvals:\maketitle#c,\maketitleonecolumn#c
pagenumber=%<Seitenzahl%>
cdgeometry=%<Einstellung%>
cdfont=%<Einstellung%>
cdhead=%<Einstellung%>
cdfoot=%<Einstellung%>
headlogo=%<Dateiname%>
footlogo=%<Dateinamenliste%>
ddc=%<Einstellung%>
ddchead=%<Einstellung%>
ddcfoot=%<Einstellung%>
#endkeyvals
\raggedtitle
\authormore{Autorenzusatz}
\emailaddress{E-Mail-Adresse%URL}#U
\emailaddress[Einstellungen]{E-Mail-Adresse%URL}#U
\emailaddress*{E-Mail-Adresse%URL}#U
\course{Studiengang%text}
\discipline{Studienrichtung%text}
\date[Parameterliste%keyvals]{Datum}
\date*{Datum}
\date*[Parameterliste%keyvals]{Datum}
#keyvals:\date#c,\date*#c
before=%<Präfix%>
after=%<Suffix%>
place=%<Ort%>
#endkeyvals
\habilitationname#*
\dissertationname#*
\dissertationname#*
\diplomathesisname#*
\masterthesisname#*
\bachelorthesisname#*
\studentthesisname#*
\studentresearchname#*
\projectpapername#*
\seminarpapername#*
\termpapername#*
\researchname#*
\logname#*
\reportname#*
\internshipname#*
\supervisor{%<Name(n)%>}
\professor{Name}
\setpartsubtitle{Untertitel%text}
\getfield{Feldname}
\begin{abstract}[Parameterliste%keyvals]
\nextabstract
\nextabstract[Parameterliste%keyvals]
#keyvals:\begin{abstract}#c,\nextabstract#c
language=%<Sprache%>
markboth=%<Einstellung%>
pagestyle=%<Seitenstil%>
columns=%<Anzahl%>
option=%<Einstellung%>
#endkeyvals
\tudbookmark{Text%text}{Ankername}
\tudbookmark[Ebene]{Text%text}{Ankername}
\coursename#*
\disciplinename#*
\listingname#*
\listlistingname#*

\TUDClassName#*
\TUDScriptClassName#*
\printdate{date}#*

# specific to tudscrposter
\webpage{URL}#U
\webpage[Einstellungen]{URL}#U
\contactperson{%<Name(n)%>}
\office{Adresse/Gebäude%text}
\telephone{Telefonnummer}
\telefax{Telefaxnummer}
\authorname#*
\contactname#*
\contactpersonname#*
\begin{figurehere}#*
\end{figurehere}#*
\begin{tablehere}#*
\end{tablehere}#*

# deprecated
\dinbn#S
\footlogoheight#S
\ifdin{arg1}{arg2}#S
\publisher{arg}#S
\textdbn{text}#S
\textubn{text}#S
\textubs{text}#S
\textuln{text}#S
\textuls{text}#S
\texturn{text}#S
\texturs{text}#S
\textuxn{text}#S
\textuxs{text}#S
\univbn#S
\univbs#S
\univln#S
\univls#S
\univrn#S
\univrs#S
\univxn#S
\univxs#S