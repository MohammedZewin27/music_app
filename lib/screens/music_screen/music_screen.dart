import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:new_music/provider/providerMusic.dart';
import 'package:new_music/screens/music_screen/play_screen.dart';
import 'package:provider/provider.dart';
import '../../constant/const.dart';
import '../../provider/provider.dart';
import '../../style/colors.dart';


class Music_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderMusic>(context);

      return Scaffold(
        body:  allAudio.isNotEmpty? Play_Screen(audio: audios[indexMusic]): Center(
          child:  Center(
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
              )),
        ),
      );
    }



}