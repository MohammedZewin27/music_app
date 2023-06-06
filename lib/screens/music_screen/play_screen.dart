// import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:new_music/componentes/videoCard.dart';
// import 'package:new_music/provider/providerMusic.dart';
// import 'package:provider/provider.dart';
// import '../../componentes/musicCard.dart';
// import '../../constant/const.dart';
// import '../../model/model_video_youtube.dart';
// import '../../provider/provider.dart';
// import '../../provider/providerDatabase.dart';
// import '../../style/colors.dart';
//
// class Play_Screen extends StatefulWidget {
//   final MyVideo video;
//
//   const Play_Screen({
//     super.key,
//     required this.video,
//   });
//
//   @override
//   State<Play_Screen> createState() => _Play_ScreenState();
// }
//
// class _Play_ScreenState extends State<Play_Screen> {
//   late AudioPlayer player;
//
//   Duration currentPostion = Duration();
//   Duration musicLength = Duration();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     player = AudioPlayer();
//     setUp();
//   }
//
//   setUp() {
//     player.onPositionChanged.listen((event) async {
//       setState(() {
//         setState(() {});
//         currentPostion = event;
//         print('currentPostion =====>$currentPostion');
//       });
//       player.onDurationChanged.listen((Duration event) {
//         setState(() {
//           setState(() {});
//           musicLength = event;
//           print('musicLength =====> $musicLength');
//         });
//       });
//     });
//   }
//
//   // @override
//   // void dispose() {
//   //   // TODO: implement dispose
//   //   super.dispose();
//   //   player.dispose();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     var providerMusic = Provider.of<ProviderMusic>(context);
//
//     Provider.of<ProviderData>(context);
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(100),
//               image: DecorationImage(
//                 image: NetworkImage(widget.video.image),
//                 fit: BoxFit.fill,
//               ),
//               border: Border.all(color: LABLECOLOR, width: 5),
//             ),
//             width: MediaQuery.of(context).size.width * 0.40,
//             height: MediaQuery.of(context).size.width * 0.40,
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             widget.video.title,
//             style: Theme.of(context)
//                 .textTheme
//                 .headlineLarge
//                 ?.copyWith(fontSize: 20),
//             maxLines: 2,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Expanded(
//                 child: ProgressBar(
//                   progress: currentPostion,
//                   buffered: const Duration(seconds: 40),
//                   total: parseDuration(widget.video.duration),
//                   progressBarColor: Colors.red,
//                   baseBarColor: Colors.white.withOpacity(0.24),
//                   bufferedBarColor: Colors.white.withOpacity(0.24),
//                   thumbColor: Colors.white,
//                   barHeight: 3.0,
//                   thumbRadius: 5.0,
//                   onDragEnd: () {
//                     providerMusic.isPlay = false;
//                   },
//                   timeLabelTextStyle: const TextStyle(fontSize: 15),
//                   onSeek: (duration) {
//                     player.seek(duration);
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   if (currentPostion < const Duration(seconds: 10)) {
//                     seekTo(currentPostion.inSeconds);
//                   }
//                   seekTo(currentPostion.inSeconds - 10);
//                 },
//                 icon: const Icon(
//                   Icons.skip_previous_rounded,
//                   size: 30,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   providerMusic.isPlay = !providerMusic.isPlay;
//                   setState(() {
//                     providerMusic.isPlay ? playMusic() : pauseMusic();
//                   });
//                 },
//                 icon: providerMusic.isPlay
//                     ? const Icon(
//                         Icons.pause_circle_outlined,
//                         size: 40,
//                       )
//                     : const Icon(
//                         Icons.play_circle_fill_rounded,
//                         size: 40,
//                       ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   if (currentPostion <
//                       musicLength - const Duration(seconds: 10)) {
//                     seekTo(currentPostion.inSeconds);
//
//                     // providerMusic.isPlay = false;
//
//                     player.stop();
//                   } else {
//                     seekTo(currentPostion.inSeconds + 10);
//                   }
//                 },
//                 icon: const Icon(
//                   Icons.skip_next,
//                   size: 30,
//                 ),
//               ),
//             ],
//           ),
//           Visibility(
//             visible:   allAudio.isNotEmpty,
//             child: Expanded(
//               child: ListView.builder(
//                 itemCount: allAudio.length,
//                 itemBuilder: (context, index) => InkWell(
//                     onTap: () {
//                       providerMusic.changeIndexMusic(index);
//                       if (providerMusic.isPlay) {
//                         stopPlay();
//                         providerMusic.isPlay = false;
//                         print("INDEX ================> ${providerMusic.isPlay}");
//                       } else {
//                         playMusic();
//                         providerMusic.isPlay = true;
//                         print("INDEX ================> $index");
//                       }
//                     },
//                     child: VideoCard(
//                       videoOrAudio: allAudio,
//                         image: audios[index].image,
//                         duration: audios[index].duration,
//                         title: audios[index].title,
//                         index: index)
//                     ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   playMusic() async {
//     await player.play(DeviceFileSource(widget.video.filePath));
//   }
//
//   pauseMusic() {
//     player.pause();
//   }
//
//   seekTo(int sec) {
//     player.seek(Duration(seconds: sec));
//   }
//
//   stopPlay() {
//     player.stop();
//   }
//
//   Duration parseDuration(String s) {
//     int hours = 0;
//     int minutes = 0;
//     int micros;
//     List<String> parts = s.split(':');
//     if (parts.length > 2) {
//       hours = int.parse(parts[parts.length - 3]);
//     }
//     if (parts.length > 1) {
//       minutes = int.parse(parts[parts.length - 2]);
//     }
//     micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
//     return Duration(hours: hours, minutes: minutes, microseconds: micros);
//   }
// }
