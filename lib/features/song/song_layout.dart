import 'package:artevo/features/song/song_providers.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class SongLayout extends StatelessWidget {
  const SongLayout({super.key});

  /// formatter function from [duration] to "mm:ss".
  String secondToMinute(Duration? duration) {
    if (duration != null) {
      return "${(duration.inSeconds / 60).toString().split(".").first}:${(duration.inSeconds % 60).truncate().toString().padLeft(2, '0')}";
    } else {
      return "0:00";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      var player = ref.watch(audioPlayerRepositoryProvider);

      var currentSong = ref.watch(audioPlayerRepositoryProvider).getCurrentSong;

      var albumCover = currentSong.albumImageUrl;

      var songName = "${currentSong.artist} - ${currentSong.name}";

      Duration? position =
          ref.watch(positionStreamProvider).value ?? Duration.zero;
      Duration? buffered =
          ref.watch(bufferedStreamProvider).value ?? Duration.zero;
      var duration = ref.watch(durationStreamProvider);

      if (songName.length > 35) {
        songName = '${songName.substring(0, 32)}...';
      }

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(songName),
                    Row(
                      children: [
                        // * PLAY - PAUSE
                        IconButton(
                          icon: Icon(
                            player.isPlaying && currentSong.url != ''
                                ? Iconsax.pause
                                : Iconsax.play,
                            size: 24,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () =>
                              player.isPlaying && currentSong.url != ''
                                  ? player.pause()
                                  : player.play(),
                        ),

                        // * SLIDER
                        Expanded(
                          child: duration.when(
                            data: (duration) {
                              duration ??= const Duration(seconds: 1);
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // * Şarkı Anlık Süre
                                  SizedBox(
                                    width: 30,
                                    child: Text(
                                      secondToMinute(position),
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ),

                                  // * bar
                                  Expanded(
                                    child: SliderTheme(
                                      data: Theme.of(context)
                                          .sliderTheme
                                          .copyWith(
                                            trackHeight: 2,
                                            activeTrackColor:
                                                const Color(0xff035e4f),
                                            secondaryActiveTrackColor:
                                                Colors.teal,
                                            inactiveTrackColor:
                                                const Color(0xffDCDBDC),
                                            thumbColor: const Color(0xff035e4f),
                                            thumbShape:
                                                const RoundSliderThumbShape(
                                                    enabledThumbRadius: 5,
                                                    disabledThumbRadius: 8),
                                            overlayShape:
                                                const RoundSliderThumbShape(
                                                    enabledThumbRadius: 7,
                                                    disabledThumbRadius: 8),
                                          ),
                                      child: Slider(
                                        value: position.inSeconds /
                                            duration.inSeconds,
                                        secondaryTrackValue:
                                            buffered.inSeconds /
                                                duration.inSeconds,
                                        onChanged: (newSliderValue) async {
                                          player.pause();
                                          await player.seek(Duration(
                                              seconds: (newSliderValue *
                                                      duration!.inSeconds)
                                                  .toInt()));
                                          //player.play();
                                        },
                                        onChangeEnd: (value) => player.play(),
                                      ),
                                    ),
                                  ),

                                  // * duration
                                  SizedBox(
                                    width: 30,
                                    child: Text(
                                      secondToMinute(duration),
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  )
                                ],
                              );
                            },
                            error: (error, stackTrace) {
                              return const SizedBox();
                            },
                            loading: () => const LinearProgressIndicator(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      albumCover,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Tooltip(
                        message: context.loc.imageNotFound,
                        child: const SizedBox(
                          height: 75,
                          width: 75,
                          child: Icon(Icons.image_not_supported_outlined),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ],
      );
    });
  }
}
