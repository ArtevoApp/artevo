import 'dart:io';
import 'package:artevo/services/api/ip_address_service.dart';
import 'package:artevo_package/models/version_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class RealtimeService {
  final _firebase = FirebaseDatabase.instance;

  Future<DateTime?> getServerTime() async {
    try {
      var time = ServerValue.timestamp;

      _firebase.ref("time").set({"time": time});

      var timestamp = await _firebase.ref("time/time").get();

      return DateTime.fromMillisecondsSinceEpoch(timestamp.value as int);
    } catch (e) {
      return null;
    }
  }

  Future<VersionData?> getAppVersion() async {
    try {
      String platform = Platform.isIOS
          ? "ios"
          : Platform.isAndroid
              ? "android"
              : "unknow";
      if (platform == "unknow") {
        return null;
      } else {
        DataSnapshot snapshot =
            await _firebase.ref("app/versions/$platform").get();
        return VersionData.fromMap(snapshot.value as Map);
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> getAppDownloadLink() async {
    try {
      String platform = Platform.isIOS
          ? "ios"
          : Platform.isAndroid
              ? "android"
              : "unknow";
      if (platform == "unknow") {
        return null;
      } else {
        DataSnapshot snapshot =
            await _firebase.ref("app/versions/$platform/downloadUrl").get();

        return snapshot.value.toString();
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> sendPollFeedBack(
      {required String date,
      required String feedback,
      required double rating}) async {
    try {
      String uuid = const Uuid().v4();

      Map<String, dynamic> data = {
        "uuid": uuid,
        "date": date,
        "feedback": feedback,
        "rating": rating,
        "ip": await IpAddressService.getIpAddress()
            .then((v) => v != null ? v.toMap() : {})
      };

      await _firebase.ref("poll/$date/$uuid").set(data);
    } catch (e) {
      return;
    }
  }
}
