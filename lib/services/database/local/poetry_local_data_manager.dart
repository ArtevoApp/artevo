import 'package:artevo_package/enums/content_type.dart';

import '../../../common/extensions/content_type_extension.dart';
import 'local_data_service.dart';

class PoetryLocalDataManager extends LocalDataService {
  PoetryLocalDataManager._();

  static PoetryLocalDataManager? _instance;

  static PoetryLocalDataManager get instance {
    _instance ??= PoetryLocalDataManager._();
    return _instance!;
  }

  @override
  Future<void> init() async {
    await _createTable();
  }

  final service = LocalDataService.instance;

  final _db = LocalDataService.instance.database;

  final _tableName = ContentType.poetryContent.localDBTableName;

  String get tableName => _tableName;

  Future<void> _createTable() async =>
      await _db!.execute("CREATE TABLE IF NOT EXISTS $tableName ("
          "id TEXT PRIMARY KEY,"
          "contentType TEXT,"
          "langCode TEXT,"
          "title TEXT,"
          "creator TEXT,"
          "editorUid TEXT,"
          "editorNickname TEXT,"
          "poem TEXT,"
          "isBookmarked INTEGER,"
          "bookmarkedAt INTEGER"
          ")");

  Future<void> deleteAllData() async =>
      await _db!.execute("DELETE FROM $tableName");

  Future<void> deleteTable() async =>
      await _db!.execute("DROP TABLE $tableName");
}
