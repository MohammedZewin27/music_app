import 'package:flutter/material.dart';
import 'package:new_music/generated/assets.dart';


class CategoryData {

  String title;
  String image;
  String id;

  CategoryData( this.title, this.image, this.id);

  static List<CategoryData> getCategoryData() {
    return [
      CategoryData( 'القرآن الكريم', Assets.imageQruanKarim, 'qK-zm6rcYmA'),
      CategoryData( 'CBC Live', Assets.imageCbc, '2i9vdjk6hMg'),
      CategoryData( 'AlArabiya', Assets.imageAlarabia, '_rewJPptlBg'),
      CategoryData( 'AlHadath Live', Assets.imageAlHadath, 'St61kDYyrvk'),
      CategoryData( 'افلام عربي', Assets.imageArabicFilm, 'lTTzbsSpiLo'),
      CategoryData( 'افلام كوميدي', Assets.imageCondyFilm, 'ZA1CnU7itQ8'),
      CategoryData( 'beIN SPORTS', Assets.imageBeINSPORTS, 'eIjjS2M4Wxg'),
      CategoryData( 'Al Jazeera Arabic', Assets.imageAlJazeeraArabic, 'bNyUyrR0PHo'),


    ];
  }
}
