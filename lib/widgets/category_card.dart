import 'package:flutter/material.dart';

Widget categoryCard(String category_name, category_image) => Card(
  clipBehavior: Clip.antiAlias,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  child: Stack(
    children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: SizedBox(
              width: 65,
              height: 56,
              child: Image.asset('images/kategoriler/${category_image}'))),
      Align(
        alignment: Alignment(0.509, 0.0),
        child: Text(
          category_name,
          style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 12,
            color: const Color(0xff013440),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          softWrap: false,
        ),
      ),
    ],
  ),
);