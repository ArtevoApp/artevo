import 'dart:io';
import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/widgets/loader.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/services/cache/persistent_image_cache_manager.dart';
import 'package:artevo/services/cache/temp_image_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer(
      {super.key,
      required this.url,
      this.byDownloading,
      this.height,
      this.width,
      this.boxFit,
      this.opacity});

  final String url;
  final bool? byDownloading;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final double? opacity;

  @override
  Widget build(BuildContext context) {
    final stream = (byDownloading ?? false)
        ? PersistentImageCacheManager.instance.getFileStream(url)
        : TempImageCacheManager.instance.getFileStream(url);

    if (byDownloading ?? false) {
      print("persistent");
    } else {
      print("temp");
    }

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(smallPadding),
        child: StreamBuilder<FileResponse>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data is! DownloadProgress) {
              return Image(
                image: FileImage(File((snapshot.data! as FileInfo).file.path)),
                opacity: AlwaysStoppedAnimation(opacity ?? 1),
                fit: boxFit ?? BoxFit.cover,
                errorBuilder: errorBuilder(),
              );
            } else if (snapshot.hasError) {
              return Tooltip(
                message: context.loc.imageNotFound,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: (height ?? smallImageSize) / 3,
                ),
              );
            } else {
              return const Loader();
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
