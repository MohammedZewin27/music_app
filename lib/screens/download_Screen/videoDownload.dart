import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_music/constant/const.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../model/model_video_youtube.dart';
import '../../provider/provider.dart';
import '../../provider/providerDatabase.dart';
import '../../style/colors.dart';



class DownLoadVideo extends StatefulWidget {
  const DownLoadVideo({Key? key}) : super(key: key);

  @override
  State<DownLoadVideo> createState() => _DownLoadVideoState();
}

class _DownLoadVideoState extends State<DownLoadVideo> {
  final TextEditingController urlTextEditingController =
  TextEditingController();
  String videoTitle = '';
  String videoPublishDate = '';
  String videoId = '';
  bool downloading = false;

  double progress = 0.0;
  var pathFileInMyPhone;
  late double re;


  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: urlTextEditingController,
                onChanged: (value) async {
                  await getVideoInfo(value);
                },
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 18, color: PREMIUMCOLOR),
                decoration: InputDecoration(
                  hintText: 'YouTube Video URL Here',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 20, color: PREMIUMCOLOR),
                ),
              ),
            ),
            videoId != '' && videoId.length > 10
                ? Row(
              children: [
                Image.network(
                  'https://img.youtube.com/vi/$videoId/0.jpg',
                  height: 100,
                  width: 100,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      child: Text(
                        maxLines: 2,
                        videoTitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.green, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            )
                : Container(),
            videoId != '' && videoId.length > 10
                ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PREMIUMCOLOR
              ),
              onPressed: () async{
               await downloadVideo(urlTextEditingController.text).then((value) {
                 urlTextEditingController.clear();
               });
              },
              child: const Text('Download video',style: TextStyle(color: Colors.white),),
            )
                : Container(),
            const SizedBox(height: 20.0),
            downloading
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('${(progress*100).toStringAsFixed(0)}%'??'',style: const TextStyle(
                    color: PREMIUMCOLOR,
                  ),),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.blueAccent,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.greenAccent),
                  ),
                ],
              ),
            )
                : Container(),
          ],

    );
  }

  Future<void> getVideoInfo(url) async {
    try {
      var videoInfo = YoutubeExplode();
      var video = await videoInfo.videos.get(url);
      setState(() {
        videoTitle = video.title;
        videoPublishDate = video.publishDate.toString().substring(0, 11);
        videoId = video.id.toString();
      });
    } catch (e) {
      print('======= $e');
    }
  }

  Future<void> downloadVideo(url) async {
    var permisson = await Permission.storage.request();
    if (permisson.isGranted) {
      //download video
      if (urlTextEditingController.text != '') {
        setState(() => downloading = true);
        //download video
        setState(() => progress = 0);
        var youtubeExplode = YoutubeExplode();
        //get video metadata
        var videoDownload = await youtubeExplode.videos.get(url);
        var manifest =
        await youtubeExplode.videos.streamsClient.getManifest(url);
        var streams = manifest.muxed.withHighestBitrate();
        var audio = streams;
        var audioStream = youtubeExplode.videos.streamsClient.get(audio);
        //create a directory
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;

        var filePath = File('$appDocPath/${videoDownload.id}');
        //delete filePath if exists
        if (filePath.existsSync()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                '  video exist!',
                style: TextStyle(color: Colors.red),
              )));
          setState(() {
            downloading = false;
          });
          return;
          // filePath.deleteSync();
        }
        var output = filePath.openWrite(mode: FileMode.writeOnlyAppend);
        var size = audio.size.totalBytes;
        var count = 0;

        await for (final data in audioStream) {
          // Keep track of the current downloaded data.
          count += data.length;
          // Calculate the current progress.
          double val = ((count / size));
          for (val; val == 1.0; val++) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: PREMIUMCOLOR,
                content: Text('Download complete',
                    style: TextStyle(color: Colors.white, fontSize: 25))));
          }
          setState(() => progress = val);

          output.add(data);
        }
        /// add to database
        await insertVideoInDatabase(urlTextEditingController.text);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red ,
            content: Text('add youtube video url first!',
                style: TextStyle(color: Colors.white))));
        setState(() => downloading = false);
      }
    } else {
      await Permission.storage.request();
    }
  }

  Future<void> insertVideoInDatabase(String url) async {
    try{
      var video = Provider.of<ProviderData>(context, listen: false);
      var youtubeExplode = YoutubeExplode();
      var videoInfo = await youtubeExplode.videos.get(url);
      var videoId = await videoInfo.id;
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      var myVideo = MyVideo(
          videoId: videoId.value.toString(),
          image: 'https://img.youtube.com/vi/$videoId/0.jpg',
          title: videoInfo.title,
          thumbnailUrl: videoInfo.url,
          duration: videoInfo.duration.toString().substring(2, 7),
          publishDate: videoInfo.publishDate.toString().substring(0, 11),
          filePath: '$appDocPath/${videoInfo.id}');

      video.insertDatabaseVideo(myVideo: myVideo,);
      print('successfully insertVideoInDatabase ======> Done');
    }catch (e){
      print('Error insertVideoInDatabase ======> $e');
    }

  }
}
