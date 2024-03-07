import 'package:artevo_package/enums/content_type.dart';
import 'package:artevo_package/extensions/content_type_extension.dart';
import 'package:artevo_package/models/content.dart';

class SavedContent {
  SavedContent({required this.content, required this.time});
  Content content;
  String time;

  Map<String, dynamic> toMap() => {
        "time": time,
        "content": content.toMap(),
      };

  factory SavedContent.fromMap(Map<dynamic, dynamic> map) {
    return SavedContent(
      time: map["time"],
      content: ContentType.values
          .byName(map['content']['contentType'])
          .fromMap((map['content'] as Map).cast<String, dynamic>()),
    );
  }
}
