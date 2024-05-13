import 'package:flutter/material.dart';

class HorizontalClipper extends CustomClipper<Rect> {
  HorizontalClipper(this.position);

  double position = 0;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, position, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
