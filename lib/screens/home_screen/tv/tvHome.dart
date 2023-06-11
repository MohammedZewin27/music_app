import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../componentes/categoryData.dart';
import '../../../provider/provider.dart';
import 'liveStream/live Stream.dart';

class TvHome extends StatelessWidget {
  const TvHome({super.key});
  static const String routeName='tvHome';

  @override
  Widget build(BuildContext context) {
    var categorys = CategoryData.getCategoryData();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: GridView.builder(
                  itemCount: categorys.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
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
                )),
          ],
        ),
      ),
    );
  }
}
