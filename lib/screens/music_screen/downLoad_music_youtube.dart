import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../model/model_video_youtube.dart';
import '../../provider/providerDatabase.dart';

class YouTubeAudioDownloader extends StatefulWidget {
  @override
  _YouTubeAudioDownloaderState createState() => _YouTubeAudioDownloaderState();
}

class _YouTubeAudioDownloaderState extends State<YouTubeAudioDownloader> {
  String _videoUrl = '';
  String _statusMessage = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                _videoUrl = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'YouTube Video URL',
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              _downloadAudio();
            },
            child: Text('Download Audio'),
          ),
          SizedBox(height: 20.0),
          Text(_statusMessage),
        ],
      ),
    );
  }

  Future<void> _downloadAudio() async {
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

      _updateStatus('Downloading...');
      await stream.pipe(file.openWrite());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Download complete. File saved to: $savePath',
              style: const TextStyle(color: Colors.green))));
      print(savePath);
print(savePath.toString());
      await insertVideoInDatabase(_videoUrl,savePath.toString());
    } catch (e) {
      _updateStatus('Error: $e');
    }
  }

  void _updateStatus(String message) {
    setState(() {
      _statusMessage = message;
    });
  }

  Future<void> insertVideoInDatabase(String url,String path) async {
    var video = Provider.of<ProviderData>(context, listen: false);
    var youtubeExplode = YoutubeExplode();
    var videoInfo = await youtubeExplode.videos.get(url);
    var videoId = await videoInfo.id;
    var myVideo = MyVideo(
        videoId: videoId.value.toString(),
        image: 'https://img.youtube.com/vi/$videoId/0.jpg',
        title: videoInfo.title,
        thumbnailUrl: videoInfo.url,
        duration: videoInfo.duration.toString().substring(2, 7),
        publishDate: videoInfo.publishDate.toString().substring(0, 11),
        filePath: path

    );

    video.insertDatabase(myVideo: myVideo);
  }
}
