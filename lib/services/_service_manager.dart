import 'package:artevo/common/constants/strings.dart';
import 'package:artevo/services/firebase/firestore_service.dart';
import 'package:artevo/services/hive/hive_content_data_service.dart';
import 'package:artevo/services/firebase/realtime_service.dart';
import 'package:artevo_package/models/content.dart';
import 'package:artevo_package/models/version_data.dart';

// TODO: DATA MANAGER ŞEKLİNDE İSİMLENDİRİLEBİLİR
// SPLASH SCR MİXİN'DE KULLANILIYOR
class ServiceManger {
  Future<bool> checkContentData() async {
    try {
      var hiveBox = HiveContentDataService();

      DateTime now = await RealtimeService().getServerTime() ?? DateTime.now();

      String todayDate = "${now.year}-${now.month}-${now.day}";

      Content? fsContentData;

      if (hiveBox.isEmty() || hiveBox.getDate() != todayDate) {
        fsContentData = await FirestoreService().getContentData(todayDate);
        if (fsContentData != null) {
          await hiveBox.setAllData(fsContentData);
        } else {
          return false;
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkAppVersionData() async {
    try {
      VersionData? appVersionData = await RealtimeService().getAppVersion();

      if (appVersionData != null) {
        if (double.parse(appVersion) >=
            double.parse(appVersionData.lastVersion)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
