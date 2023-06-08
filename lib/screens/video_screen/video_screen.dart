import 'dart:io';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
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
import 'CustomOrientationControls.dart';
import 'fullScreen.dart';

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
    var provData = Provider.of<ProviderData>(context);

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
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: VideoPlayer(controller),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, FullScreen.routeName);
                      },
                      icon: const Icon(
                        Icons.fullscreen,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: allVideo.isNotEmpty,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
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
                      delete: (context) {
                        provData.deleteRowInDatabaseVideo(
                            id: allVideo[index]['id']);
                        provData.deleteFile(allVideo[index]['filePath']);
                      },
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
