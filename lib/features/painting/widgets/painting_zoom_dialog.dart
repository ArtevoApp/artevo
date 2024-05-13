import '../../../common/config/color_schemes.dart';
import '../../../common/constants/dimens.dart';
import '../../../common/constants/text_styles.dart';
import '../../../common/widgets/bookmarking_button.dart';
import '../../../common/widgets/image_viewer.dart';
import 'package:artevo_package/models/painting_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:widget_zoom/widget_zoom.dart';

class PaintingZoomDialog extends StatelessWidget {
  const PaintingZoomDialog({super.key, required this.painting});

  final PaintingContent painting;

  static Future<void> show(
      BuildContext context, PaintingContent painting) async {
    await showDialog(
        barrierColor: Colors.black.withOpacity(.8),
        context: context,
        builder: (context) => PaintingZoomDialog(painting: painting));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(largePadding),
      scrollable: true,
      backgroundColor: Colors.transparent,
      content: SizedBox(
        width: 500,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetZoom(
                  heroAnimationTag: 'paintingZoom',
                  zoomWidget: ImageViewer(
                    url: painting.imageUrl,
                    boxFit: BoxFit.contain,
                    width: 400,
                  ),
                ),
                Container(
                  width: columnWidth,
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: darkColorScheme.background,
                    border: Border(
                      top: BorderSide(
                          color: lightColorScheme.background, width: .5),
                    ),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(smallPadding),
                    ),
                  ),
                  child: Text(
                      "${painting.title} by ${painting.creator}, ${painting.year}",
                      style: TextStyles.info
                          .copyWith(color: lightColorScheme.background),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
            Positioned(
              top: hugeIconSize + xLargePadding,
              right: smallPadding,
              child: BookmarkingButton.withBackground(painting),
            ),
            Positioned(
              top: smallPadding,
              right: smallPadding,
              child: CircleAvatar(
                  radius: smallIconSize,
                  child: CloseButton(color: lightColorScheme.background),
                  backgroundColor: darkColorScheme.background),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.milliseconds);
  }
}
