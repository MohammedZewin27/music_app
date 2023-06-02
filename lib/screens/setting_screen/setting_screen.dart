import 'package:flutter/material.dart';
import 'package:new_music/screens/setting_screen/addVideo.dart';

import '../../componentes/defaultButton.dart';

import '../../style/colors.dart';
import 'AddAudio.dart';

class Setting_Screen extends StatefulWidget {
  Setting_Screen({Key? key}) : super(key: key);

  @override
  State<Setting_Screen> createState() => _Setting_ScreenState();
}

class _Setting_ScreenState extends State<Setting_Screen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool isBottomSheetShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DefaultButton(                        /// Audio
                onPressed: () {
                  if (isBottomSheetShow) {
                    isBottomSheetShow = false;
                    print(isBottomSheetShow);
                    Navigator.pop(context);
                    setState(() {});
                  } else {
                    isBottomSheetShow = true;
                    print(isBottomSheetShow);
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) {
                            return Container(
                                color: Colors.transparent, child: AddAudio());
                          },
                          elevation: 30,
                        )
                        .closed
                        .then((value) {
                          isBottomSheetShow = false;
                          print('vvvv $value');
                          setState(() {});
                        });
                    setState(() {});
                  }
                },
                text: 'Youtube Audio'),
            SizedBox(
              height: 10,
            ),
            DefaultButton(                    /// Video
                color: BUTTONCOLOR2,
                onPressed: () {
                  if (isBottomSheetShow) {
                    isBottomSheetShow = false;
                    print(isBottomSheetShow);
                    Navigator.pop(context);
                    setState(() {});
                  } else {
                    isBottomSheetShow = true;
                    print(isBottomSheetShow);
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) {
                            return Container(
                                color: Colors.transparent, child: const AddVideo());
                          },
                          elevation: 30,
                        )
                        .closed
                        .then((value) {
                          isBottomSheetShow = false;
                          print('vvvv $value');
                          setState(() {});
                        });
                    setState(() {});
                  }
                },
                text: 'Youtube Video'),
            const SizedBox(
              height: 10,
            ),
            DefaultButton(                   /// Gallery Video
                color: BUTTONCOLOR3,
                onPressed: () {
                  if (isBottomSheetShow) {
                    isBottomSheetShow = false;
                    print(isBottomSheetShow);
                    Navigator.pop(context);
                    setState(() {});
                  } else {
                    isBottomSheetShow = true;
                    print(isBottomSheetShow);
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) {
                            return Container(
                                color: Colors.transparent, child: Text('غير متاح الان'));
                          },
                          elevation: 30,
                        )
                        .closed
                        .then((value) {
                          isBottomSheetShow = false;
                          print('vvvv $value');
                          setState(() {});
                        });
                    setState(() {});
                  }
                },
                text: 'Gallery Video'),
          ],
        ),
      ),
    );
  }
}
