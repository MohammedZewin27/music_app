import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:new_music/provider/providerDatabase.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../constant/const.dart';

class ProviderVideo extends ChangeNotifier {
  int indexVideo = 0;

  late Duration positionNow=Duration();

  void videoPosition(Duration duration) {
    positionNow = duration;
    notifyListeners();
  }
}