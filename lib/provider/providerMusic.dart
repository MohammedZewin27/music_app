

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:new_music/provider/providerDatabase.dart';
import 'package:provider/provider.dart';

import '../constant/const.dart';



class ProviderMusic extends ChangeNotifier{




  changeIndexMusic(int index){
    indexMusic=index;
    notifyListeners();
  }
  late AudioPlayer player;

  bool isPlay=false;




}