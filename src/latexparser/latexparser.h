#ifndef Header_Latex_Parser
#define Header_Latex_Parser

#include "commanddescription.h"


/*!
 * \brief class for storing latex syntax informtion and latex parsing
 *
 * The latex parsing is less important since the token based system, but the storage of syntax information is still used.
 */
class LatexParser
{
	friend class SmallUsefulFunctionsTest;
public:
	LatexParser(); ///< constructor
	~LatexParser();
    LatexParser(const LatexParser &other); ///< copy constructor
    LatexParser & operator=(const LatexParser &other);
	void init(); ///< set default values

	static const int MAX_STRUCTURE_LEVEL;

    enum ContextType {Unknown, Command, Environment, Label, Reference, Citation, Option, Graphics, Package, Keyval, KeyvalValue, OptionEx, ArgEx};
	// could do with some generalization as well, optionEx/argEx -> special treatment with specialOptionCommands

	static LatexParser &getInstance();
	static LatexParser *getInstancePtr();


	int structureDepth()
	{
		return MAX_STRUCTURE_LEVEL;
	}
    int structureCommandLevel(const QString &cmd) const;

	QSet<QString> environmentCommands; ///< used by LatexReader only, obsolete
	QSet<QString> optionCommands; ///< used by LatexReader only, obsolete
	QStringList mathStartCommands; ///< commands to start math-mode like '$'
	QStringList mathStopCommands; ///< commands to stop math-mode like '$'
    QMultiHash<QString, QString> packageAliases; ///< aliases for classes to packages e.g. article = latex-document, etc
	QMultiHash<QString, QString> environmentAliases; ///< aliases for environments, e.g. equation is math, supertabular is also tab etc.
	/// commands used for syntax check (per doc basis)
	QHash<QString, QSet<QString> > possibleCommands;
	QHash<QString, QString> specialDefCommands; ///< define special elements, e.g. define color etc
	QMap<int, QString> mapSpecialArgs;
    enum ArgumentType { singleArgument, commaSeparated, multiElement };
    QMap<int, ArgumentType> mapSpecialArgumentTypes; ///< map special argument numbers to argument types

	CommandDescriptionHash commandDefs; ///< command definitions

	void append(const LatexParser &elem); ///< append values
	void substract(const LatexParser &elem); ///< remove values
	void clear(); ///< set to default values
    void importCwlAliases(const QString filename); ///< import package aliases from disc
};
Q_DECLARE_METATYPE(LatexParser)


const QString & getCommonEOW();
/// closing bracket (opening and closing bracket considered correctly)
int findClosingBracket(const QString &word, int &start, QChar oc = QChar('{'), QChar cc = QChar('}'));
/// opening bracket (opening and closing bracket considered correctly), start at "start"
int findOpeningBracket(const QString &word, int start, QChar oc = QChar('{'), QChar cc = QChar('}'));
/// determine Arguments from xparse argument definition
QString interpretXArgs(const QString &xarg);
int commentStart(const QString &text);
QString cutComment(const QString &text);
bool resolveCommandOptions(const QString &line, int column, QStringList &values, QList<int> *starts = nullptr);
QString removeOptionBrackets(const QString &option);


#endif // LATEXPARSER_H
