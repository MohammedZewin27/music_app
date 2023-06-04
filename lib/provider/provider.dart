import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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
     VideoScreen (),
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


  var myUser;
  User? firebaseUser;
  MyProvider(){
    firebaseUser=FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null){
      initMyUser();
    }
  }
  void initMyUser()async{
    myUser= firebaseUser?.uid??"";
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


}