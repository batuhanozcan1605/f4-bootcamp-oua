import 'package:flutter/material.dart';

Widget containerImage(ImageProvider<Object> imageProvider) => Container(
  width: 100,
  height: 100,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    image: DecorationImage(
      image: imageProvider,
      fit: BoxFit.cover,
    ),
  ),
  child: Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      child: Align(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "Milk",
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 12,
              color: Color(0xff013440),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      height: 25,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        color: Colors.white.withOpacity(0.7),
      ),
    ),
  ),
);