import 'dart:io';
import 'package:artevo/common/widgets/loader.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AlbumCoverImage extends StatelessWidget {
  const AlbumCoverImage({super.key, required this.url, this.size});

  final String url;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 65,
      height: size ?? 65,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: StreamBuilder<FileResponse>(
          stream: DefaultCacheManager().getImageFile(url),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data is! DownloadProgress) {
              return Image(
                image: FileImage(File((snapshot.data! as FileInfo).file.path)),
                errorBuilder: (context, error, stackTrace) {
                  return Tooltip(
                      message: context.loc.imageNotFound,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: (size ?? 65) / 3,
                      ));
                },
              );
            } else if (snapshot.hasError) {
              return Tooltip(
                  message: context.loc.imageNotFound,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: (size ?? 65) / 3,
                  ));
            } else {
              return const Loader();
            }
          },
        ),
      ),
    );
  }
}
