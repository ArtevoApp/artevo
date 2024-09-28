import 'package:artevo_package/models/poetry_content.dart';
import 'package:flutter/material.dart';
import '../../common/constants/dimens.dart';
import '../../common/constants/text_styles.dart';
import 'screens/poem_detail_screen.dart';

class PoemCard extends StatelessWidget {
  const PoemCard({super.key, required this.poem});

  final PoetryContent poem;

  @override
  Widget build(BuildContext context) {
    final poemLines = poem.poem.split("\n");

    return Card(
      elevation: .5,
      child: InkWell(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => PoemDetailScreen(poetry: poem))),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Text(poem.title,
                  textAlign: TextAlign.center, style: TextStyles.title),
              Text(
                poemLines.length > 4
                    ? "${poemLines.sublist(0, 4).join("\n")}\n..."
                    : poem.poem,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  poem.creator,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
