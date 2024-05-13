import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/cache/user_data_manager.dart';
import '../../../services/database/local/painting_local_data_manager.dart';
import 'package:artevo_package/models/painting_content.dart';

class PaintingRepository {
  PaintingRepository._();

  static PaintingRepository? _instance;

  static PaintingRepository get instance {
    _instance ??= PaintingRepository._();
    return _instance!;
  }

  final _localDB = PaintingLocalDataManager.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<List<PaintingContent>> getPaintingsRandomly({int? limit}) async {
    try {
      final paintingDatas = await _localDB.getDataRandomly(limit: limit);

      if (paintingDatas == null) return [];

      return paintingDatas.map(PaintingContent.fromMap).toList();
    } catch (e) {
      return [];
    }
  }

  /// Check if all painting data is saved.
  Future<bool> get checkSavedPaintingData async {
    try {
      final userDataService = UserDataManager.instance;

      // If painting data already saved, return true
      if (userDataService.getIsDataSavedToLocalDB(_localDB.tableName)) {
        return true;
      }
      // Else, calling some functions to save the data.

      // Check if painting table is created for save data. If not, create it.
      final tableControl = await _localDB.checkTableAndCreate();

      if (!tableControl) return false;

      // Fetch paintings data from firestore.
      final paintings = await _firestore.collection("paintings").get();

      // If paintings data is empty, return false.
      if (paintings.docs.isEmpty) return false;
      // Else, continue...

      // This is a flag for checking if all paintings data is saved.
      bool isDataSaved = false;

      for (var doc in paintings.docs) {
        final rows = (doc.data()["datas"] as List)
            .map((data) => data as Map<String, dynamic>)
            .toList();

        final rowsIsSaved = await _localDB.savePaintingData(rows);

        if (rowsIsSaved) {
          isDataSaved = true;
        } else {
          isDataSaved = false;
          break;
        }
      }

      if (isDataSaved) {
        await userDataService.setIsDataSavedToLocalDB(_localDB.tableName, true);
        return true;
      }

      return isDataSaved;
    } catch (e) {
      return false;
    }
  }
}
