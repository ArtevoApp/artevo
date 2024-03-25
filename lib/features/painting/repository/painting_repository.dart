import 'package:artevo/services/local_db/local_db_painting_service.dart';
import 'package:artevo_package/models/painting_content.dart';

class PaintingRepository {
  PaintingRepository._();

  static final localDB = LocalDBPaintingService.instance;

  static Future<List<PaintingContent>> getPaintingsRandomly() async {
    try {
      final paintingDatas = await localDB.getDataRandomly();

      if (paintingDatas == null) return [];

      return paintingDatas.map((e) => PaintingContent.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<PaintingContent>> getPaintingsBySearchText(
      String searchText) async {
    try {
      final paintingDatas =
          await localDB.getDataBySearchText(searchText.trim());

      if (paintingDatas == null) return [];

      return paintingDatas.map((e) => PaintingContent.fromMap(e)).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
