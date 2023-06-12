import 'package:flutter/material.dart';
import 'package:media_z/constant/const.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../model/model_video_youtube.dart';
import '../../provider/providerDatabase.dart';
import '../../style/colors.dart';

class AudioDownloader extends StatefulWidget {
  const AudioDownloader({super.key});

  @override
  _AudioDownloaderState createState() => _AudioDownloaderState();
}

class _AudioDownloaderState extends State<AudioDownloader> {
  String _videoUrl = '';
  String _statusMessage = '';
  String videoId = '';
  String videoTitle = '';
  double progress = 0.0;
  bool downloading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(

          children: [
            TextField(
              onChanged: (value) async {
                await getVideoInfo(value);
                setState(() {
                  _videoUrl = value;
                });
              },
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 18, color: PREMIUMCOLOR),
              decoration: InputDecoration(
                hintText: 'YouTube Video URL',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 25, color: PREMIUMCOLOR),
              ),
            ),
            const SizedBox(height: 20.0),
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
              onPressed: () {
                downloadAudio();
              },
              child: const Text('Download Audio'),
            )
                : Container(),
            const SizedBox(height: 20.0),
            Text(_statusMessage),
            downloading
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: BUTTONCOLOR3,
                valueColor:
                const AlwaysStoppedAnimation<Color>(BUTTONCOLOR2),
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<void> downloadAudio() async {
    var permisson = await Permission.manageExternalStorage.request();
    if (permisson.isGranted){
      try {
        var youtube = YoutubeExplode();
        var video = await youtube.videos.get(_videoUrl);
        var manifest = await youtube.videos.streamsClient.getManifest(video.id);
        var audioStreamInfo = manifest.audioOnly.withHighestBitrate();
        var stream = youtube.videos.streamsClient.get(audioStreamInfo);


        var appDir = await getExternalStorageDirectory();
        var savePath =
            '${appDir?.path}/${video.title}.${audioStreamInfo.container.name}';
        var file = File(savePath);

        updateStatus('Downloading...',);
        await stream.pipe(file.openWrite());
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: PREMIUMCOLOR,
            content: Text('Download complete',
                style: TextStyle(color: Colors.white, fontSize: 25))));
        print(savePath);
        print(savePath.toString());
        await insertVideoInDatabase(_videoUrl, savePath.toString());
      } catch (e) {
        updateStatus('Error: $e');
      }
    }else {
       await Permission.manageExternalStorage.request();
    }


  }

  void updateStatus(String message) {
    setState(() {
      _statusMessage = message;
    });
  }

  Future<void> insertVideoInDatabase(String url, String path) async {
    var video = Provider.of<ProviderData>(context, listen: false);
    var youtubeExplode = YoutubeExplode();
    var videoInfo = await youtubeExplode.videos.get(url);
    var videoId = await videoInfo.id;
    var audio = MyVideo(
        videoId: videoId.value.toString(),
        image: 'https://img.youtube.com/vi/$videoId/0.jpg',
        title: videoInfo.title,
        thumbnailUrl: videoInfo.url,
        duration: videoInfo.duration.toString().substring(2, 7),
        publishDate: videoInfo.publishDate.toString().substring(0, 11),
        filePath: path);

    video.insertDatabase(myVideo: audio );
  }

  getVideoInfo(url) async {
    try {
      var videoInfo = YoutubeExplode();
      var video = await videoInfo.videos.get(url);
      videoId = video.id.toString();
      videoTitle = video.title.toString();
    } catch (e) {
      print('error  $e');
    }
  }
}