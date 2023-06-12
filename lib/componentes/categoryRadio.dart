import 'package:flutter/material.dart';
import 'package:media_z/generated/assets.dart';


class CategoryRadio {

  String title;
  String image;
  String id;

  CategoryRadio( this.title, this.image, this.id);

  static List<CategoryRadio> getCategoryData() {
    return [
      // CategoryRadio( 'راديو مصر', Assets.imageRadioMaser, 'http://www.hostmyradio.com:8010'),
      CategoryRadio( '100.6 نجوم اف ام', Assets.imageNojomFm, 'https://audio.nrpstream.com/listen/nogoumfm/radio.mp3'),
     //CategoryRadio( 'القران الكريم', Assets.imageQruanRaidoz, 'http://n09.radiojar.com/8s5u5tpdtwzuv?rj-ttl=5&rj-tok=AAABiK5EhqkAdpvge6PBQv148Q'),
      CategoryRadio( 'OnSportFM', Assets.imageOnSportFM, 'https://carina.streamerr.co:2020/stream/OnSportFM'),
      CategoryRadio( 'FM', Assets.imageFm, 'https://stream-163.zeno.fm/0ms1g2tgr18uv?zs=v2hUv_9CQKeESSWhVkbXqQ'),
      // CategoryRadio( 'RADIO', Assets.imageRfm, 'http://www.hostmyradio.com:8010'),
    ];
  }
}
