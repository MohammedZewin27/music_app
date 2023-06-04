import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_music/componentes/videoCard.dart';
import 'package:new_music/constant/const.dart';
import 'package:new_music/provider/providerDatabase.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../provider/providerMusic.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController controller;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    if (videos.isNotEmpty) {
      controller = VideoPlayerController.file(File(videos[indexVideo].filePath))
        ..initialize().then((_) {
          setState(() {
            controllerInitialize = true;
          });
        });
    } else {
      controller = VideoPlayerController.network(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
      controllerInitialize = false;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool controllerInitialize = false;

  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderMusic>(context);
    Provider.of<ProviderData>(context);
    return Scaffold(
      body: controllerInitialize
          ? Column(
              children: [
                InkWell(
                  onTap: () {
                    isPlay ? controller.pause() : controller.play();
                    setState(() {
                      isPlay = !isPlay;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: VideoPlayer(controller),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        controller.dispose();
                        controller = VideoPlayerController.file(
                            File(videos[index].filePath))
                          ..initialize().then((_) {
                            setState(() {
                              controllerInitialize = true;
                            });
                          });
                        controller.play();
                        setState(() {
                          isPlay = true;
                        });
                      },
                      child: VideoCard(
                        index: index,
                        image: videos[index].image,
                        duration: videos[index].duration,
                        title: videos[index].title,
                      ),
                    ),
                  ),
                )
              ],
            )
          : const Center(child: Text('no video')),
    );
  }
}
