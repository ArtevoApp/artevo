import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'music_local_data_manager.dart';
import 'poetry_local_data_manager.dart';

class LocalDataService {
  LocalDataService();

  static LocalDataService? _instance;

  static LocalDataService get instance {
    _instance ??= LocalDataService();
    return _instance!;
  }

  static const _dbName = "artevo.db";

  static const _dbVersion = 1;

  Database? _database;

  Database? get database => _database;

  Future<void> init() async {
    if (_database == null) {
      final databasesPath = await getDatabasesPath();

      final path = join(databasesPath, _dbName);

      _database = await openDatabase(path, version: _dbVersion);
    }

    await MusicLocalDataManager.instance.init();
    await PoetryLocalDataManager.instance.init();
  }

  /// Get Bookmarked data.
  Future<List<Map<String, dynamic>>> getBookmarks(String tableName,
      {int? limit, bool? getAll}) async {
    try {
      limit ??= 5;
      if (getAll == true) {
        return await database!.rawQuery(
          'SELECT * FROM $tableName WHERE isBookmarked = 1 ORDER BY bookmarkedAt DESC',
        );
      }
      return await database!.rawQuery(
        'SELECT * FROM $tableName WHERE isBookmarked = 1 ORDER BY bookmarkedAt DESC LIMIT $limit',
      );
    } catch (e) {
      return [];
    }
  }

  /// Checks if the contens's id is bookmarked.
  Future<bool> checkBookMarkedStatus(String tableName, String id) async {
    try {
      final result =
          await database!.query(tableName, where: 'id = ?', whereArgs: [id]);

      if (result.isNotEmpty) {
        return ((result.first['isBookmarked'] as int?) ?? 0) == 1;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  /// Updates the bookmarked status of data by id.
  Future<void> updateBookmarkStatus(
      String tableName, Map<String, dynamic> content, bool newStatus) async {
    try {
      final contentId = content["id"].toString();

      final result = await _database!
          .query(tableName, where: 'id = ?', whereArgs: [contentId]);

      if (result.isNotEmpty) {
        await _database!.update(
            tableName,
            {
              'isBookmarked': newStatus ? 1 : 0,
              'bookmarkedAt': DateTime.now().millisecondsSinceEpoch
            },
            where: 'id = ?',
            whereArgs: [contentId]);
      } else {
        content.addAll({
          'isBookmarked': newStatus ? 1 : 0,
          'bookmarkedAt': DateTime.now().millisecondsSinceEpoch,
        });

        await _database!.insert(tableName, content);
      }
    } catch (e) {
      return;
    }
  }
}
