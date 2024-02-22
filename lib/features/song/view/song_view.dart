import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/helpers/functions.dart';
import 'package:artevo/features/song/repository/audio_player_repository.dart';
import 'package:artevo/features/song/controllers/song_controllers.dart';
import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo/features/song/view/widgets/song_detail_dialog.dart';
import 'package:artevo_package/modev2/music_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class SongView extends StatelessWidget {
  const SongView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      AudioPlayerRepository player = ref.watch(audioPlayerRepositoryProvider);

      MusicContent currentSong =
          ref.watch(audioPlayerRepositoryProvider).getCurrentSong;

      String songName = "${currentSong.creator} - ${currentSong.title}";

      Duration? position =
          ref.watch(positionStreamProvider).value ?? Duration.zero;

      Duration? buffered =
          ref.watch(bufferedStreamProvider).value ?? Duration.zero;

      AsyncValue<Duration?> duration = ref.watch(durationStreamProvider);

      if (songName.length > 35) songName = '${songName.substring(0, 32)}...';

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(songName),
                Row(
                  children: [
                    playPauseButton(player, currentSong, context),
                    sliderWidget(duration, position, context, buffered, player)
                  ],
                ),
              ],
            ),
          ),
          albulCoverWidget(context, currentSong),
        ],
      );
    });
  }

  IconButton playPauseButton(AudioPlayerRepository player,
      MusicContent currentSong, BuildContext context) {
    return IconButton(
      icon: Icon(
        player.isPlaying && currentSong.musicSourceUrl != ''
            ? Iconsax.pause
            : Iconsax.play,
        size: 24,
        color: Theme.of(context).colorScheme.primary,
      ),
      onPressed: () => player.isPlaying && currentSong.musicSourceUrl != ''
          ? player.pause()
          : player.play(),
    );
  }

  Expanded sliderWidget(AsyncValue<Duration?> duration, Duration position,
      BuildContext context, Duration buffered, AudioPlayerRepository player) {
    return Expanded(
      child: duration.when(
        data: (duration) {
          duration ??= const Duration(seconds: 1);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // * instant duration
              durationWidget(position),

              // * bar
              songSlider(context, position, duration, buffered, player),

              // * total duration
              durationWidget(duration)
            ],
          );
        },
        error: (error, stackTrace) {
          return const SizedBox();
        },
        loading: () => const LinearProgressIndicator(),
      ),
    );
  }

  Expanded songSlider(BuildContext context, Duration position,
      Duration duration, Duration buffered, AudioPlayerRepository player) {
    return Expanded(
      child: SliderTheme(
        data: const SliderThemeData(
          trackHeight: 2,
          activeTrackColor: Color(0xff035e4f),
          secondaryActiveTrackColor: Colors.teal,
          inactiveTrackColor: Color(0xffDCDBDC),
          thumbColor: Color(0xff035e4f),
          thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 5, disabledThumbRadius: 8),
          overlayShape: RoundSliderThumbShape(
              enabledThumbRadius: 7, disabledThumbRadius: 8),
        ),
        child: Slider(
          value: position.inSeconds / duration.inSeconds,
          secondaryTrackValue: buffered.inSeconds / duration.inSeconds,
          onChanged: (newSliderValue) async {
            player.pause();
            await player.seek(Duration(
                seconds: (newSliderValue * duration.inSeconds).toInt()));
          },
          onChangeEnd: (value) => player.play(),
        ),
      ),
    );
  }

  SizedBox durationWidget(Duration duration) {
    return SizedBox(
      width: 30,
      child: Text(Functions.secondToMinute(duration),
          style: const TextStyle(color: Colors.grey, fontSize: 12)),
    );
  }

  Padding albulCoverWidget(_, MusicContent currentsong) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: InkWell(
          onTap: currentsong.albumImageUrl.isEmpty
              ? null
              : () => SongDetailDialog.show(_, currentsong),
          child: ImageViewer(
              url: currentsong.albumImageUrl,
              height: smallImageSize,
              width: smallImageSize)),
    );
  }
}
