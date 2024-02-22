import 'package:artevo/common/config/routes.dart';
import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/services/hive/hive_content_data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaintingView extends StatelessWidget {
  const PaintingView({super.key});

  @override
  Widget build(BuildContext context) {
    final painting =
        HiveDailyContentDataService.instance.getPaintingContentData();

    if (painting == null) return const SizedBox.shrink();

    return Column(
      children: [
        InkWell(
            onTap: () =>
                Navigator.pushNamed(context, Screens.paintingDetail.routeName),
            child: ImageViewer(url: painting.imageUrl)),
        const SizedBox(height: defaultPadding),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: smallPadding,
          children: [
            Text(painting.title,
                style: TextStyles.bodyv2, textAlign: TextAlign.center),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              minSize: xsmallImageSize,
              child: Text(context.loc.more, style: TextStyles.bodyv2),
              onPressed: () => Navigator.pushNamed(
                  context, Screens.paintingDetail.routeName),
            ),
          ],
        ),
      ],
    );
  }
}
