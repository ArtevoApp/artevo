import 'package:artevo_package/enums/content_type.dart';
import 'package:artevo_package/extensions/content_type_extension.dart';
import 'package:artevo_package/models/content.dart';

import '../../common/extensions/content_type_extension.dart';
import '../../services/database/local/local_data_service.dart';

class BookmarkRepository {
  BookmarkRepository._();

  static final BookmarkRepository instance = BookmarkRepository._();

  static final _localDB = LocalDataService.instance;

  /// This method gets the bookmarked data from the local database.
  Future<List<Content>> getBookmarks(ContentType type,
      {int? limit, bool? getAll}) async {
    final bookmarks = await _localDB.getBookmarks(type.localDBTableName,
        limit: limit, getAll: getAll);

    return bookmarks.map(type.fromMap).toList();
  }

  /// This method updates the bookmarked status of the content in local database.
  /// If the content is not found in the database, it will be added to the database.
  Future<void> update(Content content, bool isBookmarked) async {
    await _localDB.updateBookmarkStatus(
        content.contentType.localDBTableName, content.toMap(), isBookmarked);
  }

  /// This method checks if the content is bookmarked in the local database.
  Future<bool> checkStatus(ContentType type, String id) async {
    return await _localDB.checkBookMarkedStatus(type.localDBTableName, id);
  }
}
