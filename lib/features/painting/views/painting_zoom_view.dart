import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';

class PaintingZoomScreen extends StatelessWidget {
  const PaintingZoomScreen({super.key, required this.url});

  // image url
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
      appBar: AppBar(title: Text(context.loc.back), centerTitle: false),
      body: Zoom(
        maxScale: 25,
        initTotalZoomOut: true,
        backgroundColor: Colors.transparent,
        canvasColor: Colors.transparent,
        child: ImageViewer(url: url, width: MediaQuery.of(context).size.width),
      ),
    );
  }
}
