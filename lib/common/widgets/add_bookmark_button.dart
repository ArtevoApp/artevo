import 'package:artevo/common/constants/dimens.dart';
import 'package:flutter/material.dart';

class AddBookmarkButton extends StatelessWidget {
  const AddBookmarkButton({super.key, this.size, this.iconSize, this.color});

  /// Widget size (Hover size)
  final double? size;

  /// Icon size
  final double? iconSize;

  /// Icon color
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? defaultIconSize,
      height: size ?? defaultIconSize,
      child: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.bookmark_outline_rounded),
        padding: EdgeInsets.all(0),
        iconSize: iconSize ?? smallIconSize,
        color: color,
      ),
    );
  }
}
