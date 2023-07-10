import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SliderPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  SliderPage({
    required this.description,
    required this.image,
    required this.title,
  });
  final GlobalKey<SlideActionState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: Get.height / 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              child: Image.asset(image),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'VarelaRound',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'VarelaRound',
              color: Colors.grey,
              fontSize: 17,
            ),
          ),
        ),
        SizedBox(
          height: 80,
        ),
      ],
    );
  }
}
