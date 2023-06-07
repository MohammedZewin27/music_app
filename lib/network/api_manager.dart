import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:new_music/model/api_Radios.dart';

class ApiManager {
  static const String BASE = 'mp3quran.net/api/v3/radios';
  static const String ENDPOINT = 'v3/radios';

 static Future<ApiRadios> getSources() async {
//https://mp3quran.net/api/v3/radios?language=ar
   final url = Uri.parse('https://mp3quran.net/api/v3/radios?language=ar');
    // var url = Uri.https(BASE, ENDPOINT, {'language': 'ar'});

    Response sources = await http.get(url);
    print(sources.statusCode);
    var json = jsonDecode(sources.body);
    ApiRadios apiRadios = ApiRadios.fromJson(json);
    return apiRadios;
  }
}
