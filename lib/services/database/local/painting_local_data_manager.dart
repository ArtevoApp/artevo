import 'package:artevo_package/enums/content_type.dart';

import '../../../common/extensions/content_type_extension.dart';
import 'extension/multiple_insert_extension.dart';
import 'local_data_service.dart';
import 'package:sqflite/sqflite.dart';

class PaintingLocalDataManager extends LocalDataService {
  PaintingLocalDataManager._();

  static PaintingLocalDataManager? _instance;

  static PaintingLocalDataManager get instance {
    _instance ??= PaintingLocalDataManager._();
    return _instance!;
  }

  final tableName = ContentType.paintingContent.localDBTableName;

  final service = LocalDataService.instance;

  final _db = LocalDataService.instance.database;

  /// Checks if the table exists in the database. If it doesn't, it creates it.
  Future<bool> checkTableAndCreate() async {
    try {
      if (_db == null) return false;

      final tableCount = await _db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");

      if (tableCount.isEmpty) {
        await _createTable();
      } else {
        final dataCount = await _db
                .rawQuery("SELECT COUNT(*) as count FROM $tableName")
                .then(Sqflite.firstIntValue) ??
            0;
        if (dataCount < 300000) {
          await deleteAllData();
        }
      }

      return true;
    } catch (e) {
      return false;
    }
  }

/* ----------------------------- Saved Paintings ---------------------------- */

  /// Saves painting data to the database.
  Future<bool> savePaintingData(Iterable<Map<String, Object?>> rows) async {
    try {
      await _db!.insertMultiple(tableName, rows,
          conflictAlgorithm: ConflictAlgorithm.replace);

      return true;
    } catch (e) {
      return false;
    }
  }

  /// limit is nowly 12 but it can be changed later in the future (@limit).
  Future<List<Map<String, dynamic>>?> getDataRandomly({int? limit}) async {
    try {
      final rows = await _db!.rawQuery(
          'SELECT * FROM $tableName ORDER BY RANDOM() LIMIT ${limit ?? 12}');

      return rows;
    } catch (e) {
      return null;
    }
  }

  Future<void> _createTable() async =>
      await _db!.execute("CREATE TABLE $tableName ("
          "id TEXT PRIMARY KEY,"
          "contentType TEXT,"
          "langCode TEXT,"
          "title TEXT,"
          "creator TEXT,"
          "editorUid TEXT,"
          "editorNickname TEXT,"
          "year VARCHAR(10),"
          "imageUrl TEXT,"
          "isBookmarked INTEGER DEFAULT 0,"
          "bookmarkedAt INTEGER DEFAULT 0"
          ")");

  Future<void> deleteAllData() async =>
      await _db!.execute("DELETE FROM $tableName");

  Future<void> deleteTable() async =>
      await _db!.execute("DROP TABLE $tableName");
}
