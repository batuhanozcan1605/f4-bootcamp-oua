import 'package:flutter/material.dart';

class Constants {
  //---COLOR---
  static final tPrimaryColor = Color(0xFF4D818C);
  static final tAppBarColor = Colors.teal;

  // bottom bar
  static final tselectedItemColor = Color(0xFF4D818C);
  static final tunselectedItemColor = tPrimaryColor.withOpacity(0.5);

  //---TEXT---
  static const textTheme = TextTheme(
    //Product Category Title
    headlineSmall: TextStyle(
      fontFamily: 'Segoe UI',
      fontSize: 15,
      color: Color(0xff013440),
      fontWeight: FontWeight.w600,
    ),
    //Product Name
    titleLarge: TextStyle(
      fontFamily: 'Segoe UI',
      fontSize: 12,
      color: Color(0xff013440),
      fontWeight: FontWeight.w600,
    ),
  );
}
