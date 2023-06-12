import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:media_z/componentes/categoryRadio.dart';
import 'package:provider/provider.dart';

import '../../../generated/assets.dart';
import '../../../provider/providerMusic.dart';
import '../../../style/colors.dart';

class RadioEgypt extends StatefulWidget {
  const RadioEgypt({super.key});

  static const String routeName = 'RadioEgypt';

  @override
  State<RadioEgypt> createState() => _RadioEgyptState();
}

class _RadioEgyptState extends State<RadioEgypt> {
  late AudioPlayer player;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<CategoryRadio> radio = CategoryRadio.getCategoryData();
    var pro = Provider.of<ProviderMusic>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: AssetImage(radio[pro.indexRadioEgypt].image),
                  fit: BoxFit.fill,
                ),
                border: Border.all(color: LABLECOLOR, width: 5),
              ),
              width: MediaQuery.of(context).size.width * 0.40,
              height: MediaQuery.of(context).size.width * 0.40,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              radio[pro.indexRadioEgypt].title,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontSize: 30),
              maxLines: 2,
            ),
            SizedBox(
              height: 100,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: radio.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 8),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      var pro =
                          Provider.of<ProviderMusic>(context, listen: false);
                      pro.changeinexRadioEgypt(index);
                      await playMusic(radio[pro.indexRadioEgypt].id);
                      setState(() {});
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                                image: AssetImage(radio[index].image),
                                fit: BoxFit.fill)),
                        child: const Text('')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  playMusic(String radio) async {
    await player.play(DeviceFileSource(radio));
    print('index music ================================== ${radio}');
  }

  pauseMusic() async {
    await player.pause();
  }

  stopPlay() async {
    await player.stop();
  }
}
