import 'package:artevo/common/constants/dimens.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
          height: largePadding,
          width: largePadding,
          child: CircularProgressIndicator(color: Color(0xFFB1CCC3))),
    );
  }
}
