import 'package:artevo/common/widgets/error_dialog.dart';
import 'package:artevo/features/bookmark/models/saved_content.dart';
import 'package:artevo/global_veriables.dart';
import 'package:artevo/services/hive/hive_saved_content_service.dart';
import 'package:artevo_package/models/content.dart';

class BookmarkRepository {
  final hive = HiveSavedContentService.instance;

  Future<void> setContentData(Content content) async {
    String time = DateTime.now().microsecondsSinceEpoch.toString();

    final savedContent = SavedContent(content: content, time: time);

    final result = await hive.setContent(time, savedContent.toMap());

    if (!result) ErrorDialog.show(navigatorKey.currentState!.context);
  }

  Future<List<SavedContent>> getAllContentData(int page) async {
    final data = await hive.getContents(page);

    if (data == null) {
      ErrorDialog.show(navigatorKey.currentState!.context);
      return [];
    }

    return data.map((e) => SavedContent.fromMap(e)).toList();
  }

  Future removeContentData(String time) async {
    final result = await hive.removeContent(time);

    if (!result) ErrorDialog.show(navigatorKey.currentState!.context);
  }
}
