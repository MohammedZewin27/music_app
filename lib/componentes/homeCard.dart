import 'package:flutter/material.dart';

import '../generated/assets.dart';
import '../style/colors.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String image;
  final double height;

  const HomeCard({Key? key, required this.title, required this.image,this.height=0.10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          color: LABLECOLOR1,
          image: const DecorationImage(
              image: AssetImage(Assets.imageBacgroundMusic),
              fit: BoxFit.cover,
              opacity: 0.1),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: BUTTONCOLOR.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height * height,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.arrow_back_ios, size: 35, color: BUTTONCOLOR),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: BUTTONCOLOR,
                      fontSize: 45,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              Image.asset(image),
            ],
          ),
        ),
      ),
    );
  }
}
