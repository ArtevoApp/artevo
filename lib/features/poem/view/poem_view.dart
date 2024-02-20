import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo_package/models/section.dart';
import 'package:flutter/material.dart';
import 'package:artevo/services/hive/hive_content_data_service.dart';

class PoemView extends StatelessWidget {
  const PoemView({super.key});

  @override
  Widget build(BuildContext context) {
    final poem = HiveContentDataService().getPoemData(context.loc.langCode) ??
        Section(title: "", content: "", author: "");
    return Column(
      children: [
        Text(poem.title, style: TextStyles.title),
        const SizedBox(height: 16),
        SelectableText(poem.content, style: TextStyles.body),
        const SizedBox(height: 16),
        Text(poem.author, style: TextStyles.body),
      ],
    );
  }
}
