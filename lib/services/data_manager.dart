import '../common/constants/strings.dart';
import '../common/enums/errors.dart';
import 'database/firebase/firestore_service.dart';
import 'cache/daily_content_data_manager.dart';
import 'database/firebase/realtime_service.dart';
import 'package:artevo_package/models/version_data.dart';

class DataManager {
  DataManager._();

  static DataManager? _instance;

  static DataManager get instance {
    _instance ??= DataManager._();
    return _instance!;
  }

  Future<Object> checkDailyContentData() async {
    try {
      final clientTime = DateTime.now().toLocal();
      final serverTime = await RealtimeService().getServerTime();
      if (serverTime == null) return Future.error(IError.errInternetConnection);
      if (clientTime.difference(serverTime).inSeconds > 10) {
        return Future.error(IError.errTimeSync);
      }
      final repository = DailyContentDataManager.instance;
      final todayDate =
          "${serverTime.year}-${serverTime.month}-${serverTime.day}";

      if (repository.isEmty() || repository.getDate != todayDate) {
        final fsContentData =
            await FirestoreService().getDailyContentData(todayDate);

        if (fsContentData != null) {
          await repository.setDailyContentData(fsContentData);
          return fsContentData;
        } else {
          return Future.error(IError.errContentNotFound);
        }
      } else {
        return repository.getDailycontent() ??
            Future.error(IError.errContentNotFound);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> get checkAppVersionData async {
    try {
      final VersionData? appVersionData =
          await RealtimeService().getAppVersion();

      if (appVersionData != null) {
        if (double.parse(appVersion) >=
            double.parse(appVersionData.lastVersion)) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
