import 'package:flutter/material.dart';
import 'package:media_z/screens/download_Screen/videoDownload.dart';

import '../../style/colors.dart';
import '../download_Screen/audioDownload.dart';

class AddVideo extends StatelessWidget {
  const AddVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var formkey = GlobalKey<FormState>();
    bool isBottomSheetShow = false;
    return  Padding(
      padding: const EdgeInsets.only(top: 5, left: 16, right: 16, bottom: 10),
      child: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 45,
                child: Text(
                  "Youtube Video",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 30, color: PREMIUMCOLOR),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const DownLoadVideo(),
            ],
          ),
        ),
      ),
    );
  }
}
