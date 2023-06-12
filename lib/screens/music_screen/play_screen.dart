import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:media_z/componentes/videoCard.dart';
import 'package:media_z/provider/providerMusic.dart';
import 'package:provider/provider.dart';
import '../home_screen/radioScreen.dart';
import '../../constant/const.dart';
import '../../model/model_video_youtube.dart';
import '../../provider/provider.dart';
import '../../provider/providerDatabase.dart';
import '../../style/colors.dart';

class Play_Screen extends StatefulWidget {
  static const String routeName = 'music';
  final MyVideo audio;

  const Play_Screen({
    super.key,
    required this.audio,
  });
  @override
  State<Play_Screen> createState() => _Play_ScreenState();
}

class _Play_ScreenState extends State<Play_Screen> {
  late AudioPlayer player;


  Duration currentPostion = Duration();
  Duration musicLength = Duration();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player = AudioPlayer();
    setUp();
  }

  setUp() {
    player.onPositionChanged.listen((event) async {
      setState(() {
        setState(() {});
        currentPostion = event;
        print('currentPostion =====>$currentPostion');
      });
      player.onDurationChanged.listen((Duration event) {
        setState(() {
          setState(() {});
          musicLength = event;
          print('musicLength =====> $musicLength');
        });
      });
    });
  }


  @override
  void dispose() async{
    // TODO: implement dispose
    super.dispose();
   await player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var proAudio = Provider.of<ProviderMusic>(context);
   var provData= Provider.of<ProviderData>(context);
    return allAudio.isNotEmpty
        ? Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: NetworkImage(audios[proAudio.indexMusic].image),
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
            audios[proAudio.indexMusic].title,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontSize: 20),
            maxLines: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ProgressBar(
                  progress: currentPostion,
                  buffered: const Duration(seconds: 40),
                  total: parseDuration(audios[proAudio.indexMusic].duration),
                  progressBarColor: Colors.red,
                  baseBarColor: Colors.white.withOpacity(0.24),
                  bufferedBarColor: Colors.white.withOpacity(0.24),
                  thumbColor: Colors.white,
                  barHeight: 3.0,
                  thumbRadius: 5.0,
                  onDragEnd: () {
                    proAudio.isPlay = false;
                  },
                  timeLabelTextStyle: const TextStyle(fontSize: 15),
                  onSeek: (duration) {
                    player.seek(duration);
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () async{
                  var proMusic = Provider.of<ProviderMusic>(context,listen: false);
                  if(proMusic.indexMusic==0) {
                    return;
                  }else{
                    proMusic.indexMusic=proMusic.indexMusic-1;
                   await playMusic();
                  }
                },
                icon: const Icon(
                  Icons.skip_previous_rounded,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  proAudio.isPlay = !proAudio.isPlay;
                  setState(() {
                    proAudio.isPlay ? playMusic() : pauseMusic();
                  });
                },
                icon: proAudio.isPlay
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
                onPressed: () async{
                  var proMusic = Provider.of<ProviderMusic>(context,listen: false);
                  if(proMusic.indexMusic>=audios.length-1) {
                    return;
                  }else{
                     proMusic.indexMusic++;
                    await playMusic();
                  }
                },
                icon: const Icon(
                  Icons.skip_next,
                  size: 30,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allAudio.length,
              itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    proAudio.changeIndexMusic(index);
                    if (proAudio.isPlay) {
                      stopPlay();
                      proAudio.isPlay = false;
                      print(
                          "INDEX ================> ${proAudio.isPlay}");
                    } else {
                      playMusic();
                      proAudio.isPlay = true;
                      print("INDEX ================> $index");
                    }
                  },
                  child: VideoCard(
                    height: 50,
                      maxLines: 1,
                      padding: 0.0,
                   delete: (context){
                     provData.deleteRowInDatabaseAudio(id: allAudio[index]['id']);
                     provData.deleteFile(allAudio[index]['filePath']);
                   },
                      image: audios[index].image,
                      duration: audios[index].duration,
                      title: audios[index].title,
                      index: index)),
            ),
          ),
        ],
      ),
    )
        : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'download audio',
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
        ));
  }

  playMusic() async {
    var proMusic = Provider.of<ProviderMusic>(context,listen: false);
    await player.play(DeviceFileSource(audios[proMusic.indexMusic].filePath));
    print('index music ================================== ${proMusic.indexMusic}');
  }

  pauseMusic() {
    player.pause();
  }

  seekTo(int sec) {
    player.seek(Duration(seconds: sec));
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