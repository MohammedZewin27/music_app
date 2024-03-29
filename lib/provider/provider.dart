import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_z/screens/home_screen/home_screen.dart';

import 'package:media_z/screens/setting_screen/setting_screen.dart';
import 'package:media_z/screens/video_screen/video_screen.dart';

import '../constant/const.dart';
import '../screens/home_screen/radio/radioScreen.dart';
import '../screens/music_screen/music_screen.dart';
import '../screens/music_screen/play_screen.dart';

class MyProvider extends ChangeNotifier {
  String copiedText = '';

  void onTextCopied(String text) {
    copiedText = text; // تحديث قيمة المتغير عند نسخ النص
    notifyListeners();
  }

  copyText() {
    Clipboard.getData('text/plain').then((value) {
      if (value != null && value.text != null) {
        onTextCopied(value.text!);
        notifyListeners();// استدعاء الدالة عند نسخ النص
      }

    });
    notifyListeners();
  }

  int progressYoutube = 0;

  changeprogressYoutube(int index) {
    progressYoutube = index;
    notifyListeners();
  }

  List<Widget> screens = [
    const Home_Screen(),
    Music_Screen(),
    VideoScreen(),
    Setting_Screen()
  ];

  List<String> textTitle = [' Home', 'Music', 'Video', 'Setting'];
  List<Widget> icons = const [
    Icon(Icons.login_outlined),
    Icon(Icons.library_music),
    Icon(Icons.video_collection),
    Icon(Icons.youtube_searched_for),
  ];

  int indexScreen = 0;

  changeCurrent(int index) {
    indexScreen = index;
    notifyListeners();
  }

  var myUser;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initMyUser();
    }
  }

  void initMyUser() async {
    myUser = firebaseUser?.uid ?? "";
  }

  Future<void> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        print('تم حذف الملف بنجاح');
      } else {
        print('الملف غير موجود');
      }
    } catch (e) {
      print('حدث خطأ أثناء حذف الملف: $e');
    }
  }

  final List<String> items = [
    'Delete',
    'Item2',
    'Item3',
  ];
  String? selectedValue;





  changeChannelIndex(int index) {
    channelIndex = index;
    notifyListeners();
  }




}
