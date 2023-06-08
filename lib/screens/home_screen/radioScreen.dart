// import 'package:flutter/material.dart';
//
// import '../generated/assets.dart';
// import '../style/colors.dart';
//
// class RadiosCard extends StatelessWidget {
//   final String name;
//   final String image;
//   final double height;
//
//   const RadiosCard({Key? key, required this.name, required this.image,this.height=0.10})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 5),
//       child: Container(
//         decoration: BoxDecoration(
//           color: LABLECOLOR1,
//           image: const DecorationImage(
//               image: AssetImage(Assets.imageBacgroundMusic,),
//               fit: BoxFit.cover,
//               opacity: 0.1),
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: BUTTONCOLOR.withOpacity(0.2),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         height: MediaQuery.of(context).size.height * height,
//         width: double.infinity,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Icon(Icons.arrow_back_ios, size: 35, color: BUTTONCOLOR),
//               Text(
//                 name,
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: BUTTONCOLOR,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w900,
//                     ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   image: DecorationImage(image: NetworkImage(image),
//                     fit: BoxFit.fill,
//                   ),
//                   border: Border.all(color: LABLECOLOR, width: 1),
//                 ),
//                 width: MediaQuery.of(context).size.width * 0.1,
//                 height: MediaQuery.of(context).size.width * 0.1,
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:new_music/generated/assets.dart';
import 'package:new_music/network/api_manager.dart';
import 'package:provider/provider.dart';

import '../../constant/const.dart';
import '../../model/model_video_youtube.dart';
import '../../../model/api_Radios.dart';
import '../../provider/providerDatabase.dart';
import '../../provider/providerMusic.dart';
import '../../style/colors.dart';

class RadioScreen extends StatefulWidget {
  static const String routeName = 'radio';

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  late AudioPlayer player;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var proAudio = Provider.of<ProviderMusic>(context);
    var provData = Provider.of<ProviderData>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(
                        image: AssetImage(Assets.imageQruan),
                        fit: BoxFit.fill,
                      ),
                      border: Border.all(color: LABLECOLOR, width: 5),
                    ),
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: MediaQuery.of(context).size.width * 0.40,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    proAudio.titleRadio,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontSize: 20),
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_previous_rounded,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          proAudio.isPlayRadio = !proAudio.isPlayRadio;
                          setState(() {
                            proAudio.isPlayRadio
                                ? playMusic(
                                    'https://backup.qurango.net/radio/nasser_alosfor')
                                : pauseMusic();
                          });
                        },
                        icon: proAudio.isPlayRadio
                            ? const Icon(
                                Icons.pause_circle_outlined,
                                size: 40,
                              )
                            : const Icon(
                                Icons.play_circle_fill_rounded,
                                size: 40,
                              ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.skip_next,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: FutureBuilder<ApiRadios>(
                future: ApiManager.getSources(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('SomeThing Wrong'));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.radios?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            if (proAudio.isPlayRadio) await player.stop();
                            await playMusic(
                                '${snapshot.data!.radios?[index].url}');
                            proAudio.isPlayRadio = !proAudio.isPlayRadio;
                            proAudio.changeTitleRadio(
                                '${snapshot.data!.radios?[index].name}');
                          },
                          child: Card(
                            elevation:20 ,
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(Assets.iconRadio,
                                    height: 50, width: 50, fit: BoxFit.fill),
                                Center(
                                  child: Text(
                                    '${snapshot.data!.radios?[index].name}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: PREMIUMCOLOR),
                                  ),
                                ),
                              ],
                            ),
                          )),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  playMusic(String radio) async {
    await player.play(DeviceFileSource(radio));
    print('index music ================================== ${radio}');
  }

  pauseMusic() {
    player.pause();
  }



  stopPlay() {
    player.stop();
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
