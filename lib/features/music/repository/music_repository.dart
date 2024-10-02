import 'package:artevo_package/models/music_content.dart';
import 'package:artevo_package/services/music_service/music_service.dart';

import '../../../services/cache/lazy_user_data_manager.dart';

final class MusicRepository {
  MusicRepository._();

  static MusicRepository? _instance;

  static MusicRepository get instance {
    _instance ??= MusicRepository._();
    return _instance!;
  }

  Future<List<MusicContent>> search(String query) async {
    try {
      LazyUserDataManager.instance.addLastSearchedMusic(query.trim());
      return await MusicService.search(query.trim()) ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<List<String>> getLastSearchedMusics() async {
    return await LazyUserDataManager.instance.getLastSearchedMusics();
  }
}
