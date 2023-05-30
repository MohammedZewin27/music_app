import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:new_music/generated/assets.dart';

import '../../provider/providerDatabase.dart';
import '../../style/colors.dart';

class Play_Screen extends StatefulWidget {
  final String path;
  final String title;
  final String image;

  const Play_Screen({super.key, required this.path, required this.title,required this.image});

  @override
  State<Play_Screen> createState() => _Play_ScreenState();
}

class _Play_ScreenState extends State<Play_Screen> {
  late AudioPlayer player;
  bool isPlay = false;
  Duration currentPostion = Duration();
  Duration musicLength = Duration();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player = AudioPlayer();
    setUp();
  }

  setUp() {
    player.onPositionChanged.listen((event) async {
      setState(() {
        setState(() {});
        currentPostion = event;
        print('currentPostion =====>$currentPostion');
      });
      player.onDurationChanged.listen((Duration event) {
        setState(() {
          setState(() {});
          musicLength = event;
          print('musicLength =====> $musicLength');
        });
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
                image: DecorationImage(image: NetworkImage(widget.image),
                fit: BoxFit.fill,
              ),
              border: Border.all(color: LABLECOLOR, width: 5),
            ),
            width: MediaQuery.of(context).size.width * 0.50,
            height: MediaQuery.of(context).size.width * 0.50,
          ),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ProgressBar(
                  progress: currentPostion,
                  buffered: const Duration(seconds: 40),
                  total: musicLength,
                  progressBarColor: Colors.red,
                  baseBarColor: Colors.white.withOpacity(0.24),
                  bufferedBarColor: Colors.white.withOpacity(0.24),
                  thumbColor: Colors.white,
                  barHeight: 3.0,
                  thumbRadius: 5.0,
                  onDragEnd: () {
                    isPlay = false;
                  },
                  timeLabelTextStyle: const TextStyle(fontSize: 15),
                  onSeek: (duration) {
                    player.seek(duration);
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  if (currentPostion < const Duration(seconds: 10)) {
                    seekTo(currentPostion.inSeconds);
                  }
                  seekTo(currentPostion.inSeconds - 10);
                },
                icon: const Icon(
                  Icons.skip_previous_rounded,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {
                  isPlay = !isPlay;
                  setState(() {
                    isPlay ? playMusic() : pauseMusic();
                  });
                },
                icon: isPlay
                    ? const Icon(
                        Icons.pause_circle_outlined,
                        size: 50,
                      )
                    : const Icon(
                        Icons.play_circle_fill_rounded,
                        size: 50,
                      ),
              ),
              IconButton(
                onPressed: () {
                  if (currentPostion <
                      musicLength - const Duration(seconds: 10)) {
                    seekTo(currentPostion.inSeconds);
                    setState(() {
                      isPlay = false;
                    });
                    player.stop();
                  } else {
                    seekTo(currentPostion.inSeconds + 10);
                  }
                },
                icon: const Icon(
                  Icons.skip_next,
                  size: 50,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  playMusic() async {
    await player.play(DeviceFileSource(widget.path));
  }

  pauseMusic() {
    player.pause();
  }

  seekTo(int sec) {
    player.seek(Duration(seconds: sec));
  }
}
