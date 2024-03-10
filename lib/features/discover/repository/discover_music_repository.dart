import 'package:artevo_package/enums/content_type.dart';
import 'package:artevo_package/models/music_content.dart';
import 'package:artevo_package/services/music_service.dart';

class DiscoverMusicRepository {
  DiscoverMusicRepository._();

  static Future<List<MusicContent>?> search(String searchText) async {
    try {
      List<MusicContent> results = [];

      final items = await MusicService.search(searchText);

      if (items == null) return null;

      results.addAll(items.map((e) {
        final parser = _titleParser(e['name'].toString());

        return MusicContent(
            contentType: ContentType.musicContent,
            langCode: "en",
            title: parser[1],
            creator: parser[0],
            editorUid: "0",
            editorNickname: "Artevo Music Editor",
            musicSourceUrl: e['songUrl'],
            albumImageUrl: e['imageUrl']);
      }));

      return results;
    } catch (e) {
      return null;
    }
  }

  /// return [creator] and [title]
  static List<String> _titleParser(String title) {
    List<String> result = ["", ""];

    List<String> parts = title.split('-').map((e) => e.trim()).toList();

    if (parts.length > 1) {
      result = parts.sublist(0, 2);
      return result;
    }

    parts = title.toLowerCase().split('by').map((e) => e.trim()).toList();

    if (parts.length > 1) {
      result = parts.sublist(0, 2).reversed.toList();
      return result;
    }

    // ... add more parsers

    result[1] = title;

    return result;
  }
}
