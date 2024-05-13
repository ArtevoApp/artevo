import '../../../common/constants/dimens.dart';
import '../../../common/widgets/image_viewer.dart';
import 'painting_zoom_dialog.dart';
import 'package:artevo_package/models/painting_content.dart';
import 'package:flutter/material.dart';

class PaintingCard extends StatelessWidget {
  const PaintingCard({super.key, required this.painting});

  final PaintingContent painting;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.surface;

    final title = " ${painting.title} ";
    final creator = " ${painting.creator} ";

    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(vertical: smallPadding),
      child: InkWell(
        onTap: () => PaintingZoomDialog.show(context, painting),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (rect) {
                return LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: <double>[0, 0],
                        colors: [backgroundColor, Colors.transparent])
                    .createShader(rect);
              },
              child: Opacity(
                opacity: .8,
                child: ImageViewer(
                    url: painting.imageUrl, byDownloading: true, height: 200),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ImageViewer(
                      byDownloading: true,
                      url: painting.imageUrl,
                      borderRadius: 4,
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: textWidget(title, backgroundColor),
                      subtitle: textWidget(creator, backgroundColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text textWidget(String title, Color backgroundColor) {
    return Text(
      title,
      textAlign: TextAlign.end,
      style: const TextStyle(color: Colors.white),
    );
  }
}
