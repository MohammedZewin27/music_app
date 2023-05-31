import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:new_music/provider/providerMusic.dart';
import 'package:provider/provider.dart';

import '../../provider/providerDatabase.dart';
import '../../style/colors.dart';

class Play_Screen extends StatelessWidget {
  final int index;

  const Play_Screen({super.key, required this.index});



  @override
  Widget build(BuildContext context) {
    var providerMusic=Provider.of<ProviderMusic>(context);
    Provider.of<ProviderData>(context);
    var videos = ProviderData.videos;
    providerMusic.player=AudioPlayer();
    providerMusic.setUp();
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
                image: DecorationImage(image: NetworkImage(videos[providerMusic.indexMusic].image),
                fit: BoxFit.fill,
              ),
              border: Border.all(color: LABLECOLOR, width: 5),
            ),
            width: MediaQuery.of(context).size.width * 0.50,
            height: MediaQuery.of(context).size.width * 0.50,
          ),
          Text(
            videos[index].title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ProgressBar(
                  progress: providerMusic.currentPostion,
                  buffered: const Duration(seconds: 40),
                  total: parseDuration(ProviderData.videos[providerMusic.indexMusic].duration),
                  progressBarColor: Colors.red,
                  baseBarColor: Colors.white.withOpacity(0.24),
                  bufferedBarColor: Colors.white.withOpacity(0.24),
                  thumbColor: Colors.white,
                  barHeight: 3.0,
                  thumbRadius: 5.0,
                  onDragEnd: () {
                    providerMusic.isPlay = false;
                  },
                  timeLabelTextStyle: const TextStyle(fontSize: 15),
                  onSeek: (duration) {
                    providerMusic.player.seek(duration);
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
                  if (providerMusic.currentPostion < const Duration(seconds: 10)) {
                    providerMusic.seekTo(providerMusic.currentPostion.inSeconds,);
                  }
                  providerMusic.seekTo(providerMusic.currentPostion.inSeconds - 10,);
                },
                icon: const Icon(
                  Icons.skip_previous_rounded,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () {

                  providerMusic.changePlayMusic();
                  providerMusic.isPlay =! providerMusic.isPlay;

                },
                icon: providerMusic.isPlay
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
                  if (providerMusic.currentPostion <
                      providerMusic.musicLength - const Duration(seconds: 10)) {
                    providerMusic.seekTo(providerMusic.currentPostion.inSeconds);
                      providerMusic.isPlay = false;
                    providerMusic.player.stop();
                  } else {
                    providerMusic.seekTo(providerMusic.currentPostion.inSeconds + 10);
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



  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
}
