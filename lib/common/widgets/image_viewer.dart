import 'dart:io';
import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/widgets/loader.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer(
      {super.key, required this.url, this.height, this.width, this.boxFit});

  final String url;
  final double? width;
  final double? height;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(smallPadding),
        child: StreamBuilder<FileResponse>(
          stream: DefaultCacheManager().getImageFile(url),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data is! DownloadProgress) {
              return Image(
                image: FileImage(File((snapshot.data! as FileInfo).file.path)),
                fit: boxFit ?? BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Tooltip(
                    message: context.loc.imageNotFound,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: (height ?? smallImageSize) / 3,
                    ),
                  );
                },
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
}
