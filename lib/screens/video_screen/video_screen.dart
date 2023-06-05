import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_music/componentes/defaultButton.dart';
import 'package:new_music/componentes/videoCard.dart';
import 'package:new_music/constant/const.dart';
import 'package:new_music/provider/providerDatabase.dart';
import 'package:new_music/provider/providerVideo.dart';
import 'package:new_music/screens/setting_screen/addVideo.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../provider/provider.dart';
import '../../provider/providerMusic.dart';
import '../../style/colors.dart';
import '../../test.dart';

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
      /// اعطاه قيمة من الانترنت بدون تشغيله
      controller = VideoPlayerController.network(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
        ..initialize().then((value) {
          controllerInitialize = false;
          setState(() {
            controller.dispose();
          });
        });
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
    var provider = Provider.of<ProviderVideo>(context);
    Provider.of<ProviderData>(context);

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: allVideo.isNotEmpty,
          child: InkWell(
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
        ),
        Visibility(
          visible: allVideo.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Column(
              children: [
                IconButton(onPressed: (){

                  Navigator.pushNamed(context, FullScreenVideoPlayer.routeName);

                },icon: Icon(Icons.add)),
                VideoProgressIndicator(
                  controller,
                  allowScrubbing: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.positionNow.toString().substring(2, 7),
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 17),
                    ),
                    Text(
                      videos.isNotEmpty ? videos[indexVideo].duration : '',
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        allVideo.isNotEmpty
            ? Expanded(
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
            : Center(
            child: Column(
              children: [
                const Text(
                  'download video',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                FloatingActionButton(
                  onPressed: () {
                    var pro = Provider.of<MyProvider>(context, listen: false);
                    pro.changeCurrent(3);
                    pro.screens[pro.indexScreen];
                  },
                  backgroundColor: BUTTONCOLOR3,
                  child: const Icon(
                    Icons.get_app_outlined,
                    color: LABLECOLOR1,
                    size: 35,
                  ),
                ),
              ],
            ))
      ],
    ));
  }

  void videoPosition() {}
}
