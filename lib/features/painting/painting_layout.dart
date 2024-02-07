import 'package:artevo/common/config/routes.dart';
import 'package:artevo/common/widgets/image_viewer_wiget.dart';
import 'package:artevo/features/painting/painting_detail_screen.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/services/hive/hive_content_data_service.dart';
import 'package:artevo_package/models/painting.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PaintingLayot extends StatelessWidget {
  const PaintingLayot({super.key});

  @override
  Widget build(BuildContext context) {
    Painting painting = HiveContentDataService().getPaintingData() ??
        Painting(name: "", imageUrl: "", category: "", painter: "", year: "");

    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PaintingDetailScreen())),
          child: ImageViewerWidget(imageUrl: painting.imageUrl),
        ),
        const SizedBox(height: 8),
        SelectableText.rich(
          TextSpan(
            text: painting.name,
            children: <InlineSpan>[
              TextSpan(
                  text: "  ${context.loc.more}",
                  style: const TextStyle(color: Colors.teal),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.pushNamed(
                        context, Screens.paintingDetail.routeName))
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
