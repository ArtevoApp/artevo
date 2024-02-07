import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../../common/widgets/image_viewer_wiget.dart';

class PaintingZoomScreen extends StatelessWidget {
  const PaintingZoomScreen({super.key, required this.url});
  final String url;

  static Future<void> show(
      {required String url, required BuildContext context}) async {
    await showDialog(
        barrierColor: Theme.of(context).scaffoldBackgroundColor,
        context: context,
        builder: (context) => PaintingZoomScreen(url: url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.back),
        centerTitle: false,
      ),
      body: Zoom(
        initTotalZoomOut: true,
        backgroundColor: Colors.transparent,
        child: ImageViewerWidget(imageUrl: url),
      ),
    );
  }
}
