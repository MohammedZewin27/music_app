import 'package:flutter/material.dart';
import 'package:new_music/provider/providerMusic.dart';
import 'package:new_music/screens/music_screen/play_screen.dart';
import 'package:provider/provider.dart';

import '../../componentes/homeCard.dart';
import '../../componentes/musicCard.dart';
import '../../provider/provider.dart';
import '../../provider/providerDatabase.dart';

class Music_Screen extends StatelessWidget {
  const Music_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var providerMusic = Provider.of<ProviderMusic>(context);
    return Scaffold(
      body: ProviderData.allVideos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Play_Screen(index: providerMusic.indexMusic),
                Expanded(
                  child: ListView.builder(
                    itemCount: ProviderData.allVideos.length,
                    itemBuilder: (context, index) =>
                        ProviderData.allVideos.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : InkWell(
                          onTap: () {

                            providerMusic.changeIndexMusic(index);
                            providerMusic.changePlayMusic();

                            print("INDEX ===> $index");
                          },
                              child: MusicCard(
                          height: 0.07,
                                  title: ProviderData.videos[index].title.substring(0,20),
                                  image: ProviderData.videos[index].image),
                            ),
                  ),
                ),
              ],
            ),
    );
  }
}
