import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/features/pool/poll_controller.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/services/firebase/realtime_service.dart';
import 'package:artevo/services/hive/hive_content_data_service.dart';
import 'package:artevo/services/hive/hive_user_data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

/// It holds bool value to show "thanks" content when the submit button is pressed.
final _pollFeedbackDialogShowThanksStatus =
    StateProvider.autoDispose<bool>((ref) => false);

class PollFeedBackDialog extends ConsumerWidget {
  const PollFeedBackDialog({super.key, required this.rating});

  final double rating;

  static Future<void> show(BuildContext context, double ratinga) async {
    return showDialog(
        context: context,
        builder: (context) => PollFeedBackDialog(rating: ratinga));
  }

  @override
  Widget build(BuildContext context, ref) {
    String feedback = "";
    bool showThanks = ref.watch(_pollFeedbackDialogShowThanksStatus);
    return AlertDialog(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(showThanks ? context.loc.thanks : context.loc.sendFeedback),
        const CloseButton()
      ]),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.heart4, color: Colors.teal),
                    Text(" $rating", style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: defaultPadding),
                TextField(
                    onChanged: (v) => feedback = v,
                    maxLines: 4,
                    maxLength: 140,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        hintText: context.loc.addAComment))
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
                String date = HiveContentDataService().getDate();
                RealtimeService().sendPollFeedBack(
                    date: date, feedback: feedback, rating: rating);
                HiveUserDataService().setLastPollFeedbackDate(date);
                ref.read(showPollFeedBackProvider.notifier).state = true;
                ref.read(_pollFeedbackDialogShowThanksStatus.notifier).state =
                    true;
              },
              child: Text(context.loc.sendFeedback)),
        }
      ],
    );
  }
}
