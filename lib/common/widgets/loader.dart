import '../constants/dimens.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: xsmallIconSize,
        width: xsmallIconSize,
        child: CircularProgressIndicator(color: Color(0xFFB1CCC3)));
  }
}
