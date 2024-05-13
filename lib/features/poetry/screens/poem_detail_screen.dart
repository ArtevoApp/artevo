import 'package:artevo_package/models/poetry_content.dart';
import 'package:flutter/material.dart';
import '../../../common/constants/dimens.dart';
import '../../../common/constants/text_styles.dart';
import '../../../common/widgets/bookmarking_button.dart';

class PoemDetailScreen extends StatelessWidget {
  const PoemDetailScreen({super.key, required this.poetry});

  final PoetryContent poetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(poetry.title),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: defaultPadding),
                child: BookmarkingButton(content: poetry))
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(hugePadding),
          children: [
            Text(poetry.poem, style: TextStyles.body),
            const SizedBox(height: hugePadding),
            Center(child: Text(poetry.creator, style: TextStyles.body)),
          ],
        ));
  }
}
