import 'package:artevo_package/models/daily_content.dart';
import 'package:artevo_package/models/music_content.dart';
import 'package:artevo_package/models/painting_content.dart';
import 'package:artevo_package/models/painting_detail_content.dart';
import 'package:artevo_package/models/poetry_content.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// ? This service is used to store and cache daily content data in hive database.
class HiveDailyContentDataService {
  HiveDailyContentDataService._();

  static HiveDailyContentDataService? _instance; // Singleton instance

  static HiveDailyContentDataService get instance {
    _instance ??= HiveDailyContentDataService._();
    return _instance!;
  }

  static const _boxName = "dailyContentDataBox";

  static Box box = Hive.box(_boxName);

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      box = await openBox();
    }
  }

  Future openBox() async => await Hive.openBox(_boxName);

  bool isEmty() => box.isEmpty;

  String getDate() => box.get("title").toString();

  /// set all data in [DailyContent] model.
  Future<void> setDailyContentData(DailyContent data) async {
    try {
      await box.putAll(data.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  /// fetching [MusicContent] data from cached content data.
  MusicContent? getMusicData() {
    try {
      return MusicContent.fromMap(box.get("music").cast<String, dynamic>());
    } catch (e) {
      return null;
    }
  }

  /// fetching [PaintingContent] data from cached content data.
  PaintingContent? getPaintingContentData() {
    try {
      return PaintingContent.fromMap(
          box.get("painting").cast<String, dynamic>());
    } catch (e) {
      return null;
    }
  }

  /// fetching [PoetryContent] -poem  data from cached content data.
  PoetryContent? getPoetryContentData(String lang) {
    try {
      return PoetryContent.fromMap(
          box.get("$lang" "Poetry").cast<String, dynamic>());
    } catch (e) {
      return null;
    }
  }

  /// fetching [PaintingDetailContent] -painting detail  data from cached content data.
  PaintingDetailContent? getPaintingDetail(String lang) {
    try {
      return PaintingDetailContent.fromMap(
          box.get("$lang" "Detail").cast<String, dynamic>());
    } catch (e) {
      return null;
    }
  }

  /// clear box.
  Future<void> clearBox() async {
    await box.clear();
  }

  /// close box.
  Future<void> closeBox() async {
    await box.close();
  }
}
