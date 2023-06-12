

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';




class ProviderMusic extends ChangeNotifier{

  ///radio Egypt
  String titleRadioEgypt='الله اكبر';
  changeinexRadioEgypt(index){
    indexRadioEgypt=index;
    notifyListeners();
  }
  int indexRadioEgypt=0;
  bool isPlayRadioEgypt=false;

  /// radio
  String titleRadio='الله اكبر';
  changeTitleRadio(String title){
    titleRadio=title;
    notifyListeners();
  }
  int indexMusic=0;
  bool isPlayRadio=false;






 /// music

  changeIndexMusic(int index){
    indexMusic=index;
    notifyListeners();
  }
  // late AudioPlayer player;

  bool isPlay=false;




}