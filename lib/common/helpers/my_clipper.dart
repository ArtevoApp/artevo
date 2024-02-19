import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Rect> {
  double position = 0;

  MyClipper(this.position);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, position, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
