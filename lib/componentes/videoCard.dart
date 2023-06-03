import 'package:flutter/material.dart';
import '../model/model_video_youtube.dart';
import '../style/colors.dart';

class VideoCard extends StatelessWidget {
  final String image;
  final String duration;
  final String title;

  const VideoCard(
      {super.key,
      required this.image,
      required this.duration,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.transparent,
        child: SizedBox(
          height: 100,
          width: double.infinity,
          child: Expanded(
            child: Row(
              children: [
                Image(
                  image: NetworkImage(image),
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        textAlign: TextAlign.end,
                      ),
                      // SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                      // const Text('NAME'),
                      Row(
                        children: [
                          const Icon(Icons.play_arrow, size: 19),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            duration,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
