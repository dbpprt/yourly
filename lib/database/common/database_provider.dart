import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yourly/database/saved_articles/saved_article_dao.dart';

class DatabaseProvider {
  static final _instance = DatabaseProvider._internal();

  DatabaseProvider._internal();

  static DatabaseProvider get = _instance;

  bool isInitialized = false;

  Database _db;

  Future<Database> db() async {
    if (!isInitialized) await _init();
    return _db;
  }

  Future _init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "yourly.db");
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(SavedArticleDao().createTableQuery);
    });
  }
}
