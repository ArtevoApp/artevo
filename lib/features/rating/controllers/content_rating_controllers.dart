import '../../../services/cache/daily_content_data_manager.dart';
import '../../../services/cache/user_data_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final showContentRatingProvider = StateProvider.autoDispose<bool>((ref) {
  final String lastFeedBackDate =
      UserDataManager.instance.getLastPollFeedbackDate();
  final String contentDate = DailyContentDataManager.instance.getDate;

  return contentDate != lastFeedBackDate;
});

/// It holds bool value to show "thanks" content when the submit button is pressed.
final ratingFeedbackDialogShowThanksStatus =
    StateProvider.autoDispose<bool>((ref) => false);
