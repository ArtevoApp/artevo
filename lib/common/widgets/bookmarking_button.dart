import '../../localization/app_localizations_context.dart';
import '../config/color_schemes.dart';
import '../constants/dimens.dart';
import '../../features/bookmark/bookmark_repository.dart';
import 'package:artevo_package/models/content.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BookmarkingButton extends StatefulWidget {
  const BookmarkingButton(
      {super.key, this.color, required this.content, this.onlyIcon});

  /// Icon color
  final Color? color;

  /// Content Data
  final Content content;

  ///
  final bool? onlyIcon;

  static Widget withBackground(Content content,
      {Color? iconColor, Color? backgroundColor}) {
    return CircleAvatar(
      radius: smallIconSize,
      backgroundColor: backgroundColor ?? darkColorScheme.surface,
      child: BookmarkingButton(
        color: iconColor ?? Colors.white,
        content: content,
      ),
    );
  }

  @override
  State<BookmarkingButton> createState() => _BookmarkingButtonState();
}

class _BookmarkingButtonState extends State<BookmarkingButton> {
  final bookmarkRepository = BookmarkRepository.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: bookmarkRepository.checkStatus(
            widget.content.contentType, widget.content.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final isBookmarked = snapshot.data!;

            final icon = isBookmarked
                ? const Icon(Ionicons.bookmark)
                : const Icon(Ionicons.bookmark_outline);

            if (widget.onlyIcon == false) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: icon,
                title: Text(isBookmarked
                    ? context.loc.removeBookmarks
                    : context.loc.addBookmarks),
                onTap: () => onPressed(isBookmarked),
              );
            }

            return IconButton(
              icon: icon,
              color: widget.color,
              padding: EdgeInsets.zero,
              onPressed: () => onPressed(isBookmarked),
            );
          }
          return const SizedBox.shrink();
        });
  }

  void onPressed(bool isBookmarked) async {
    await bookmarkRepository.update(widget.content, !isBookmarked);

    setState(() {});
  }
}
