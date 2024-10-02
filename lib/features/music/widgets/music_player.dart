import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rxdart/rxdart.dart';

import "../../../common/helpers/functions.dart";
import '../../../common/constants/dimens.dart';
import '../../../common/constants/text_styles.dart';
import '../../../common/extensions/media_item_extension.dart';
import '../../../common/global_variables/audio_handler.dart';
import '../../../common/widgets/bookmarking_button.dart';
import '../../../common/widgets/image_viewer.dart';
import '../../../common/widgets/loader.dart';
import '../../../core/localization/app_localizations_context.dart';

import '../controllers/music_player_controllers.dart';
import '../models/position_data.dart';
import '../models/queue_state.dart';
import '../service/audio_player_helper.dart';
import 'music_card.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});

  static final MusicPlayerController _playerController =
      MusicPlayerController.instance;

  @override
  Widget build(BuildContext context) {
    _playerController.init();

    return StreamBuilder<MediaItem?>(
        stream: audioHandler.mediaItem,
        builder: (context, snapshot) {
          return ListenableBuilder(
            listenable: MusicPlayerController.instance,
            builder: (context, child) {
              final mediaItem = snapshot.data;
              final isShowMusicPlayer = _playerController.isShowMusicPlayer;

              if (mediaItem == null || !isShowMusicPlayer) {
                return const SizedBox.shrink();
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  musicDurationProgressIndicator(),
                  miniMusicPlayer(mediaItem, context),
                ],
              );
            },
          );
        });
  }

  Widget miniMusicPlayer(MediaItem mediaItem, BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      child: ListTile(
        dense: true,
        leading: ImageViewer(url: mediaItem.artUri.toString()),
        title: Text(Functions.stringShorter(mediaItem.title)),
        subtitle: Text(Functions.stringShorter(mediaItem.artist!)),
        trailing: playPauseButton(size: largeIconSize),
        onTap: () => showModalBottomSheet(
          context: context,
          useSafeArea: true,
          showDragHandle: true,
          isScrollControlled: true,
          builder: (context) => fullSizeMusicPlayer(),
        ),
      ),
      background: Container(
        color: Theme.of(context).colorScheme.tertiary.withOpacity(.5),
        padding: const EdgeInsets.all(smallPadding),
        child: ListTile(
          contentPadding: const EdgeInsets.all(smallPadding),
          leading: const Icon(Ionicons.stop_circle_outline),
          title: Text(context.loc.closePlayer),
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          audioHandler.stop();
          _playerController.hideMusicPlayer();
        }
        return;
      },
    );
  }

  Stream<Duration> get _bufferedPositionStream => audioHandler.playbackState
      .map((state) => state.bufferedPosition)
      .distinct();

  Stream<Duration?> get _durationStream =>
      audioHandler.mediaItem.map((item) => item?.duration).distinct();

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          AudioService.position,
          _bufferedPositionStream,
          _durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  Widget musicDurationProgressIndicator() => StreamBuilder<PositionData>(
        stream: _positionDataStream,
        builder: (context, snapshot) {
          final durationState = snapshot.data;

          if (durationState == null) return const SizedBox.shrink();

          final progress = durationState.position;
          final total = durationState.duration;

          return ClipRRect(
            borderRadius: BorderRadius.circular(defaultPadding),
            child: LinearProgressIndicator(
              minHeight: 1,
              value: progress.inSeconds / total.inSeconds,
            ),
          );
        },
      );

  Widget playPauseButton({double? size}) {
    return StreamBuilder<PlaybackState>(
      stream: audioHandler.playbackState,
      builder: (context, snapshot) {
        final playbackState = snapshot.data;
        final processingState = playbackState?.processingState;
        final playing = playbackState?.playing ?? false;

        if (processingState == AudioProcessingState.loading ||
            processingState == AudioProcessingState.buffering) {
          return SizedBox(
            height: size ?? hugeIconSize,
            width: size ?? hugeIconSize,
            child: const Loader(),
          );
        }

        return IconButton(
          onPressed: playing ? audioHandler.pause : audioHandler.play,
          iconSize: size ?? hugeIconSize,
          icon: Icon(playing ? Iconsax.pause : Iconsax.play),
        );
      },
    );
  }

  Widget fullSizeMusicPlayer() {
    return StreamBuilder<MediaItem?>(
      stream: audioHandler.mediaItem,
      builder: (context, snapshot) {
        final mediaItem = snapshot.data;

        if (mediaItem == null) return const SizedBox.shrink();

        return Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IconButton(onPressed: null, icon: Icon(null)),
              ImageViewer(
                  url: mediaItem.artUri.toString(), height: 140, width: 140),
              BookmarkingButton(content: mediaItem.toMusicContent()),
            ],
          ),
          const SizedBox(height: largePadding),
          Text(
            mediaItem.title,
            style: TextStyles.title,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: largePadding),
          Text(mediaItem.artist!),
          musicPositionProgressBar(),
          const SizedBox(height: largePadding),
          controlButtons(),
          const SizedBox(height: hugePadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Row(
              children: [
                Expanded(
                    child: Text(context.loc.playlist, style: TextStyles.title)),
                StreamBuilder<bool>(
                  stream: audioHandler.playbackState
                      .map((state) =>
                          state.shuffleMode == AudioServiceShuffleMode.all)
                      .distinct(),
                  builder: (context, snapshot) {
                    final shuffleModeEnabled = snapshot.data ?? false;
                    final activeColor = Theme.of(context).colorScheme.primary;

                    return IconButton(
                      icon: shuffleModeEnabled
                          ? Icon(Iconsax.shuffle, color: activeColor)
                          : const Icon(Iconsax.shuffle, color: Colors.grey),
                      onPressed: () async {
                        final enable = !shuffleModeEnabled;
                        await audioHandler.setShuffleMode(enable
                            ? AudioServiceShuffleMode.all
                            : AudioServiceShuffleMode.none);
                      },
                    );
                  },
                ),
                StreamBuilder<AudioServiceRepeatMode>(
                  stream: audioHandler.playbackState
                      .map((state) => state.repeatMode)
                      .distinct(),
                  builder: (context, snapshot) {
                    final repeatMode =
                        snapshot.data ?? AudioServiceRepeatMode.none;
                    final activeColor = Theme.of(context).colorScheme.primary;
                    final icons = [
                      const Icon(Iconsax.repeat, color: Colors.grey),
                      Icon(Iconsax.repeat, color: activeColor),
                      Icon(Iconsax.repeate_one, color: activeColor),
                    ];
                    const cycleModes = [
                      AudioServiceRepeatMode.none,
                      AudioServiceRepeatMode.all,
                      AudioServiceRepeatMode.one,
                    ];
                    final index = cycleModes.indexOf(repeatMode);
                    return IconButton(
                      icon: icons[index],
                      onPressed: () {
                        audioHandler.setRepeatMode(cycleModes[
                            (cycleModes.indexOf(repeatMode) + 1) %
                                cycleModes.length]);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(indent: defaultPadding, endIndent: defaultPadding),
          queueList(),
        ]);
      },
    );
  }

  Widget musicPositionProgressBar() => Padding(
        padding: const EdgeInsets.all(largePadding),
        child: StreamBuilder<PositionData>(
          stream: _positionDataStream,
          builder: (context, snapshot) {
            final durationState = snapshot.data;
            final bufferColor = Theme.of(context).colorScheme.surface;
            return ProgressBar(
              progress: durationState?.position ?? Duration.zero,
              buffered: durationState?.bufferedPosition,
              total: durationState?.duration ?? Duration.zero,
              onSeek: audioHandler.seek,
              barHeight: smallPadding,
              progressBarColor: bufferColor,
              bufferedBarColor: bufferColor.withOpacity(.6),
              thumbColor: bufferColor,
              baseBarColor: bufferColor.withOpacity(.3),
              thumbRadius: defaultPadding,
              thumbGlowRadius: smallIconSize,
              timeLabelLocation: TimeLabelLocation.sides,
              // timeLabelTextStyle:
              //     TextStyles.bodyv2.copyWith(color: bufferColor),
            );
          },
        ),
      );

  Widget controlButtons() => Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: xLargePadding,
        children: [
          StreamBuilder<QueueState>(
            stream: audioHandler.queueState,
            builder: (context, snapshot) {
              final queueState = snapshot.data ?? QueueState.empty;
              return IconButton(
                iconSize: xLargeIconSize,
                icon: const Icon(Iconsax.previous),
                onPressed:
                    queueState.hasPrevious ? audioHandler.skipToPrevious : null,
              );
            },
          ),
          playPauseButton(),
          StreamBuilder<QueueState>(
            stream: audioHandler.queueState,
            builder: (context, snapshot) {
              final queueState = snapshot.data ?? QueueState.empty;
              return IconButton(
                iconSize: xLargeIconSize,
                icon: const Icon(Iconsax.next),
                onPressed: queueState.hasNext ? audioHandler.skipToNext : null,
              );
            },
          ),
        ],
      );

  StreamBuilder<QueueState> queueList() => StreamBuilder<QueueState>(
        stream: audioHandler.queueState,
        builder: (context, snapshot) {
          final queueState = snapshot.data ?? QueueState.empty;
          final queue = queueState.queue;

          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: queue.length,
              controller: ScrollController(initialScrollOffset: 500),
              itemBuilder: (context, index) => MusicCard(
                music: queue[index].toMusicContent(),
                isSelected: audioHandler.mediaItem.value?.id == queue[index].id,
                onTap: () => AudioPlayerHelper.playFromQueue(index),
              ),
            ),
          );
        },
      );
}
