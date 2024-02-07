import 'package:artevo_package/models/content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// get content data from firestore by [date]
  Future<Content?> getContentData(String date) async {
    try {
      return await firestore
          .collection("contents")
          .where("date", isEqualTo: date)
          .limit(1)
          .get()
          .then((value) => Content.fromMap(value.docs.first.data()));
    } catch (e) {
      return null;
    }
  }
}
