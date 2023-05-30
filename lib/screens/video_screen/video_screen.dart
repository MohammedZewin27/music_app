import 'package:flutter/material.dart';
import 'package:new_music/screens/music_screen/downLoad_music_youtube.dart';

class Video_Screen extends StatelessWidget {
  const Video_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  YouTubeAudioDownloader();

  }
}
