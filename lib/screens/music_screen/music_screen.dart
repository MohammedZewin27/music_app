import 'package:flutter/material.dart';
import 'package:new_music/provider/providerMusic.dart';
import 'package:new_music/screens/music_screen/play_screen.dart';
import 'package:provider/provider.dart';
import '../../constant/const.dart';


class Music_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var providerMusic = Provider.of<ProviderMusic>(context);
    return Scaffold(
      body:  allAudio.isNotEmpty? Play_Screen(video: audios[indexMusic]):const Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No Song'),
            Text('go to setting'),
          ],
        ),
      ),
    );
  }
}
