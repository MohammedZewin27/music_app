import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:media_z/generated/assets.dart';
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
  final double? height;
  final int? maxLines;

  final double padding;
  final Function(BuildContext)? delete;

  const VideoCard({
    super.key,
    required this.image,
    required this.duration,
    required this.title,
    required this.index,
    required this.delete,
    this.height = 100,
    this.maxLines = 2,
    this.padding = 2,
  });

  @override
  Widget build(BuildContext context) {
    var proAudio = Provider.of<ProviderData>(context);
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.transparent,
        child: Slidable(
          startActionPane: ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(
              onPressed: delete,
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'DELETE',
              borderRadius: BorderRadius.circular(8),
            ),
          ]),
          child: SizedBox(
            height: height,
            width: double.infinity,
            child: Row(
              children: [
               Image(
                        image: NetworkImage(image),
                        height: height,
                        width: height,
                        fit: BoxFit.fill,
                      ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: maxLines,
                        textAlign: TextAlign.end,
                      ),
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
