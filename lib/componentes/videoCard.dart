import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../constant/const.dart';
import '../model/model_video_youtube.dart';
import '../provider/providerDatabase.dart';
import '../style/colors.dart';

class VideoCard extends StatelessWidget {
  final String image;
  final String duration;
  final String title;
  final int index;


  const VideoCard(
      {super.key,
      required this.image,
      required this.duration,
      required this.title,
      required this.index,


      });

  @override
  Widget build(BuildContext context) {
    var proVideo=Provider.of<ProviderData>(context);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.transparent,
        child: Slidable(
          startActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    proVideo.deleteRowInDatabaseVideo(
                        id: allVideo[index]['id']);
                    proVideo.deleteFile(videos[index].filePath);
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'DELETE',
                  borderRadius: BorderRadius.circular(8),
                ),
              ]),
          child: SizedBox(
            height: 100,
            width: double.infinity,
            child: Row(
              children: [
               image.length>10? Image(
                  image: NetworkImage(image),
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                ):Container(
                 height: 100,
                 width: 100,
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
