import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:new_music/provider/providerDatabase.dart';



class ProviderMusic extends ChangeNotifier{


  int indexMusic=0;
bool disposeAudio=false;

  changeIndexMusic(int index){
    player.dispose();
    indexMusic=index;
    notifyListeners();
  }
  late AudioPlayer player;

  bool isPlay=false;
  changePlayMusic(){
   if(isPlay) player.stop();
 playMusic(indexMusic);
    notifyListeners();
  }


  Duration currentPostion = Duration();
  Duration musicLength = Duration();
  setUp() {
    player.onPositionChanged.listen((event) async {
        currentPostion = event;
        print('currentPostion =====>$currentPostion');
        notifyListeners();
      });
      player.onDurationChanged.listen((Duration event) {
          musicLength = event;
          print('musicLength =====> $musicLength');
          notifyListeners();
        });
     notifyListeners();
    }



  playMusic(int index) async {
    await player.play(DeviceFileSource(ProviderData.allVideos[index]['filePath']));
    notifyListeners();
  }

  pauseMusic() {
    player.pause();
    notifyListeners();
  }

  seekTo(int sec,) {
    player.seek(Duration(seconds: sec));
    notifyListeners();
  }


playAudioPlayer () {
  player = AudioPlayer();
  setUp();
 changePlayMusic() ;

}


  disposeAudioPlayer(){
   player.dispose();
   notifyListeners();
  }



}