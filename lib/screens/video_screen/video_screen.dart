import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_music/constant/const.dart';
import 'package:new_music/model/model_video_youtube.dart';
import 'package:video_player/video_player.dart';

class Video_Screen extends StatefulWidget {
  const Video_Screen({Key? key}) : super(key: key);

  @override
  State<Video_Screen> createState() => _Video_ScreenState();
}

class _Video_ScreenState extends State<Video_Screen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.file(File(videos[2].filePath))
      ..initialize().then((value) {
        setState(() {

        });
      });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
     controller.dispose();
  }
bool isPlay=false;
  @override
  Widget build(BuildContext context) {
    print('${videos[1].filePath}');
    return Scaffold(
      body: Column(
        children: [
          controller.value.isInitialized
              ? InkWell(
            onTap: () {
             isPlay? controller.pause():controller.play();
             setState(() {
               isPlay=!isPlay;
             });
            },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                ),
              )
              : Container(),

          Expanded(
            child: ListView.builder(
              itemCount: allVideo.length,
              itemBuilder: (context, index) => Text('d'),),
          )
        ],
      ),
    );
  }
}
