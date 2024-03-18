import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo_package/models/content.dart';
import 'package:flutter/material.dart';

class BookmarkingButton extends StatelessWidget {
  const BookmarkingButton(
      {super.key, this.size, this.iconSize, this.color, required this.content});

  /// Widget size (Hover size)
  final double? size;

  /// Icon size
  final double? iconSize;

  /// Icon color
  final Color? color;

  /// Content
  final Content content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? defaultIconSize,
      height: size ?? defaultIconSize,
      child: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.bookmark_border_rounded),
        padding: EdgeInsets.all(0),
        iconSize: iconSize ?? smallIconSize,
        color: color,
      ),
    );
  }
}
