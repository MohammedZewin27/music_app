import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_music/componentes/videoCard.dart';
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
  void initState()  {
    super.initState();
    controller =
         VideoPlayerController.file(File(videos[indexVideo].filePath))
          ..initialize().then((value) {
            setState(() {});
          });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

   bool isPlay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: controller.value.isInitialized
                ? InkWell(
                    onTap: () {
                      isPlay ? controller.pause() : controller.play();
                      setState(() {
                        isPlay = !isPlay;
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
                : AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: ()  {
                  controller =  VideoPlayerController.file(
                      File(videos[index].filePath))
                    ..initialize().then((value) {
                      setState(() {});
                    });
                  controller.play();
                  setState(() {
                    isPlay = !isPlay;
                  });
                },
                child: VideoCard(
                  image: videos[index].image,
                  duration: videos[index].duration,
                  title: videos[index].title,

                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
