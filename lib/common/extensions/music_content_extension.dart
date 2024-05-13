import 'package:artevo_package/models/music_content.dart';
import 'package:audio_service/audio_service.dart';

extension MusicContentExtension on MusicContent {
  MediaItem toMediaItem() => MediaItem(
        id: songID,
        title: title,
        artist: creator,
        duration: Duration(seconds: duration),
        artUri: Uri.parse(thumbnailUrl),
      );
}
