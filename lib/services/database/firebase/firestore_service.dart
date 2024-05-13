import 'package:artevo_package/models/daily_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// get daily content data from firestore by [date]
  Future<DailyContent?> getDailyContentData(String date) async {
    try {
      return await firestore
          .collection("dailyContent")
          .where("title", isEqualTo: date)
          .limit(1)
          .get()
          .then((value) => DailyContent.fromMap(value.docs.first.data()));
    } catch (e) {
      return null;
    }
  }
}
