import 'package:flutter/rendering.dart';

extension ScrollDirectionExtension on ScrollDirection {
  bool get isScrollingUp => this == ScrollDirection.forward;
  bool get isScrollingDown => this == ScrollDirection.reverse;
  bool get isIdele => this == ScrollDirection.idle;

  bool get isScrolling => isScrollingUp || isScrollingDown;
  bool get isScrollingUpOrDown => isScrollingUp || isScrollingDown;
}
