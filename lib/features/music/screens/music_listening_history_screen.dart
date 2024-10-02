import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/constants/text_styles.dart';
import '../../../core/localization/app_localizations_context.dart';
import '../repository/listening_history_reposiory.dart';
import '../widgets/music_card.dart';

class MusicHistoryScreen extends StatefulWidget {
  const MusicHistoryScreen({super.key});

  @override
  State<MusicHistoryScreen> createState() => _MusicHistoryScreenState();
}

class _MusicHistoryScreenState extends State<MusicHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.listeningHistory, style: TextStyles.title),
        surfaceTintColor: Colors.transparent,
        actions: [
          PopupMenuButton(
            icon: const Icon(Iconsax.more_2),
            position: PopupMenuPosition.under,
            color: Theme.of(context).colorScheme.tertiary,
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () async {
                  await ListeningHistoryReposiory.instance.clearHistory();
                  Navigator.pop(context);
                },
                child: Text(context.loc.clearAll),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async => setState(() {}),
        child: ListenableBuilder(
          listenable: ListeningHistoryReposiory.instance,
          builder: (context, child) {
            final repo = ListeningHistoryReposiory.instance;

            return ListView.builder(
              itemCount: repo.listeningHistory.length,
              itemBuilder: (context, index) =>
                  MusicCard(music: repo.listeningHistory[index]),
            );
          },
        ),
      ),
    );
  }
}
