import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/common/widgets/add_bookmark_button.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/cupertino.dart';
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
        title(poetry.title),
        const SizedBox(height: largePadding),
        SelectableText(poetry.poem, style: TextStyles.body),
        const SizedBox(height: largePadding),
        Text(poetry.creator, style: TextStyles.body),
      ],
    );
  }

  Row title(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: defaultIconSize),
        Expanded(
            child: Text(title,
                style: TextStyles.title, textAlign: TextAlign.center)),
        AddBookmarkButton()
      ],
    );
  }
}
