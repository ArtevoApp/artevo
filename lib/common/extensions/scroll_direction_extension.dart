import 'package:flutter/rendering.dart';

extension ScrollDirectionExtension on ScrollDirection {
  bool get isIdle => this == ScrollDirection.idle;
  bool get isScrollingUp => this == ScrollDirection.forward;
  bool get isScrollingDown => this == ScrollDirection.reverse;
}
