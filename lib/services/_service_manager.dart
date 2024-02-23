import 'package:artevo/common/constants/strings.dart';
import 'package:artevo/services/firebase/firestore_service.dart';
import 'package:artevo/services/hive/hive_daily_content_data_service.dart';
import 'package:artevo/services/firebase/realtime_service.dart';
import 'package:artevo_package/models/version_data.dart';
import 'package:artevo_package/modev2/daily_content.dart';

// TODO: change class name
class ServiceManger {
  Future<bool> checkContentData() async {
    try {
      var hiveBox = HiveDailyContentDataService.instance;

      DateTime now = await RealtimeService().getServerTime() ?? DateTime.now();

      String todayDate = "${now.year}-${now.month}-${now.day}";

      if (hiveBox.isEmty() || hiveBox.getDate() != todayDate) {
        DailyContent? fsContentData =
            await FirestoreService().getContentData(todayDate);
        if (fsContentData != null) {
          await hiveBox.setDailyContentData(fsContentData);
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
