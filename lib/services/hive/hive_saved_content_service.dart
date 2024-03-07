import 'package:hive_flutter/hive_flutter.dart';

class HiveSavedContentService {
  HiveSavedContentService._();

  static HiveSavedContentService? _instance; // Singleton instance

  static HiveSavedContentService get instance {
    _instance ??= HiveSavedContentService._();
    return _instance!;
  }

  static const _boxName = "hiveSavedContent";

  late LazyBox box;

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) box = await Hive.openLazyBox(_boxName);
  }

  Future<bool> setContent(String key, Map data) async {
    try {
      await box.put(key, data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map>?> getContents(int page) async {
    try {
      List<Map> contentDatas = [];

      int limit = 10;

      int maxIndex = box.keys.length - 1;

      int startIndex = page * limit;
      int endIndex =
          startIndex + limit > maxIndex ? maxIndex + 1 : startIndex + limit;

      for (int i = startIndex; i < endIndex; i++) {
        contentDatas.add(await box.getAt(maxIndex - i));
      }

      return contentDatas;
    } catch (e) {
      return null;
    }
  }

  Future<bool> removeContent(String key) async {
    try {
      await box.delete(key);
      return true;
    } catch (e) {
      return false;
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
