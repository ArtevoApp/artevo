import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class TempImageCacheManager {
  static const key = 'tempImages';

  static CacheManager instance = CacheManager(
    Config(key,
        stalePeriod: const Duration(days: 7),
        maxNrOfCacheObjects: 50,
        repo: JsonCacheInfoRepository(databaseName: key),
        fileService: HttpFileService()),
  );
}
