import 'dart:io';
import 'package:artevo_package/models/version_data.dart';
import 'package:firebase_database/firebase_database.dart';

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
}
