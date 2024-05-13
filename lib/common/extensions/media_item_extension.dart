import 'package:artevo_package/enums/content_type.dart';
import 'package:artevo_package/models/music_content.dart';
import 'package:audio_service/audio_service.dart';

extension MusicItemExtension on MediaItem {
  MusicContent toMusicContent() => MusicContent(
        id: id,
        contentType: ContentType.musicContent,
        editorUid: "ame",
        editorNickname: "Artevo Music Editor",
        langCode: 'en',
        songID: id,
        title: title,
        creator: artist!,
        duration: duration!.inSeconds,
        thumbnailUrl: artUri.toString(),
      );
}
