import 'package:artevo_package/enums/content_type.dart';

import '../../../common/extensions/content_type_extension.dart';
import 'local_data_service.dart';

class MusicLocalDataManager extends LocalDataService {
  MusicLocalDataManager._();

  static MusicLocalDataManager? _instance;

  static MusicLocalDataManager get instance {
    _instance ??= MusicLocalDataManager._();
    return _instance!;
  }

  @override
  Future<void> init() async {
    await _createTable();
  }

  final service = LocalDataService.instance;

  final _db = LocalDataService.instance.database;

  final String _tableName = ContentType.musicContent.localDBTableName;

  String get tableName => _tableName;

  /* -------------------------- Last Listend Musics -------------------------- */

  /// Adds a new music data to the last listened music list.
  Future<void> addToLastListened(Map<String, dynamic> music) async {
    try {
      final String id = music["id"].toString();
      final result =
          await _db!.query(tableName, where: 'id = ?', whereArgs: [id]);
      if (result.isEmpty) {
        music.addAll(
          {
            'isBookmarked': 0,
            'bookmarkedAt': 0,
            'lastListenedTime': DateTime.now().microsecondsSinceEpoch,
          },
        );
        await _db.insert(tableName, music);
      } else {
        await _updateLastListenedTime(id);
      }
    } catch (e) {
      print("error $e");
      return;
    }
  }

  /// Get last listened musics.
  Future<List<Map<String, dynamic>>> getLastListened({int? limit}) async {
    try {
      return _db!.query(
        tableName,
        where: "lastListenedTime NOT NULL",
        orderBy: 'lastListenedTime DESC',
        limit: limit,
      );
    } catch (e) {
      return [];
    }
  }

  // update last listened time of music
  Future<void> _updateLastListenedTime(String id) async {
    try {
      final data = {'lastListenedTime': DateTime.now().microsecondsSinceEpoch};
      await _db!.update(tableName, data, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      return;
    }
  }

  /// Clear the last listened music list.
  Future<void> clearLastListened() async {
    try {
      await _db!.execute('''
    DELETE
    FROM $tableName 
    WHERE id 
    IN (
      SELECT id
      FROM $tableName
      WHERE isBookmarked = 0
      ) ''');
    } catch (e) {
      return;
    }
    return;
  }

  /// Delete old data from the last listened music list.
  /// Used to prevent the database from exceeding a certain size limit.
  /// Up to 60 unbookmarked songs are kept by default.
  Future<void> deleteOldData() async {
    try {
      final length = await _db!
          .rawQuery("SELECT COUNT(*) FROM $tableName WHERE isBookmarked = 0")
          .then((value) => value.length);

      if (length > 60) {
        await _db.execute('''
    DELETE
    FROM $tableName 
    WHERE id 
    IN (
      SELECT id
      FROM $tableName
      WHERE isBookmarked = 0
      ORDER BY lastListenedTime ASC
      LIMIT ($length - 30)) ''');
      }
    } catch (e) {
      return;
    }
    return;
  }

  Future<void> _createTable() async =>
      await _db!.execute("CREATE TABLE IF NOT EXISTS $tableName ("
          "id TEXT PRIMARY KEY,"
          "contentType TEXT,"
          "langCode TEXT,"
          "title TEXT,"
          "creator TEXT,"
          "editorUid TEXT,"
          "editorNickname TEXT,"
          "songID TEXT,"
          "thumbnailUrl TEXT,"
          "duration INTEGER,"
          "lastListenedTime INTEGER,"
          "isBookmarked INTEGER,"
          "bookmarkedAt INTEGER"
          ")");

  Future<void> deleteAll() async {
    try {
      await _db!.execute('''
    DELETE FROM $tableName ''');
    } catch (e) {
      return;
    }
    return;
  }

  Future<void> deleteTable() async =>
      await _db!.execute("DROP TABLE $tableName");
}
