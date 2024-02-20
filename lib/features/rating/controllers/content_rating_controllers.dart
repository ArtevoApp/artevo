import 'package:artevo/services/hive/hive_content_data_service.dart';
import 'package:artevo/services/hive/hive_user_data_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final showContentRatingProvider = StateProvider.autoDispose<bool>((ref) {
  String lastFeedBackDate = HiveUserDataService().getLastPollFeedbackDate();
  String contentDate = HiveContentDataService().getDate();

  return contentDate != lastFeedBackDate;
});
