import 'package:artevo/localization/app_localizations_context.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageViewerWidget extends StatelessWidget {
  const ImageViewerWidget({super.key, required this.imageUrl});

  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      errorWidget: (context, url, error) =>
          Text(context.loc.errorPaintingLoaded),
    );
  }
}
