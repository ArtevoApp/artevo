import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/features/rating/controllers/content_rating_controllers.dart';
import 'package:artevo/features/rating/view/widgets/content_rating_bar.dart';

import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContectRatingView extends ConsumerWidget {
  const ContectRatingView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    if (!ref.watch(showContentRatingProvider)) return const SizedBox.shrink();

    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: mediumPadding),
            child: Divider()),
        Text(context.loc.wouldYouRateTodaysContent, style: TextStyles.bodyv2),
        const SizedBox(height: xLargePadding),
        const ContentRatingBar(),
      ],
    );
  }
}
