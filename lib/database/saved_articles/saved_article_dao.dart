import 'package:yourly/database/common/dao.dart';
import 'package:yourly/database/saved_articles/saved_article.dart';

class SavedArticleDao implements Dao<SavedArticle> {
  final columnCreated = 'created';
  final columnId = 'id';
  final tableName = 'articles';

  final _columnData = 'data';
  final _columnProviderName = 'providerName';
  final _columnUrl = 'url';

  @override
  String get createTableQuery =>
      "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
      " $_columnProviderName TEXT,"
      " $_columnData TEXT,"
      " $_columnUrl TEXT,"
      " $columnCreated INTEGER)";

  @override
  List<SavedArticle> fromList(List<Map<String, dynamic>> query) {
    List<SavedArticle> articles = List<SavedArticle>();
    for (Map map in query) {
      articles.add(fromMap(map));
    }
    return articles;
  }

  @override
  SavedArticle fromMap(Map<String, dynamic> query) {
    SavedArticle note = SavedArticle(query[_columnProviderName],
        query[_columnData], query[columnCreated], query[_columnUrl]);
    note.id = query[columnId];
    return note;
  }

  @override
  Map<String, dynamic> toMap(SavedArticle object) {
    return <String, dynamic>{
      _columnProviderName: object.providerName,
      _columnData: object.data,
      _columnUrl: object.url,
      columnCreated: object.created
    };
  }
}
