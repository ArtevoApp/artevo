import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/features/search/enum/search_status.dart';
import 'package:artevo/features/search/search_controllers.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

// this provider is here because it's only used for align suffixIcon in search bar.
final _onTapProvider = StateProvider.autoDispose<bool>((ref) => false);

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext _) {
    double screenWidth = MediaQuery.of(_).size.width;

    return SizedBox(
      width: (screenWidth > columnWidth ? columnWidth : screenWidth) - 32,
      height: smallImageSize,
      child: Consumer(builder: (_, ref, ch) {
        return TextField(
          autofocus: false,
          controller: controller,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          inputFormatters: [LengthLimitingTextInputFormatter(350)],
          textAlignVertical: TextAlignVertical.center,
          decoration: inputDecoration(_, ref),
          onChanged: (p0) async => onChanged(p0, ref),
          onTap: () => ref.read(_onTapProvider.notifier).state = true,
        );
      }),
    );
  }

  InputDecoration inputDecoration(BuildContext _, WidgetRef ref) {
    final hintColor = Theme.of(_).colorScheme.secondary;
    final backgroundColor = Theme.of(_).scaffoldBackgroundColor.withOpacity(.6);
    return InputDecoration(
      filled: true,
      fillColor: backgroundColor,
      hintText: _.loc.search,
      hintStyle: TextStyle(color: hintColor),
      prefixIcon: Icon(Iconsax.search_normal, color: hintColor),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(mediumPadding)),
      suffixIcon:
          ref.watch(_onTapProvider) ? clearButton(ref) : SizedBox.shrink(),
    );
  }

  Widget clearButton(WidgetRef ref) {
    return IconButton(
        icon: Icon(Icons.clear_rounded),
        onPressed: () async {
          controller.clear();
          ref.read(searchTextProvider.notifier).state = "";
          ref.read(searchStatusProvider.notifier).state = SearchStatus.clear;
          await Future.delayed(const Duration(milliseconds: 800));
          ref.read(searchStatusProvider.notifier).state = SearchStatus.idle;
        });
  }

  Future<void> onChanged(String value, WidgetRef ref) async {
    if (value.isEmpty) {
      ref.read(searchStatusProvider.notifier).state = SearchStatus.clear;
      await Future.delayed(const Duration(milliseconds: 500));
      ref.read(searchStatusProvider.notifier).state = SearchStatus.idle;
    } else if (value.length < 3) {
      ref.read(searchStatusProvider.notifier).state = SearchStatus.idle;
    } else {
      await Future.delayed(const Duration(milliseconds: 500));
      ref.read(searchTextProvider.notifier).state = value;

      ref.read(searchStatusProvider.notifier).state = SearchStatus.search;
    }
  }
}
