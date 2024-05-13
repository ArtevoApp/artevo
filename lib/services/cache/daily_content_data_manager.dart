import 'dart:async';
import 'dart:convert';
import 'package:artevo_package/models/daily_content.dart';
import 'package:artevo_package/models/music_content.dart';
import 'package:artevo_package/models/painting_content.dart';
import 'package:artevo_package/models/painting_detail_content.dart';
import 'package:artevo_package/models/poetry_content.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// ? This service is used to store and cache daily content data in hive database.
class DailyContentDataManager {
  DailyContentDataManager._();

  static DailyContentDataManager? _instance; // Singleton instance

  static DailyContentDataManager get instance {
    _instance ??= DailyContentDataManager._();
    return _instance!;
  }

  static const _boxName = "dailyContentDataBox";

  static Box<dynamic> box = Hive.box(_boxName);

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await openBox();
    }
  }

  Future<void> openBox() async => box = await Hive.openBox(_boxName);

  bool isEmty() => box.isEmpty;

  String get getDate => box.get("title") as String? ?? "";

  /// set all data in [DailyContent] model.
  Future<void> setDailyContentData(DailyContent data) async {
    try {
      await box.putAll(data.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  /// fetching [DailyContent] data from cached content data.
  DailyContent? getDailycontent() {
    try {
      return DailyContent.fromMap(
          json.decode(json.encode(box.toMap())) as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  /// fetching [MusicContent] data from cached content data.
  MusicContent? getMusicData() {
    try {
      return MusicContent.fromMap(
          (box.get("music") as Map).cast<String, dynamic>());
    } catch (e) {
      return null;
    }
  }

  /// fetching [PaintingContent] data from cached content data.
  PaintingContent? getPaintingContentData() {
    try {
      return PaintingContent.fromMap(
          (box.get("painting") as Map).cast<String, dynamic>());
    } catch (e) {
      return null;
    }
  }

  /// fetching [PoetryContent] -poem  data from cached content data.
  PoetryContent? getPoetryContentData(String lang) {
    try {
      return PoetryContent.fromMap(
          (box.get("$lang" "Poetry") as Map).cast<String, dynamic>());
    } catch (e) {
      return null;
    }
  }

  /// fetching [PaintingDetailContent] -painting detail  data from cached content data.
  PaintingDetailContent? getPaintingDetail(String lang) {
    try {
      return PaintingDetailContent.fromMap(
          (box.get("$lang" "Detail") as Map).cast<String, dynamic>());
    } catch (e) {
      return null;
    }
  }

  Future<void> updateContent() async {
    box.put("painting", true);
  }

  /// get painting image url from daily content
  String? get getPaintingImageUrl => box.get("painting")["imageUrl"] as String?;

  /// clear box.
  Future<void> clearBox() async {
    await box.clear();
  }

  /// close box.
  Future<void> closeBox() async {
    await box.close();
  }
}
