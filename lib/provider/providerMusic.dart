

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';




class ProviderMusic extends ChangeNotifier{


  int indexMusic=0;


  changeIndexMusic(int index){
    indexMusic=index;
    notifyListeners();
  }
  // late AudioPlayer player;

  bool isPlay=false;




}