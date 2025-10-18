#include "searchresultmodel.h"
#include "latexdocument.h"
#include "qdocument.h"
#include "qdocumentsearch.h"
#include "smallUsefulFunctions.h"


/* *** internal id (iid) semantics ***
 * the internal id associates QModelIndex with the internal data structure. The iid is structured as followed
 *
 * < search index >  < line index >
 * 00000000 00000000 00000000 00000000
 *
 * - The upper 16 bits encode the search (i.e. a top-level group):
 *     m_searches[i] maps to (i + 1) * (1 << 16)
 * - Bit 16 (1<<15) is a flag indcating that the item is a result entry within a search
 * - Bits 1-15 indicate the position of the result entry within the search
 *
 * Example:
 *  * tree structure *   ** iid **     * internal data *
 *  Search in file A     0x00010000    searches[0]
 *    Result entry a0    0x00018000    searches[0].lines[0]
 *    Result entry a1    0x00018001    searches[0].lines[1]
 *  Search in file B     0x00020000    seraches[1]
 *    Result entry a0    0x00018000    searches[1].lines[0]
 *    Result entry a1    0x00018001    searches[1].lines[1]
 */

const quint32 ResultEntryFlag = (1 << 15);
const quint32 SearchMask = 0xFFFF0000;

bool iidIsResultEntry(quint32 iid)
{
    return iid & ResultEntryFlag;
}

quint32 makeResultEntryIid(quint32 searchIid, int row)
{
    return searchIid + ResultEntryFlag + row;
}

quint32 searchIid(quint32 iid)
{
    return iid & SearchMask;
}

int searchIndexFromIid(quint32 iid)
{
	return int(iid >> 16) - 1;
}

quint32 iidFromSearchIndex(int searchIndex)
{
	return (searchIndex + 1) * (1 << 16);
}


SearchResultModel::SearchResultModel(QObject *parent): QAbstractItemModel(parent), mIsWord(false), mIsCaseSensitive(false), mIsRegExp(false), mAllowPartialSelection(true)
{
	m_searches.clear();
	mExpression.clear();
}

SearchResultModel::~SearchResultModel()
{
}

void SearchResultModel::addSearch(const SearchInfo &search)
{
	beginResetModel();

    m_searches.append(search);
    if(search.doc){
        // update linenumbers
        int lineNumber = 0;
        m_searches.last().lineNumberHints.clear();
        for (int i = 0; i < search.lines.size(); i++) {
            lineNumber = search.doc->indexOf(search.lines[i], lineNumber);
            m_searches.last().lineNumberHints << lineNumber;
        }
    }

	endResetModel();
}

QList<SearchInfo> SearchResultModel::getSearches()
{
	return m_searches;
}

void SearchResultModel::clear()
{
	beginResetModel();

	m_searches.clear();
	mExpression.clear();
	mAllowPartialSelection = true;

	endResetModel();
}

void SearchResultModel::removeSearch(const QDocument *doc)
{
	return;
	// TODO: currently unused, also it requires beginResetModel() or similar
	for (int i = m_searches.size() - 1; i >= 0; i--)
		if (m_searches[i].doc == doc)
			m_searches.removeAt(i);
}

void SearchResultModel::removeAllSearches()
{
	beginResetModel();
	m_searches.clear();
	endResetModel();
}

int SearchResultModel::columnCount(const QModelIndex &) const
{
    return 1;
}

int SearchResultModel::rowCount(const QModelIndex &parent) const
{
	//return parent.isValid()?0:1;
	if (!parent.isValid()) {
		return m_searches.size();
	} else {
		int i = parent.row();
		if (i < m_searches.size() && !iidIsResultEntry(parent.internalId())) {
            return qMin(qMax(m_searches[i].lines.size(),m_searches[i].textlines.size()), 1000); // maximum search results limited
		} else return 0;
	}
}

QModelIndex SearchResultModel::index(int row, int column, const QModelIndex &parent)
const
{
	if (parent.isValid()) {
		return createIndex(row, column, makeResultEntryIid(parent.internalId(), row));
	} else {
		return createIndex(row, column, iidFromSearchIndex(row));
	}
}

QModelIndex SearchResultModel::parent(const QModelIndex &index)
const
{
	quint32 iid = index.internalId();
	if (iidIsResultEntry(iid)) {
		return createIndex(searchIndexFromIid(iid), 0, searchIid(iid));
	} else return QModelIndex();
}

QVariant SearchResultModel::dataForResultEntry(const SearchInfo &search, int lineIndex, int role) const
{
    if (!search.doc){
        // in file search results
        bool lineIndexValid = (lineIndex >= 0 && lineIndex < search.textlines.size());
        switch (role) {
        case Qt::CheckStateRole:
            if (!lineIndexValid) return QVariant();
            return (search.checked.value(lineIndex, true) ? Qt::Checked : Qt::Unchecked);
        case LineNumberRole: {
            if (!lineIndexValid) return QVariant();
            int lineNo = search.lineNumberHints[lineIndex];
            if (lineNo < 0) return 0;
            return lineNo+1; // internal line number is 0-based
        }
        case Qt::DisplayRole:
        case Qt::ToolTipRole: {
            if (!lineIndexValid) return "";
            QString textline = search.textlines[lineIndex];
            if (role == Qt::DisplayRole) {
                return textline;
            } else {  // tooltip role
                return textline;
            }
            break;
        }
        case MatchesRole: {
            QString textline = search.textlines[lineIndex];
            return QVariant::fromValue<QList<SearchMatch> >(getSearchMatches(textline));
        }
        }
        return QVariant();
    }
	bool lineIndexValid = (lineIndex >= 0 && lineIndex < search.lines.size() && lineIndex < search.lineNumberHints.size());
	switch (role) {
	case Qt::CheckStateRole:
		if (!lineIndexValid) return QVariant();
		return (search.checked.value(lineIndex, true) ? Qt::Checked : Qt::Unchecked);
	case LineNumberRole: {
		if (!lineIndexValid) return QVariant();
		int lineNo = search.doc->indexOf(search.lines[lineIndex], search.lineNumberHints[lineIndex]);
		search.lineNumberHints[lineIndex] = lineNo;
		if (lineNo < 0) return 0;
		return lineNo + 1; // internal line number is 0-based
	}
	case Qt::DisplayRole:
	case Qt::ToolTipRole: {
		if (!lineIndexValid) return "";
		search.lineNumberHints[lineIndex] = search.doc->indexOf(search.lines[lineIndex], search.lineNumberHints[lineIndex]);
		if (search.lineNumberHints[lineIndex] < 0) return "";
		QDocumentLine docline = search.doc->line(search.lineNumberHints[lineIndex]);
		if (role == Qt::DisplayRole) {
			return docline.text();
		} else {  // tooltip role
			return prepareReplacedText(docline);
		}
		break;
	}
	case MatchesRole: {
		search.lineNumberHints[lineIndex] = search.doc->indexOf(search.lines[lineIndex], search.lineNumberHints[lineIndex]);
		if (search.lineNumberHints[lineIndex] < 0) return QVariant();
		QDocumentLine docline = search.doc->line(search.lineNumberHints[lineIndex]);
		return QVariant::fromValue<QList<SearchMatch> >(getSearchMatches(docline));
	}
	}
	return QVariant();
}

QVariant SearchResultModel::dataForSearchResult(const SearchInfo &search, int role) const
{
	switch (role) {
	case Qt::ToolTipRole:
		return QVariant();
	case Qt::CheckStateRole: {
		if (search.checked.isEmpty())
			return QVariant();
		bool state = search.checked.first();
		int cnt = search.checked.count(state);
		if (cnt == search.checked.size()) {
			return state ? Qt::Checked : Qt::Unchecked;
		} else {
			return Qt::PartiallyChecked;
		}
    }
    case Qt::DisplayRole: {
        if(!search.doc){
            if(search.filename.isEmpty()){
                return tr("File closed") + QString(" (%1)").arg(search.lines.size());
            }else{
                return QDir::toNativeSeparators(search.filename) + QString(" (%1)").arg(search.textlines.size());
            }
        }
        LatexDocument *ldoc=dynamic_cast<LatexDocument*>(search.doc.data());
        QString fn=ldoc->getFileName();
        if(fn.isEmpty()) fn=tr("untitled");
        return QDir::toNativeSeparators(fn) + QString(" (%1)").arg(search.lines.size());
    }
	}
	return QVariant();
}

QVariant SearchResultModel::data(const QModelIndex &index, int role) const
{
	if (!index.isValid()) return QVariant();
	if (role != Qt::DisplayRole && role != Qt::CheckStateRole && role != Qt::ToolTipRole && role != LineNumberRole && role != MatchesRole) return QVariant();
	if (role == Qt::CheckStateRole && !mAllowPartialSelection) return QVariant();

	int iid = index.internalId();
	int searchIndex = searchIndexFromIid(iid);
	if (searchIndex < 0 || searchIndex >= m_searches.size()) return QVariant();
	const SearchInfo &search = m_searches.at(searchIndex);
	if (iidIsResultEntry(iid)) {
		return dataForResultEntry(search, index.row(), role);
	} else {
		return dataForSearchResult(search, role);
	}
}

Qt::ItemFlags SearchResultModel::flags(const QModelIndex &index) const
{
	if (!index.isValid())
        return Qt::ItemFlags();

	return Qt::ItemIsEnabled | Qt::ItemIsUserCheckable | Qt::ItemIsSelectable ;
}

bool SearchResultModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
	if (role != Qt::CheckStateRole || !mAllowPartialSelection )
		return false;

	int iid = index.internalId();
	int searchIndex = searchIndexFromIid(iid);
	if (searchIndex < 0 || searchIndex >= m_searches.size()) return false;
	SearchInfo &search = m_searches[searchIndex];
	if (iidIsResultEntry(iid)) {
		if (!search.doc) return false;
		int lineIndex = index.row();
		if (lineIndex < 0 || lineIndex > search.lines.size() || lineIndex > search.lineNumberHints.size()) {
			return false;
		}
		if (role == Qt::CheckStateRole) {
			search.checked.replace(lineIndex, (value == Qt::Checked));
			//m_searches.at(searchIndex).checked.replace(lineIndex,(value==Qt::Checked));
		}
		emit dataChanged(index, index);
	} else {
		bool state = (value == Qt::Checked);
		for (int l = 0; l < search.checked.size(); l++) {
			search.checked.replace(l, state);
		}
		int lastRow = search.checked.size() - 1;
		QModelIndex endIndex = createIndex(lastRow, 0, makeResultEntryIid(iid, lastRow));
		emit dataChanged(index, endIndex);
	}
	return true;
}

void SearchResultModel::setSearchExpression(const QString &exp, const QString &repl, const bool isCaseSensitive, const bool isWord, const bool isRegExp)
{
	mExpression = exp;
	mReplacementText = repl;
	mIsCaseSensitive = isCaseSensitive;
	mIsWord = isWord;
	mIsRegExp = isRegExp;
}

void SearchResultModel::setSearchExpression(const QString &exp, const bool isCaseSensitive, const bool isWord, const bool isRegExp)
{
	mExpression = exp;
	// keep mReplacementText
	mIsCaseSensitive = isCaseSensitive;
	mIsWord = isWord;
	mIsRegExp = isRegExp;
}

QString SearchResultModel::prepareReplacedText(const QDocumentLine &docline) const
{
	QString result = docline.text();
	QList<SearchMatch> placements = getSearchMatches(docline);
	int offset = 0;
	foreach (SearchMatch match, placements) {
		if (mIsRegExp) {
            qDebug()<<"unused code";
            //QRegExp rx(mExpression, mIsCaseSensitive ? Qt::CaseSensitive : Qt::CaseInsensitive);
			//QString newText=text.replace(rx,mReplacementText);
			/*int lineNr=doc->indexOf(dlh,search.lineNumberHints.value(i,-1));
			cur->select(lineNr,elem.first,lineNr,elem.second);
			newText=newText.mid(elem.first);
			newText.chop(txt.length()-elem.second-1);
			cur->replaceSelectedText(newText);*/
		} else {
			// simple replacement
			result = result.left(offset + match.pos) + "<b>" + mReplacementText + "</b>" + result.mid(match.pos + match.length + offset);
			offset += mReplacementText.length() - match.length + 7;  // 7 is the length of the html tags.
		}
	}
	return result;
}

QList<SearchMatch> SearchResultModel::getSearchMatches(const QDocumentLine &docline) const
{
	if (!docline.isValid() || mExpression.isEmpty()) return QList<SearchMatch>();

	QString text = docline.text();

    return getSearchMatches(text);
}
/*!
 * \brief find matches in text line
 * \param line
 * \return
 */
QList<SearchMatch> SearchResultModel::getSearchMatches(const QString &line) const
{
    if (line.isEmpty() || mExpression.isEmpty()) return QList<SearchMatch>();
    QRegularExpression regexp = generateRegularExpression(mExpression, mIsCaseSensitive, mIsWord, mIsRegExp);

    QList<SearchMatch> result;
    QRegularExpressionMatch re_match = regexp.match(line);
    int offset=re_match.capturedStart();
    while (offset > -1) {
        SearchMatch match;
        match.pos = offset;
        match.length = re_match.capturedLength();
        result << match;
        // next result
        re_match = regexp.match(line,offset+match.length);
        offset = re_match.capturedStart();
    }

    return result;
}

QDocument *SearchResultModel::getDocument(const QModelIndex &index)
{
	int i = searchIndexFromIid(index.internalId());
    if (i < 0 || i >= m_searches.size()) return nullptr;
    if (!m_searches[i].doc) return nullptr;
	return m_searches[i].doc;
}
/*!
 * \brief return filename for search in files results
 * \param index
 * \return
 */
QString SearchResultModel::getFileName(const QModelIndex &index)
{
    int i = searchIndexFromIid(index.internalId());
    if (i < 0 || i >= m_searches.size()) return nullptr;
    if (m_searches[i].doc) return "";
    return m_searches[i].filename;
}

int SearchResultModel::getLineNumber(const QModelIndex &index)
{
	int iid = index.internalId();
	if (!iidIsResultEntry(iid)) return -1;
	int searchIndex = searchIndexFromIid(iid);
	if (searchIndex < 0 || searchIndex >= m_searches.size()) return -1;
	const SearchInfo &search = m_searches.at(searchIndex);
    if (!search.doc){
        if(!search.lineNumberHints.isEmpty()){
            int lineIndex = index.row();
            return search.lineNumberHints[lineIndex];
        }
        return -1;
    }
	int lineIndex = index.row();
	if (lineIndex < 0 || lineIndex > search.lines.size() || lineIndex > search.lineNumberHints.size()) return -1;
	search.lineNumberHints[lineIndex] = search.doc->indexOf(search.lines[lineIndex], search.lineNumberHints[lineIndex]);
	return search.lineNumberHints[lineIndex];
}

QVariant SearchResultModel::headerData(int section, Qt::Orientation orientation, int role) const
{
	if (role != Qt::DisplayRole) return QVariant();
	if (orientation != Qt::Horizontal) return QVariant();
	switch (section) {
	case 0:
		return tr("Results");
	default:
		return QVariant();
	}
}

int SearchResultModel::getNextSearchResultColumn(const QString &text, int col)
{
    QRegularExpression m_regexp = generateRegularExpression(mExpression, mIsCaseSensitive, mIsWord, mIsRegExp);

	int i = 0;
	int i_old = 0;
	while (i <= col && i > -1) {
        QRegularExpressionMatch match = m_regexp.match(text,i);
        i = match.capturedStart();
		if (i > -1) {
			i_old = i;
			i++;
		}
	}
	return i_old;
}


LabelSearchResultModel::LabelSearchResultModel(QObject *parent) : SearchResultModel(parent)
{
}

/*!
 * This is a workaround:
 * In contrast to LabelSearchQuery::run() which uses the internal label information, this
 * function relies only on textual matching. It's currently only used for highlighting the
 * results. The actual search and replace are handled by the query and have always been correct.
 *
 * To reduce the chance of false highlighting such as "label \\ref{label}", we assume that
 * labels always appear in curly braces and only match those occurences.
 *
 * A clean solution would have to track not only the lines but also the column positions
 * within the lines. Alternatively, the QDocumentLine might be queried for the label positions
 * of the matching type.
 */
QList<SearchMatch> LabelSearchResultModel::getSearchMatches(const QDocumentLine &docline) const
{
	QList<SearchMatch> matches = SearchResultModel::getSearchMatches(docline);
	const QString &text = docline.text();

	for (int i = matches.count() - 1; i >= 0; i--) {
		const SearchMatch &match = matches.at(i);
		if ((match.pos <= 0)
				|| (match.pos + match.length >= text.length())
				|| (text.at(match.pos-1) != '{')
				|| (text.at(match.pos + match.length) != '}')
			) {
			matches.removeAt(i);
			continue;
		}
	}
	return matches;
}

SpecialDefSearchResultModel::SpecialDefSearchResultModel(QObject *parent,int tokenType) : SearchResultModel(parent)
{
    mTokenType=tokenType;
}
/*!
 * \brief give search results
 * Only line is given, needs to be researched for token info
 * \param docline
 * \return
 */
QList<SearchMatch> SpecialDefSearchResultModel::getSearchMatches(const QDocumentLine &docline) const
{
    QList<SearchMatch> matches = SearchResultModel::getSearchMatches(docline);
    const QString &text = docline.text();
    QDocumentLineHandle *dlh=docline.handle();
    TokenList tl = dlh->getCookieLocked(QDocumentLine::LEXER_COOKIE).value<TokenList >();

    for (int i = matches.count() - 1; i >= 0; i--) {
        const SearchMatch &match = matches.at(i);
        int k=0;
        while(k<tl.length() && tl[k].start<match.pos) ++k;
        if(k<tl.length() && tl[k].start==match.pos && tl[k].length==match.length){
            Token &tk=tl[k];
            if(tk.type==mTokenType){
                continue;
            }
            if(tk.type==Token::defSpecialArg){
                // check if new definition of specialArg
                LatexDocument *doc=dynamic_cast<LatexDocument*>(dlh->document());
                QString def=doc->getCmdfromSpecialArgToken(tk);
                QStringList vals=doc->lp->mapSpecialArgs.values();
                int k=vals.indexOf(def);
                if(k>-1 && Token::specialArg+k==mTokenType){
                    continue;
                }
            }
        }
        matches.removeAt(i);
    }
    return matches;
}
