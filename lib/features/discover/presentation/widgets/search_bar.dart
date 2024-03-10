import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/features/discover/controllers/search_controller.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class SearchBarWidget extends ConsumerWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    double screenWidth = MediaQuery.of(context).size.width;

    Color backgroundColor =
        Theme.of(context).scaffoldBackgroundColor.withOpacity(.6);

    Color hintColor = Theme.of(context).colorScheme.secondary;

    return SizedBox(
      width: (screenWidth > columnWidth ? columnWidth : screenWidth) - 32,
      child: TextFormField(
        autofocus: false,
        autocorrect: true,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        inputFormatters: [LengthLimitingTextInputFormatter(350)],
        decoration: InputDecoration(
          filled: true,
          fillColor: backgroundColor,
          hintText: context.loc.search,
          hintStyle: TextStyle(color: hintColor),
          prefixIcon: Icon(Iconsax.search_normal, color: hintColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(mediumPadding),
          ),
        ),
        onFieldSubmitted: (value) {
          if (value.length > 3)
            ref.read(searchTextProvider.notifier).state = value;
        },
      ),
    );
  }
}
