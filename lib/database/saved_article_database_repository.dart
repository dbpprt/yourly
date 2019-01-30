import 'package:yourly/database/common/database_provider.dart';
import 'package:yourly/database/entities/saved_article.dart';
import 'package:yourly/database/saved_article_dao.dart';

class SavedArticlesDatabaseRepository {
  final dao = SavedArticleDao();
  DatabaseProvider databaseProvider;
  SavedArticlesDatabaseRepository(this.databaseProvider);

  Future<SavedArticle> insert(SavedArticle note) async {
    final db = await databaseProvider.db();
    note.id = await db.insert(dao.tableName, dao.toMap(note));
    return note;
  }

  Future<void> delete(int id) async {
    final db = await databaseProvider.db();
    await db
        .delete(dao.tableName, where: dao.columnId + " = ?", whereArgs: [id]);
  }

  Future<SavedArticle> update(SavedArticle note) async {
    final db = await databaseProvider.db();
    await db.update(dao.tableName, dao.toMap(note),
        where: dao.columnId + " = ?", whereArgs: [note.id]);
    return note;
  }

  Future<List<SavedArticle>> getArticles(int page, int pageSize) async {
    final db = await databaseProvider.db();
    List<Map> maps = await db.query(dao.tableName,
        orderBy: dao.columnCreated + ' DESC',
        limit: pageSize,
        offset: page * pageSize);
    return dao.fromList(maps);
  }
}
