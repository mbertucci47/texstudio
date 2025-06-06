#ifndef Header_TableManipulation
#define Header_TableManipulation

#include "mostQtHeaders.h"
#include "qdocument.h"
#include "syntaxcheck.h"

class QEditor;
class LatexEditorView;

class LatexTables
{
public:
	static void addRow(QDocumentCursor &c, const int numberOfColumns );
    static void addRow(QDocumentCursor &c, Environment env );
    static void addColumn(Environment env, const int lineNumber, const int afterColumn, QStringList *cutBuffer = nullptr);
    static void removeColumn(Environment env, const int lineNumber, const int column, QStringList *cutBuffer = nullptr);
	static void removeRow(QDocumentCursor &c);
    static void removeRow(QDocumentCursor &c,Environment env);
	static int findNextToken(QDocumentCursor &cur, QStringList tokens, bool keepAnchor = false, bool backwards = false);
    static Token findColumn(QDocumentCursor &cur,Environment env);
    static bool findNextColumn(QDocumentCursor &cur,Token &tk);
    enum NextRowAvailable { RowAvailable, RowNotAvailable, RowNotAvailableLazyNewLine };
    static NextRowAvailable findRow(QDocumentCursor &cur,Environment env);
    static bool checkEndEnv(const TokenList &tl, int pos,const Environment &env);
    static int getColumn(const QDocumentCursor &cur, const Environment env);
	static QString getDef(QDocumentCursor &cur);
    static Token getDef(TokenList &tl, Environment env, int &ln, int &nextLine, int &nextCol, QDocument *doc);
	static QString getSimplifiedDef(QDocumentCursor &cur);
	static int getNumberOfColumns(QDocumentCursor &cur);
	static int getNumberOfColumns(QStringList values);
	static bool inTableEnv(QDocumentCursor &cur);
    static int inTableEnv(StackEnvironment &stackEnv);
    static int getNumOfColsInMultiColumn(const QString &str, QString *outAlignment = nullptr, QString *outText = nullptr);
	static int incNumOfColsInMultiColumn(const QString &str, int add);
	static void addHLine(QDocumentCursor &c, const int numberOfLines = -1, const bool remove = false);
    static QStringList splitColDef(QString def);
	static void simplifyColDefs(QStringList &colDefs);
	static void executeScript(QString script, LatexEditorView *edView);
	static void generateTableFromTemplate(LatexEditorView *edView, QString templateFileName, QString def, QList<QStringList> table, QString env, QString width);
	static QString getTableText(QDocumentCursor &cur);
	static void alignTableCols(QDocumentCursor &cur);
    static QString handleColSpec(QString opt);

    static QSet<QString> tabularNames;
    static QSet<QString> tabularNamesWithOneOption;
    static QSet<QString> mathTables;
};


class LatexTableLine : public QObject
{
	Q_OBJECT

public:
    LatexTableLine(QObject *parent = nullptr);

	enum MultiColFlag {MCNone, MCStart, MCMid, MCEnd};

	void setMetaLine(const QString line) { metaLine = line; }
	void setColLine(const QString line);
	void setLineBreakOption(const QString opt) { lineBreakOption = opt; }

	int colWidth(int col) const { return cols.at(col).length(); }
	int colCount() const { return cols.count(); }
	MultiColFlag multiColState(int col) { return mcFlag.at(col); }
	QChar multiColAlign(int col) {  return mcAlign.at(col); }
	int multiColStart(int col) {
		for (; col >= 0; col--) if (mcFlag.at(col) == MCStart) return col;
		return -1;
	}
	QString toMetaLine() const { return metaLine; }
	QString toColLine() const { return colLine; }
	QString toLineBreakOption() const { return lineBreakOption; }
	QString colText(int col) const { return cols.at(col); }
	QString colText(int col, int width, const QChar &alignment);

private:
	void appendCol(const QString &col);

	QString colLine;
	QString metaLine;
	QString lineBreakOption;

	QStringList cols;
	QList<MultiColFlag> mcFlag;
	QList<QChar> mcAlign;
};
Q_DECLARE_METATYPE(LatexTableLine::MultiColFlag)


class LatexTableModel : public QAbstractTableModel
{
	Q_OBJECT

#ifndef QT_NO_DEBUG
	friend class TableManipulationTest;
#endif
public:
    LatexTableModel(QObject *parent = nullptr);


	void setContent(const QString &text);
	QStringList getAlignedLines(const QStringList alignment, const QString &rowIndent = "\t", bool forceLineBreakAtEnd = false) const;

	int rowCount(const QModelIndex &parent = QModelIndex()) const { Q_UNUSED(parent) return lines.count(); }
	int columnCount(const QModelIndex &parent = QModelIndex()) const { Q_UNUSED(parent) return (lines.count() > 0) ? lines.at(0)->colCount() : 0; }
	QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

private:
	int findRowBreak(const QString &text, int startCol) const;
	LatexTableLine *parseNextLine(const QString &text, int &startCol);

	QStringList metaLineCommands;
	int metaLineCommandPos;
	QList<LatexTableLine *> lines;
	QStringList parseErrors;
};
#endif // TABLEMANIPULATION_H
