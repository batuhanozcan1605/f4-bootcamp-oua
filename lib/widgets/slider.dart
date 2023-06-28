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
          height: Get.height / 40,
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
          height: 50,
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
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            description,
            style: TextStyle(
              fontFamily: 'VarelaRound',
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
