import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../../provider/provider.dart';
import '../../style/colors.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);
  static const String routeName = 'Layout';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading:Image.asset(Assets.iconLeading,color: Colors.white) ,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: provider.indexScreen,
        backgroundColor: PREMIUMCOLOR,
        buttonBackgroundColor: LABLECOLOR,
        color: BUTTONCOLOR,
        animationCurve: Curves.fastEaseInToSlowEaseOut,
        animationDuration: const Duration(milliseconds: 600),
        height: 55,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined),
          ),
          CurvedNavigationBarItem(
            child: Image(image: AssetImage(Assets.iconMusic,),color: Colors.black,),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.video_collection_outlined),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.perm_identity),
          ),
        ],
        onTap: (index) {
          provider.changeCurrent(index);
        },
      ),
      body: provider.screens[provider.indexScreen],
    );
  }
}
