import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../common/extensions/scroll_direction_extension.dart';

final class MainLayoutController {
  MainLayoutController._();
  static final instance = MainLayoutController._();

  /// Index of the displayed child.
  final currentIndex = ValueNotifier<int>(0);

  /// Updates the index of the displayed child.
  void updateCurrentIndex(int index) => currentIndex.value = index;

  /// Controls the visibility of the navigation bar.
  /// If true, the navigation bar will be shown. Otherwise, it will be hidden.
  final navBarController = ValueNotifier<bool>(true);

  /// Updates the visibility of the navigation bar based on the [scrollDirection].
  /// ```scrollController.addListener(() => MainLayoutController.instance
  ///      .autoUpdateNavBarView(scrollController.position.userScrollDirection));```
  void autoUpdateNavBarView(ScrollDirection scrollDirection) {
    if (scrollDirection.isScrollingDown) {
      hideNavBar;
    } else if (scrollDirection.isScrollingUp) {
      showNavBar;
    }
  }

  /// Toggles the visibility false of the [navBarController].
  bool get hideNavBar => navBarController.value = false;

  /// Toggles the visibility true of the [navBarController].
  bool get showNavBar => navBarController.value = true;
}
