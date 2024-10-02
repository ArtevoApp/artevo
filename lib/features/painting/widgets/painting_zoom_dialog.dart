import '../../../core/config/color_schemes.dart';
import '../../../common/constants/dimens.dart';
import '../../../common/constants/text_styles.dart';
import '../../../common/widgets/bookmarking_button.dart';
import '../../../common/widgets/full_screen_image_viewer.dart';
import '../../../common/widgets/image_viewer.dart';
import 'package:artevo_package/models/painting_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
      scrollable: true,
      contentPadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(largePadding),
      backgroundColor: Colors.transparent,
      content: SizedBox(
        width: 600,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => FullScreenImageViewer.open(
                      context: context, painting: painting),
                  child: ImageViewer(
                    url: painting.imageUrl,
                    boxFit: BoxFit.contain,
                  ),
                ),
                Container(
                  width: columnWidth,
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: darkColorScheme.surface,
                    border: Border(
                      top: BorderSide(
                        color: lightColorScheme.surface,
                        width: .3,
                      ),
                    ),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(smallPadding),
                    ),
                  ),
                  child: SelectableText(
                      "${painting.title} by ${painting.creator}, ${painting.year}",
                      style: TextStyles.b2
                          .copyWith(color: lightColorScheme.surface),
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
                  child: CloseButton(color: lightColorScheme.surface),
                  backgroundColor: darkColorScheme.surface),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.milliseconds);
  }
}
