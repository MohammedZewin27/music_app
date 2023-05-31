import 'package:flutter/material.dart';
import 'package:new_music/componentes/homeCard.dart';
import 'package:new_music/generated/assets.dart';
import 'package:new_music/style/colors.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome Back ,',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const HomeCard(title: 'video',image: Assets.iconVideoIcon),
            const HomeCard(title: 'music',image: Assets.iconMusicIconCard,)

          ],
        ),
      ),
    );
  }
}
