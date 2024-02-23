import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/paths.dart';
import 'package:artevo/features/rating/controllers/content_rating_controllers.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/services/firebase/realtime_service.dart';
import 'package:artevo/services/hive/hive_daily_content_data_service.dart';
import 'package:artevo/services/hive/hive_user_data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// It holds bool value to show "thanks" content when the submit button is pressed.
final _ratingFeedbackDialogShowThanksStatus =
    StateProvider.autoDispose<bool>((ref) => false);

class ContentRatingFeedBackDialog extends ConsumerWidget {
  const ContentRatingFeedBackDialog({super.key, required this.rating});

  final double rating;

  static Future<void> show(BuildContext context, double rating) async {
    return showDialog(
        context: context,
        builder: (context) => ContentRatingFeedBackDialog(rating: rating));
  }

  @override
  Widget build(BuildContext context, ref) {
    TextEditingController commentController = TextEditingController(text: "");
    bool showThanks = ref.watch(_ratingFeedbackDialogShowThanksStatus);
    return AlertDialog(
      scrollable: true,
      title: Text(context.loc.submitFeedback),
      content: SizedBox(
          width: dialogWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showThanks) ...{
                Column(
                  children: [
                    const Icon(CupertinoIcons.check_mark,
                        color: Colors.green, size: 30),
                    const SizedBox(height: defaultPadding),
                    Text(context.loc.thanksForYourFeedback),
                  ],
                ).animate().fade(delay: const Duration(milliseconds: 300))
              } else ...{
                TextField(
                    //onChanged: (v) => commentController.text = v,
                    controller: commentController,
                    maxLines: 4,
                    maxLength: 140,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        hintText: context.loc.addAComment)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                        radius: xsmallImageSize / 2,
                        backgroundImage: AssetImage(vincent)),
                    Text(" $rating", style: const TextStyle(fontSize: 18)),
                  ],
                ),
              }
            ],
          )),
      actions: [
        if (showThanks) ...{
          FilledButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.loc.back))
        } else ...{
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.loc.cancel)),
          FilledButton(
              onPressed: () async {
                String date = HiveDailyContentDataService.instance.getDate();
                RealtimeService().sendPollFeedBack(
                    date: date,
                    comment: commentController.text,
                    rating: rating);
                HiveUserDataService.instance.setLastPollFeedbackDate(date);
                ref.read(showContentRatingProvider.notifier).state = true;
                ref.read(_ratingFeedbackDialogShowThanksStatus.notifier).state =
                    true;
              },
              child: Text(context.loc.submit)),
        }
      ],
    );
  }
}
