import 'package:card_swiper/card_swiper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:new_music/componentes/homeCard.dart';
import 'package:new_music/constant/const.dart';
import 'package:new_music/generated/assets.dart';
import 'package:new_music/network/api_manager.dart';
import 'package:new_music/provider/provider.dart';
import 'package:new_music/screens/home_screen/radioScreen.dart';
import 'package:new_music/style/colors.dart';
import 'package:provider/provider.dart';

import '../../componentes/categoryData.dart';
import '../../model/api_Radios.dart';
import '../video_screen/fullScreen.dart';
import 'liveStream/live Stream.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categorys = CategoryData.getCategoryData();
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                snapshot.data != ConnectivityResult.none && allVideo.isNotEmpty
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: 300,
                        child: Swiper(
                          loop: false,
                          itemCount: allVideo.length,
                          itemBuilder: (context, index) {
                            return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image.network(
                                  videos[index].image,
                                  fit: BoxFit.fill,
                                ));
                          },
                          pagination: const SwiperPagination(),
                          control: const SwiperControl(),
                          itemWidth: 300.0,
                          onTap: (index) {
                            indexVideo = index;
                            Navigator.pushNamed(context, FullScreen.routeName);
                          },
                          layout: SwiperLayout.STACK,
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RadioScreen.routeName);
                    },
                    child: SizedBox(
                      width: 150,
                      height: 100,
                      child: Image.asset(Assets.imageRadio),
                    )),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RadioScreen.routeName);
                    },
                    child: SizedBox(
                      width: 150,
                      height: 100,
                      child: Image.asset(Assets.imageTv),
                    )),
                Expanded(
                    child: GridView.builder(
                  itemCount: categorys.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 8),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          var pro = Provider.of<MyProvider>(context,listen: false);
                          pro.changeChannelIndex(index);
                          Navigator.pushNamed(context, LiveStream.routeName);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(image: AssetImage(categorys[index].image),fit: BoxFit.fill)
                            ),
                            child: Text('')));
                  },
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
