import '../../../../common/constants/dimens.dart';
import '../../../../common/constants/paths.dart';
import '../../controllers/content_rating_controllers.dart';
import '../../../../localization/app_localizations_context.dart';
import '../../../../services/database/firebase/realtime_service.dart';
import '../../../../services/cache/daily_content_data_manager.dart';
import '../../../../services/cache/user_data_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final TextEditingController commentController =
        TextEditingController(text: "");
    final bool showThanks = ref.watch(ratingFeedbackDialogShowThanksStatus);
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
                        backgroundImage: AssetImage(vincentPath)),
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
                final String date = DailyContentDataManager.instance.getDate;
                RealtimeService().sendPollFeedBack(
                    date: date,
                    comment: commentController.text,
                    rating: rating);
                UserDataManager.instance.setLastPollFeedbackDate(date);
                ref.read(showContentRatingProvider.notifier).state = false;
                ref.read(ratingFeedbackDialogShowThanksStatus.notifier).state =
                    true;
              },
              child: Text(context.loc.submit)),
        }
      ],
    );
  }
}
