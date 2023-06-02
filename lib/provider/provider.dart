import 'package:flutter/cupertino.dart';
import 'package:new_music/screens/home_screen/home_screen.dart';

import 'package:new_music/screens/setting_screen/setting_screen.dart';
import 'package:new_music/screens/video_screen/video_screen.dart';

import '../componentes/musicCard.dart';
import '../screens/music_screen/music_screen.dart';

class MyProvider extends ChangeNotifier{

  List<Widget> screens=[
    const Home_Screen(),
    Music_Screen(),
     Video_Screen(),
     Setting_Screen()
  ];

  List<String>textTitle=[
   ' Home',
    'Music',
    'Video',
    'Setting'
  ];

int indexScreen=0;
  changeCurrent(int index){
indexScreen=index;
notifyListeners();

  }





}