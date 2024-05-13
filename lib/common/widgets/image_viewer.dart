import 'dart:io';
import '../constants/dimens.dart';
import '../../localization/app_localizations_context.dart';
import '../../services/cache/persistent_image_cache_manager.dart';
import '../../services/cache/temp_image_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:ionicons/ionicons.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer(
      {super.key,
      required this.url,
      this.byDownloading,
      this.height,
      this.width,
      this.boxFit,
      this.borderRadius});

  final String url;
  final bool? byDownloading;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final source = (byDownloading ?? false)
        ? PersistentImageCacheManager.instance
            .getFileStream(url, withProgress: true)
        : TempImageCacheManager.instance.getFileStream(url, withProgress: true);

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? smallPadding),
        child: StreamBuilder<FileResponse>(
          stream: source,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data is! DownloadProgress) {
              return Image(
                image: FileImage(File((snapshot.data! as FileInfo).file.path)),
                fit: boxFit ?? BoxFit.cover,
                errorBuilder: errorBuilder(),
              ).animate().fadeIn(duration: 400.milliseconds);
            } else if (snapshot.hasError) {
              if (snapshot.error.toString().contains("ClientException")) {
                return const SizedBox.shrink();
              }
              return Tooltip(
                message: context.loc.imageNotFound,
                child: const Icon(Ionicons.image_outline),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget Function(BuildContext, Object, StackTrace?)? errorBuilder() =>
      (context, error, stackTrace) {
        return Tooltip(
          message: context.loc.imageNotFound,
          child: Icon(
            Icons.image_not_supported_outlined,
            size: (height ?? smallImageSize) / 3,
          ),
        );
      };
}
