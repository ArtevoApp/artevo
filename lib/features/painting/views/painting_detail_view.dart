import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo/features/painting/views/painting_zoom_view.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/services/hive/hive_content_data_service.dart';
import 'package:artevo_package/models/painting.dart';
import 'package:artevo_package/models/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

// TODO: make this class modular.

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
              padding: const EdgeInsets.all(defaultPadding),
              child: SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: 600, // TODO: fix, make it responsive
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
                                  color: Colors.white, size: xLargeIconSize),
                            ],
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        Text("${painting.painter} - ${painting.name}",
                            style: TextStyles.body,
                            textAlign: TextAlign.center),
                        Text("(${painting.year}${painting.category})",
                            style: TextStyles.info,
                            textAlign: TextAlign.center),
                        const SizedBox(height: defaultPadding),

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
