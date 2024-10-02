import 'package:artevo_package/models/music_content.dart';

import "../../../common/global_variables/audio_handler.dart";
import "../../../common/extensions/music_content_extension.dart";

final class AudioPlayerHelper {
  static Future<void> playFromQueue(int index) async {
    await audioHandler.skipToQueueItem(index);
    await audioHandler.play();
  }

  static Future<void> addQueueAndPlay(MusicContent music,
      {bool addQueue = true}) async {
    try {
      await audioHandler.addQueueItem(music.toMediaItem());
      await audioHandler.skipToQueueItem(audioHandler.queue.value.length - 1);
      await audioHandler.play();
    } catch (e) {
      print("$e");
    }
  }
}
