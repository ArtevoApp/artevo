import 'package:artevo_package/services/music_service.dart';
import 'package:flutter/material.dart';

class DiscoverPaintingSegmentView extends StatelessWidget {
  const DiscoverPaintingSegmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () async {
            String url =
                "https://tubidy.cool/watch/zXaIEMk7djEuygoVgYed9g_3D_3D/mp4/fs";

            String? sourc = await MusicService.streamUrlFromSourceUrl(url);

            print(sourc);

            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => Scaffold(
            //             appBar: AppBar(),
            //             body: WebViewWidget(
            //                 controller: webViewController(url)))));
          },
          child: Text("test")),
    );
  }
}
