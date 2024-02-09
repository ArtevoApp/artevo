import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/features/poll/poll_controller.dart';
import 'package:artevo/features/poll/poll_feedback_dialog.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class PollLayout extends ConsumerWidget {
  const PollLayout({super.key});

  @override
  Widget build(BuildContext context, ref) {
    if (ref.watch(showPollFeedBackProvider)) return const SizedBox.shrink();

    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: mediumPadding),
            child: Divider()),
        Text(context.loc.wouldYouRateTodaysContent, style: TextStyles.bodyv2),
        const SizedBox(height: xLargePadding),
        RatingBar.builder(
          initialRating: 2.5,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemPadding: const EdgeInsets.symmetric(horizontal: smallPadding),
          itemCount: 5,
          glowRadius: .1,
          itemBuilder: (_, i) => const Icon(Iconsax.heart5, color: Colors.teal),
          onRatingUpdate: (rating) => PollFeedBackDialog.show(context, rating),
        ),
      ],
    );
  }
}
