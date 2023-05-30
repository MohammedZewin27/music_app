import 'package:flutter/material.dart';
import 'package:new_music/screens/music_screen/play_screen.dart';
import 'package:provider/provider.dart';

import '../../provider/providerDatabase.dart';

class Music_Screen extends StatelessWidget {
   const Music_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderData>(context);
    const int indexd=1;
    String pathVideo = ProviderData.allVideos[indexd]['filePath'];
    print('============================>$pathVideo');
    var videos = ProviderData.videos;
    return Scaffold(
      body:ProviderData.allVideos.isEmpty?const CircularProgressIndicator(): Column(
        children: [
          Play_Screen(title: videos[indexd].title,path: pathVideo,image: videos[indexd].image),
          Expanded(
            child: ListView.builder(
              itemCount: ProviderData.allVideos.length,
              itemBuilder: (context, index) => ProviderData.allVideos.isEmpty?const CircularProgressIndicator(): const Text('data'),),
          ),

        ],
      ),
    );
  }
}
