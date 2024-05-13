import 'dart:io';
import '../../apis/ip_address_service.dart';
import 'package:artevo_package/models/version_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class RealtimeService {
  final _firebase = FirebaseDatabase.instance;

  Future<DateTime?> getServerTime() async {
    try {
      final time = ServerValue.timestamp;

      await _firebase.ref("time").set({"time": time});

      final timestamp = await _firebase.ref("time/time").get();

      return DateTime.fromMillisecondsSinceEpoch(timestamp.value as int);
    } catch (e) {
      return null;
    }
  }

  Future<VersionData?> getAppVersion() async {
    try {
      final String platform = Platform.isIOS
          ? "ios"
          : Platform.isAndroid
              ? "android"
              : "unknow";
      if (platform != "unknow") {
        final DataSnapshot snapshot =
            await _firebase.ref("app/versions/$platform").get();
        return VersionData.fromMap(snapshot.value as Map);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> getAppDownloadLink() async {
    try {
      final String platform = Platform.isIOS
          ? "ios"
          : Platform.isAndroid
              ? "android"
              : "unknow";
      if (platform == "unknow") {
        return null;
      } else {
        final DataSnapshot snapshot =
            await _firebase.ref("app/versions/$platform/downloadUrl").get();

        return snapshot.value.toString();
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> sendPollFeedBack(
      {required String date,
      required String comment,
      required double rating}) async {
    try {
      final String uuid = const Uuid().v4();

      final Map<String, dynamic> data = {
        "uuid": uuid,
        "date": date,
        "comment": comment,
        "rating": rating,
        "ip":
            await IpAddressService.getIpAddress.then((value) => value?.toMap()),
      };

      await _firebase.ref("poll/$date/$uuid").set(data);
    } catch (e) {
      return;
    }
  }
}
