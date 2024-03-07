import 'package:artevo/features/bookmark/models/saved_content.dart';
import 'package:artevo/services/hive/hive_saved_content_service.dart';
import 'package:artevo_package/models/content.dart';

class BookmarkRepository {
  final hive = HiveSavedContentService.instance;

  Future setContentData(Content content) async {
    String time = DateTime.now().microsecondsSinceEpoch.toString();

    final savedContent = SavedContent(content: content, time: time);

    hive.setContent(time, savedContent.toMap());
  }

  Future getAllContentData(int page) async {
    final data = await hive.getContents(page);
    if (data == null) return [];
    return data.map((e) => SavedContent.fromMap(e)).toList();
  }

  Future removeContentData(String time) async {
    hive.removeContent(time);
  }
}
