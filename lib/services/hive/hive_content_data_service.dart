import 'package:artevo_package/models/content.dart';
import 'package:artevo_package/models/painting.dart';
import 'package:artevo_package/models/section.dart';
import 'package:artevo_package/models/song.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveContentDataService {
  final Box box = Hive.box('contentDataBox');

  HiveContentDataService() {
    if (!box.isOpen) {
      openBox();
    }
  }

  Future openBox() async => await Hive.openBox('contentDataBox');

  bool isEmty() => box.isEmpty;

  String getDate() => box.get("date").toString();

  /// set all data in [Content] model.
  Future<void> setAllData(Content data) async {
    try {
      await box.putAll(data.toMap());
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  /// fetching [Song] data from cached content data.
  Song? getSongData() {
    try {
      return Song.fromMap(box.get("song").cast());
    } catch (e) {
      return null;
    }
  }

  /// fetching [Painting] data from cached content data.
  Painting? getPaintingData() {
    try {
      return Painting.fromMap(box.get("painting").cast());
    } catch (e) {
      return null;
    }
  }

  /// fetching [Section] -poem  data from cached content data.
  Section? getPoemData(String lang) {
    try {
      return Section.fromMap(box.get("$lang" "Poem").cast());
    } catch (e) {
      return null;
    }
  }

  /// fetching [Section] -painting detail  data from cached content data.
  Section? getPaintingDetail(String lang) {
    try {
      return Section.fromMap(box.get("$lang" "PaintingDetail").cast());
    } catch (e) {
      return null;
    }
  }

  String allDatas() {
    return box.keys.toString();
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
