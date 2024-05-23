import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/news.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'news.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE news(id TEXT PRIMARY KEY, title TEXT, content TEXT, author TEXT, date TEXT, image TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertNews(List<News> newsList) async {
    final db = await database;
    for (var news in newsList) {
      await db.insert(
        'news',
        news.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<News>> getNews() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('news');
    return List.generate(maps.length, (i) {
      return News.fromMap(maps[i]);
    });
  }

  Future<void> deleteAllNews() async {
    final db = await database;
    await db.delete('news');
  }
}
