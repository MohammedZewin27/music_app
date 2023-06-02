import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../constant/const.dart';
import '../model/model_video_youtube.dart';

class ProviderData extends ChangeNotifier {
  Database? database;

  createDatabase() {
    openDatabase(
      'video.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $tableAudio (
        id INTEGER PRIMARY KEY,
        videoTitle TEXT,
        videoUrl TEXT,
        videoId TEXT,
        videoPublishDate TEXT,
        videoDuration TEXT,
        videoImage TEXT,
        filePath TEXT
      )''');
        await db.execute('''CREATE TABLE $tableVideo (
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
        await readDatabase(database);
        await readDatabaseVideo(database);

        print(
            'all audio==============================================>  $allAudio');
        print(
            'all video =============================================> $allVideo');
      },
    ).then((value) {
      database = value;
      notifyListeners();
    });
  }

  insertDatabase({required MyVideo myVideo}) async {
    await database?.transaction((txn) {
      return txn.rawInsert(
        '''INSERT INTO $tableAudio(
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
      ).then((value) {
        print("$value inserted successfully");
        readDatabase(database);
      }).catchError((onError) {
        print('error insert =====');
      });
    });
  }

  insertDatabaseVideo({required MyVideo myVideo}) async {
    await database?.transaction((txn) {
      return txn.rawInsert(
        '''INSERT INTO $tableVideo(
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
      ).then((value) {
        print("$value inserted successfully video ");
        readDatabaseVideo(database);
      }).catchError((onError) {
        print('error insert =====');
      });
    });
  }

  readDatabase(database) async {
    await database?.rawQuery('SELECT * FROM $tableAudio').then((value) {
      allAudio = value;
      audios = allAudio
          .map((videoMap) => MyVideo(
                videoId: videoMap['id'].toString(),
                title: videoMap['videoTitle'],
                thumbnailUrl: videoMap['videoUrl'],
                duration: videoMap['videoDuration'],
                publishDate: videoMap['videoPublishDate'],
                image: videoMap['videoImage'],
                filePath: videoMap['filePath'],
              ))
          .toList();
      print(allAudio);
      notifyListeners();
    });
  }

  readDatabaseVideo(database) async {
    await database?.rawQuery('SELECT * FROM $tableVideo').then((value) {
      allVideo = value;
      videos = allVideo
          .map((videoMap) => MyVideo(
                videoId: videoMap['id'].toString(),
                title: videoMap['videoTitle'],
                thumbnailUrl: videoMap['videoUrl'],
                duration: videoMap['videoDuration'],
                publishDate: videoMap['videoPublishDate'],
                image: videoMap['videoImage'],
                filePath: videoMap['filePath'],
              ))
          .toList();
      print(allVideo);
      notifyListeners();
    });
  }

  deleteRowInDatabase({required int id}) async {
    await database
        ?.rawDelete('DELETE FROM $tableAudio WHERE id = $id')
        .then((value) {
      print("$value delete successfully");
      readDatabase(database);
    }).catchError((onError) {
      print('error delete ===== $onError');
    });
  }

  deleteRowInDatabaseVideo({required int id}) async {
    await database
        ?.rawDelete('DELETE FROM $tableVideo WHERE id = $id')
        .then((value) {
      print("$value delete successfully");
      readDatabase(database);
    }).catchError((onError) {
      print('error delete ===== $onError');
    });
  }

}
