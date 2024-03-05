import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BookmarkView extends StatelessWidget {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppBar(title: Text("Bookmarks")),
      ],
    ).animate().fade(duration: const Duration(milliseconds: 500));
  }
}
