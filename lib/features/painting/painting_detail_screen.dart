import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo/features/painting/painting_zoom_screen.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/services/hive/hive_content_data_service.dart';
import 'package:artevo_package/models/painting.dart';
import 'package:artevo_package/models/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class PaintingDetailScreen extends ConsumerWidget {
  const PaintingDetailScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    Painting? painting = HiveContentDataService().getPaintingData() ??
        Painting(painter: "", name: "", year: "", category: "", imageUrl: "");

    Section paintingDetail =
        HiveContentDataService().getPaintingDetail(context.loc.langCode) ??
            Section(title: "", content: "", author: "");

    return Scaffold(
        appBar: AppBar(title: Text(painting.name)),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: 600,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => PaintingZoomScreen.show(
                              url: painting.imageUrl, context: context),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              ImageViewer(url: painting.imageUrl),
                              const Icon(Icons.zoom_out_map_outlined,
                                  color: Colors.white, size: 32),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text("${painting.painter} - ${painting.name}",
                            style: TextStyles.body,
                            textAlign: TextAlign.center),
                        Text("(${painting.year},${painting.category})",
                            style: TextStyles.info,
                            textAlign: TextAlign.center),
                        const SizedBox(height: 8),

                        //? painting detail is not found
                        if (paintingDetail.content.length <= 5)
                          Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: Text(
                              context.loc.contentIsNotFound,
                              style: TextStyles.body,
                              textAlign: TextAlign.center,
                            ),
                          ),

                        //? painting detail
                        if (paintingDetail.content.length > 5)
                          Column(
                            children: [
                              // * Title
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  paintingDetail.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyles.title,
                                ),
                              ),

                              // * TEXT
                              Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    paintingDetail.content,
                                    style: TextStyles.body,
                                  )),
                              // * Author
                              ListTile(
                                  title: Text(paintingDetail.author,
                                      textAlign: TextAlign.end),
                                  trailing: const Icon(Iconsax.user)),
                            ],
                          ),
                        const SizedBox(height: 200),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
