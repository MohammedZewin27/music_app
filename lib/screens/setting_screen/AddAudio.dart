import 'package:flutter/material.dart';

import '../../style/colors.dart';
import '../download_Screen/audioDownload.dart';

class AddAudio extends StatelessWidget {
  static const String routeName = "AddAudio";

  final titleController = TextEditingController();
  final massageController = TextEditingController();

  AddAudio({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    return Padding(
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
                  "Youtube Audio",
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
              const AudioDownloader()
            ],
          ),
        ),
      ),
    );
  }
}
