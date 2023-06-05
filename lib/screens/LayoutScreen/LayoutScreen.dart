import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:new_music/componentes/openYouTubeScreen.dart';
import 'package:provider/provider.dart';

import '../../../generated/assets.dart';
import '../../../provider/provider.dart';
import '../../provider/providerDatabase.dart';



class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);
  static const String routeName = 'Layout';

  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderData>(context);
    var provider = Provider.of<MyProvider>(context);
    var appLocal = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(Assets.iconLeading, color: Colors.white),
        title: Text(provider.textTitle[provider.indexScreen],),
        actions: [
          IconButton(onPressed: ()async{
            if(provider.indexScreen==0) await FirebaseAuth.instance.signOut();
            if(provider.indexScreen==1) await FirebaseAuth.instance.signOut();
            if(provider.indexScreen==2) await FirebaseAuth.instance.signOut();
            if(provider.indexScreen==3) {
              await Navigator.pushNamed(context, OpenYouTube.routeName);
            }
          }, icon: provider.icons[provider.indexScreen]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.indexScreen,
        onTap: (index) {
          provider.changeCurrent(index);
        },
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: appLocal.home),
          BottomNavigationBarItem(
              icon: const Icon(Icons.library_music_outlined),
              activeIcon: const Icon(Icons.library_music),
              label: appLocal.music),
          BottomNavigationBarItem(
              icon: const Icon(Icons.video_collection_outlined),
              activeIcon: const Icon(Icons.video_collection),
              label: appLocal.video),
          BottomNavigationBarItem(
              icon: const Icon(Icons.perm_identity),
              activeIcon: const Icon(Icons.person),
              label: appLocal.setting),
        ],
      ),
      body: provider.screens[provider.indexScreen],
    );
  }
}
