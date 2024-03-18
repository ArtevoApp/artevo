import 'package:artevo/common/config/color_schemes.dart';
import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/common/widgets/add_bookmark_button.dart';
import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo_package/models/painting_content.dart';
import 'package:flutter/material.dart';
import 'package:widget_zoom/widget_zoom.dart';

class PaintingZoomDialog extends StatelessWidget {
  const PaintingZoomDialog({super.key, required this.painting});

  final PaintingContent painting;

  static Future<void> show(
      BuildContext context, PaintingContent painting) async {
    await showDialog(
        barrierColor: Colors.black.withOpacity(.5),
        context: context,
        builder: (context) => PaintingZoomDialog(painting: painting));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      insetPadding: EdgeInsets.all(16),
      scrollable: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: SizedBox(
        width: columnWidth,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetZoom(
                  heroAnimationTag: 'tag',
                  zoomWidget: ImageViewer(
                      url: painting.imageUrl,
                      boxFit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width),
                ),
                Container(
                  width: columnWidth,
                  padding: EdgeInsets.all(defaultPadding),
                  child: Text(
                      "${painting.title} by ${painting.creator}, ${painting.year}",
                      style: TextStyles.info,
                      textAlign: TextAlign.center),
                ),
              ],
            ),
            Positioned(
              top: hugeIconSize + xLargePadding,
              right: smallPadding,
              child: CircleAvatar(
                  radius: smallIconSize,
                  child: AddBookmarkButton(
                    size: hugeIconSize,
                    iconSize: defaultIconSize,
                    color: lightColorScheme.background,
                    content: painting,
                  ),
                  backgroundColor: darkColorScheme.background),
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
    );
  }
}
