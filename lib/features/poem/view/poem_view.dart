import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:artevo/services/hive/hive_daily_content_data_service.dart';

class PoemView extends StatelessWidget {
  const PoemView({super.key});

  @override
  Widget build(BuildContext context) {
    final poetry = HiveDailyContentDataService.instance
        .getPoetryContentData(context.loc.langCode);

    if (poetry == null) return const SizedBox.shrink();

    return Column(
      children: [
        Text(poetry.title,
            style: TextStyles.title, textAlign: TextAlign.center),
        const SizedBox(height: 16),
        SelectableText(poetry.poem, style: TextStyles.body),
        const SizedBox(height: 16),
        Text(poetry.creator, style: TextStyles.body),
      ],
    );
  }
}
