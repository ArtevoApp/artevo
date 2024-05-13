import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NavBarController extends ChangeNotifier {
  NavBarController._();

  static final NavBarController instance = NavBarController._();

  bool _showNavBar = true;

  bool get isShowNavBar => _showNavBar;

  final homeScrollController = ScrollController();
  final discoverScrollController = ScrollController();

  void init() {
    homeScrollController.addListener(
        () => update(homeScrollController.position.userScrollDirection));

    discoverScrollController.addListener(
        () => update(discoverScrollController.position.userScrollDirection));
  }

  void hideNavBar() {
    _showNavBar = false;
    notifyListeners();
  }

  void showNavBar() {
    _showNavBar = true;
    notifyListeners();
  }

  void update(ScrollDirection direction) {
    if (direction == ScrollDirection.reverse) {
      hideNavBar();
    } else {
      showNavBar();
    }
  }
}
