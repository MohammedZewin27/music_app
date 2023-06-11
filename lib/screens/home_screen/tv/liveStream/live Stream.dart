import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../componentes/categoryData.dart';
import '../../../../constant/const.dart';




class LiveStream extends StatefulWidget {
  const LiveStream({super.key});

  static const String routeName = 'LiveStream';

  @override
  State<LiveStream> createState() => _LiveStreamState();
}

class _LiveStreamState extends State<LiveStream> {
  late YoutubePlayerController controller;
  bool mute = false;
  late TextEditingController idController;
  bool isFull = false;
  var categorys = CategoryData.getCategoryData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: categorys[channelIndex].id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
        hideControls: false,
      ),
    );
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 19 / 6,
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller,
          onEnded: (metaData) {
            controller.dispose();
          },
        ),
        builder: (context, player) {
          return player;
        },
      ),
    );
  }
}


