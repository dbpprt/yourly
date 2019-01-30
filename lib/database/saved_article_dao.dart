import 'package:yourly/database/common/dao.dart';
import 'package:yourly/database/entities/saved_article.dart';

class SavedArticleDao implements Dao<SavedArticle> {
  final tableName = 'articles';
  final columnId = 'id';
  final _columnType = 'type';
  final _columnData = 'data';
  final columnCreated = 'created';
  final _columnUrl = 'url';

  @override
  String get createTableQuery =>
      "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
      " $_columnType TEXT,"
      " $_columnData TEXT,"
      " $_columnUrl TEXT,"
      " $columnCreated INTEGER)";

  @override
  SavedArticle fromMap(Map<String, dynamic> query) {
    SavedArticle note = SavedArticle(query[_columnType], query[_columnData],
        query[columnCreated], query[_columnUrl]);
    note.id = query[columnId];
    return note;
  }

  @override
  Map<String, dynamic> toMap(SavedArticle object) {
    return <String, dynamic>{
      _columnType: object.type,
      _columnData: object.data,
      _columnUrl: object.url,
      columnCreated: object.created
    };
  }

  @override
  List<SavedArticle> fromList(List<Map<String, dynamic>> query) {
    List<SavedArticle> articles = List<SavedArticle>();
    for (Map map in query) {
      articles.add(fromMap(map));
    }
    return articles;
  }
}
