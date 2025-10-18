#ifndef Header_SearchQuery
#define Header_SearchQuery

#include "mostQtHeaders.h"
#include "qfuturewatcher.h"
#include "searchresultmodel.h"
#include "qdocument.h"
#include "qdocumentline_p.h"

class LatexDocument;
//class QDocumentLineHandle;


class SearchQuery : public QObject {
	Q_OBJECT

public:
	enum SearchFlag
	{
		NoFlags				= 0x0000,
		SearchParams		= 0x00FF,
		IsCaseSensitive		= 0x0001,
		IsWord				= 0x0002,
		IsRegExp			= 0x0004,
		
		SearchCapabilities	= 0xFF00,
		ScopeChangeAllowed	= 0x0100,
		ReplaceAllowed		= 0x0200,
		SearchAgainAllowed	= 0x0400,
	};
	Q_DECLARE_FLAGS(SearchFlags, SearchFlag)
	enum Scope {
		CurrentDocumentScope,
		ProjectScope,
		GlobalScope,
        FilesScope,
	};

	SearchQuery(QString expr, QString replaceText, SearchFlags f);
	SearchQuery(QString expr, QString replaceText, bool isCaseSensitive, bool isWord, bool isRegExp);

	bool flag(SearchFlag f) const;
	QString type() { return mType; }

	QString searchExpression() const { return mModel->searchExpression(); }
    void setExpression(QString expr);
	SearchResultModel * model() const { return mModel; }
	int getNextSearchResultColumn(QString text, int col) const;

	void setScope(Scope sc) { mScope = sc; }
	Scope scope() { return mScope; }

    void setFileFilter(const QString &filter);
    void setSearchFolder(const QString &folder);
    void setSearchFolder(QFileInfo folder);
    QString searchFolder() const;
	
signals:
	void runCompleted();
	
public slots:
	virtual void run(LatexDocument *doc);
	void addDocSearchResult(QDocument *doc, QList<QDocumentLineHandle *> search);
    void addFileSearchResult(SearchInfo search);
	void setReplacementText(QString text);
	QString replacementText();
	virtual void replaceAll();

private slots:
    void searchInFilesFinished();
	
protected:
	void setFlag(SearchFlag f, bool b=true);
    SearchInfo searchInFile(QString file, const QRegularExpression &regex);
    void addToSearchResults(SearchInfo &result, SearchInfo newResults);
	QString mType;
	Scope mScope;
	SearchResultModel *mModel;
	SearchFlags searchFlags;
    QStringList m_fileFilter;
    QDir m_fileFolder;

    QFutureWatcher<SearchInfo> m_SearchInFilesWatcher;
	
private:

};
Q_DECLARE_OPERATORS_FOR_FLAGS(SearchQuery::SearchFlags)


class LabelSearchQuery : public SearchQuery {
	Q_OBJECT

public:
	LabelSearchQuery(QString label);
	virtual void run(LatexDocument *doc);
	virtual void replaceAll();
};

class SpecialDefSearchQuery : public SearchQuery {
    Q_OBJECT

public:
    SpecialDefSearchQuery(QString label,int type);
    virtual void run(LatexDocument *doc);
    virtual void replaceAll();
protected:
    int mTokenType;
};


#endif // SEARCHQUERY_H
