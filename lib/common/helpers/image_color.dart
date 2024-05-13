// import 'dart:io';
// import 'package:flutter/painting.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:palette_generator/palette_generator.dart';

// import '../../services/cache/temp_image_cache_manager.dart';

// abstract class ImageColor {
//   static Future<List<Color?>> getScheme(String url) async {
//     final List<Color?> resultList = [null, null];

//     try {
//       final imageResponse = await TempImageCacheManager.instance
//           .getFileStream(url, withProgress: true)
//           .first;

//       final image = FileImage(File((imageResponse as FileInfo).file.path));

//       final colorSch =
//           await PaletteGenerator.fromImageProvider(image, maximumColorCount: 5);

//       resultList[0] = colorSch.dominantColor?.color; // baclgrond

//       resultList[1] = colorSch.mutedColor?.color ??
//           colorSch.lightMutedColor?.color ??
//           colorSch.darkMutedColor?.color;

//       // resultList[2] = colorSch.vibrantColor?.color ??
//       //     colorSch.lightVibrantColor?.color ??
//       //     colorSch.darkVibrantColor?.color;

//       return resultList;
//     } catch (e) {
//       return resultList;
//     }
//   }
// }
