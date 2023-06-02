import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../constant/const.dart';
import '../model/model_video_youtube.dart';



  class ProviderVideo extends ChangeNotifier {

  Database? database;
  static const String tableName = 'youtubeVideo10';

  createDatabase() {
    openDatabase(
      'video.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY,
        videoTitle TEXT,
        videoUrl TEXT,
        videoId TEXT,
        videoPublishDate TEXT,
        videoDuration TEXT,
        videoImage TEXT,
        filePath TEXT
      )''');
        print("Table created");
      },
      onOpen: (db) async {
        database = db;
        readDatabase(database);
        print(allVideos2);
      },
    ).then((value) {
      database = value;
      notifyListeners();
    });
  }

  insertDatabase({required MyVideo myVideo}) async {
    await database?.transaction((txn) {
      return txn
          .rawInsert(
        '''INSERT INTO $tableName(
           videoTitle,
           videoUrl,
           videoId,
           videoPublishDate,
           videoDuration,
           videoImage,
           filePath
           ) VALUES(
           "${myVideo.title}",
           "${myVideo.thumbnailUrl}",
           "${myVideo.videoId}",
           "${myVideo.publishDate}",
           "${myVideo.duration}",
           "${myVideo.image}",
           "${myVideo.filePath}"
           )''',
      )
          .then((value) {
        print("$value inserted successfully");
        readDatabase(database);
      })
          .catchError((onError) {
        print('error insert =====');
      });
    });
  }

  readDatabase(database) {
    database?.rawQuery('SELECT * FROM $tableName').then((value) {
      allVideos = value;
      videos = allVideos.map((videoMap) => MyVideo(
        videoId: videoMap['id'].toString(),
        title: videoMap['videoTitle'],
        thumbnailUrl: videoMap['videoUrl'],
        duration: videoMap['videoDuration'],
        publishDate: videoMap['videoPublishDate'],
        image: videoMap['videoImage'],
        filePath: videoMap['filePath'],

      )).toList();
      print(allVideos);
      notifyListeners();
    });
  }

  deleteRowInDatabase({required int id}) async {
    await database
        ?.rawDelete('DELETE FROM $tableName WHERE id = $id')
        .then((value) {
      print("$value delete successfully");
      readDatabase(database);
    }).catchError((onError) {
      print('error delete ===== $onError');
    });
  }
}




