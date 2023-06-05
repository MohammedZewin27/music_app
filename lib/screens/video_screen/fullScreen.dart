import 'dart:async';
import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_music/constant/const.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

import '../../test.dart';

class FullScreen extends StatefulWidget {
  FullScreen({Key? key}) : super(key: key);
  static const String routeName = 'full';

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  late FlickManager flickManager;
  late DataManager dataManager;
  List<String> filePathList = [];

  @override
  void initState() {
    super.initState();
    for (final url in videos) {
      final filePath = url.filePath;
      filePathList.add(filePath);
    }
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.file(
        File(videos[indexVideo ].filePath),
      ),
      onVideoEnd: () {
        dataManager.skipToNextVideo(Duration(seconds: 5));
      },
    );

    dataManager = DataManager(flickManager: flickManager, urls: filePathList);
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  skipToVideo(String url) {
    flickManager.handleChangeVideo(
      VideoPlayerController.file(File(videos[indexVideo + 1].filePath)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && mounted) {
          flickManager.flickControlManager?.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickManager.flickControlManager?.autoResume();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 400,
            child: FlickVideoPlayer(
              flickManager: flickManager,
              preferredDeviceOrientationFullscreen: const [
                DeviceOrientation.portraitUp,
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ],
              flickVideoWithControls: FlickVideoWithControls(
                controls: CustomOrientationControls(dataManager: dataManager),
              ),
              flickVideoWithControlsFullscreen: FlickVideoWithControls(
                videoFit: BoxFit.fitWidth,
                controls: CustomOrientationControls(dataManager: dataManager),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../constant/const.dart';
//
// class FullScreen extends StatefulWidget {
//   static const String routeName = 'full';
//
//   const FullScreen({super.key});
//
//   @override
//   _FullScreenState createState() => _FullScreenState();
// }
//
// class _FullScreenState extends State<FullScreen> {
//   late FlickManager flickManager;
//
//
//   @override
//   void initState() {
//     super.initState();
//     flickManager = FlickManager(
//       videoPlayerController:
//           VideoPlayerController.file(File(videos[indexVideo].filePath)),
//     );
//   }
//
//   @override
//   void dispose() {
//     flickManager.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FlickVideoPlayer(
//       flickManager: flickManager,
//     );
//   }
// }
