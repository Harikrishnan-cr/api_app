import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/gen/assets.gen.dart';

import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/signed_image_viewer.dart';
import 'package:samastha/widgets/custom_audio_video_progress_bar.dart';

class AudioClassItem extends StatefulWidget {
  const AudioClassItem({
    super.key,
    required this.name,
    required this.id,
    required this.url,
    this.description,
    this.duration,
    required this.isPurchased,
    this.isDemo,
    this.buttonColor,
    this.isKids,
  });

  final String name;
  final int id;
  final String url;
  final String? description;
  final String? duration;
  final bool isPurchased;
  final bool? isDemo;
  final bool? isKids;
  final Color? buttonColor;

  @override
  State<AudioClassItem> createState() => _AudioClassItemState();
}

class _AudioClassItemState extends State<AudioClassItem> {
  // final AudioPlayer audioPlayer = di.sl<AudioPlayer>();
  final AudioPlayer audioPlayer = AudioPlayer();
  // late AudioPlayer audioPlayer;
  // bool isCurrentlyPlaying = false;
  String? audioUrl;

  _getUrl() async {
    print('audioUrl $audioUrl');
    audioUrl = await getUrl(widget.url);
    print('audioUrl 2 $audioUrl');
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => setState(() {}));
  }

  @override
  void initState() {
    _getUrl();
    super.initState();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   audioPlayer = AudioPlayer();
  //   audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
  //     setState(() {
  //       isCurrentlyPlaying = state == PlayerState.playing;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print('audioUrl x $audioUrl');
    return GestureDetector(
      onTap: widget.isPurchased
          ? () {
              if (AppConstants.currentPlayingAudioUrl == widget.url) {
                // Play or pause the audio when the item is tapped
                if (audioPlayer.state == PlayerState.playing) {
                  audioPlayer.pause();
                  setState(() {});
                } else {
                  audioPlayer.play(UrlSource(audioUrl!));
                  setState(() {});
                }
                setState(() {});
              } else {
                print('else play');
                AppConstants.currentPlayingAudioUrl = widget.url;
                audioPlayer.play(UrlSource(audioUrl!));
                setState(() {});
              }
            }
          : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: widget.isPurchased
                ? ((widget.isKids ?? false)
                    ? defaultDecoration.copyWith(boxShadow: [])
                    : defaultDecoration)
                : defaultDecoration.copyWith(
                    boxShadow: [],
                    color: const Color.fromRGBO(1, 1, 1, 0.2),
                  ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: !(widget.isKids ?? false),
                  child: Text(
                    widget.name,
                    style: titleSmall.grey1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Gap((widget.isKids ?? false) ? 0 : 8),
                Visibility(
                  visible: !(widget.isDemo ?? false),
                  child: Text(
                    widget.description ?? '',
                    style: bodyMedium.darkBG,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(8),
                Row(
                  children: [
                    StreamBuilder<PlayerState>(
                        stream: audioPlayer.onPlayerStateChanged,
                        builder: (context, snapshot) {
                          return Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.buttonColor ??
                                    ColorResources.primary),
                            child: snapshot.data == null
                                ? const Icon(
                                    Icons.play_arrow,
                                    color: ColorResources.WHITE,
                                  )
                                : snapshot.data == PlayerState.completed
                                    ? const Icon(
                                        Icons.play_arrow,
                                        color: ColorResources.WHITE,
                                      )
                                    : Icon(
                                        AppConstants.currentPlayingAudioUrl ==
                                                    widget.url &&
                                                (snapshot.data ==
                                                    PlayerState.paused)
                                            ? Icons.play_arrow
                                            : Icons.pause,
                                        color: ColorResources.WHITE,
                                        size: 16,
                                      ),
                          );
                        }),
                    const Gap(15),
                    StreamBuilder<Duration>(
                        stream: audioPlayer.onPositionChanged,
                        builder: (context, onPositionChanged) {
                          return StreamBuilder<Duration>(
                              stream: audioPlayer.onDurationChanged,
                              builder: (context, onDurationChanged) {
                                return Expanded(
                                  child: ProgressBar(
                                    thumbColor: ColorResources.primary,
                                    baseBarColor: const Color(0xffEBEBEB),
                                    progress: onPositionChanged.data ??
                                        const Duration(milliseconds: 0000),
                                    buffered:
                                        const Duration(milliseconds: 0000),
                                    total: onDurationChanged.data ??
                                        const Duration(milliseconds: 5000),
                                    timeLabelLocation: TimeLabelLocation.none,
                                    onSeek: (duration) {
                                      audioPlayer.seek(duration);
                                    },
                                  ),
                                );
                              });
                        }),
                    const Gap(7),
                    Text(
                      widget.duration ?? '',
                      style: labelMedium.secondary,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!widget.isPurchased)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icon.courseLock.image(color: Colors.white, height: 36)
              ],
            )
        ],
      ),
    );
  }

  // _iconData(PlayerState? data) {
  // snapshot.data == PlayerState.completed
  //                         ? const Icon(
  //                             Icons.play_arrow,
  //                             color: ColorResources.WHITE,
  //                           )
  //                         : Icon(
  //                             AppConstants.currentPlayingAudioUrl ==
  //                                         widget.url &&
  //                                     (snapshot.data == PlayerState.paused)
  //                                 ? Icons.play_arrow
  //                                 : Icons.pause,
  //                             color: ColorResources.WHITE,
  //                             size: 16,
  //                           ),
  // switch (data) {
  //   case PlayerState.paused:
  //   return const Icon(Icons.pause);
  //   default:
  // }
  // }
}
