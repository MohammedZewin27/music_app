import 'package:card_swiper/card_swiper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:media_z/constant/const.dart';
import 'package:media_z/generated/assets.dart';
import 'package:media_z/screens/home_screen/radio/radioEgypt.dart';
import 'package:media_z/screens/home_screen/radio/radioScreen.dart';
import 'package:media_z/screens/home_screen/tv/tvHome.dart';
import '../video_screen/fullScreen.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        return Stack(
          children: [
            Image.asset(Assets.imageBack,fit: BoxFit.fill,width: double.infinity,),

            Scaffold(
              backgroundColor: Colors.transparent,
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
                              loop: true,
                              autoplay: true,
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
                              pagination:const RectSwiperPaginationBuilder(),
                              control: const SwiperControl(),
                              viewportFraction: 0.8,
                              scale: 0.9,
                              itemWidth: 300.0,
                              onTap: (index) {
                                indexVideo = index;
                                Navigator.pushNamed(context, FullScreen.routeName);
                              },
                              // layout: SwiperLayout.STACK,
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RadioScreen.routeName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: const DecorationImage(
                                      image: AssetImage(Assets.imageRadiolive),
                                      fit: BoxFit.cover)),
                              width: 100,
                              height: 100,
                            )),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, TvHome.routeName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: const DecorationImage(
                                      image: AssetImage(Assets.imageTv),
                                      fit: BoxFit.fill)),
                              width: 100,
                              height: 100,
                            )),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RadioEgypt.routeName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: const DecorationImage(
                                      image: AssetImage(Assets.imageRdimasr),
                                      fit: BoxFit.fill)),
                              width: 100,
                              height: 100,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
