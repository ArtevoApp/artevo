import '../constants/dimens.dart';
import '../constants/paths.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: largePadding),
      child: Image.asset(
        dividerPath,
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        width: xxLargeImageSize,
      ),
    );
  }
}
