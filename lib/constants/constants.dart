import 'package:flutter/material.dart';
const kGoogleBlue = Color(0xff426d77);

class Constants {
  //---COLOR---
  static final tPrimaryColor = Color(0xFF4D818C);
  static final tAppBarColor = Colors.teal;

  // bottom bar
  static final tselectedItemColor = Color(0xFF4D818C);
  static final tUnselectedItemColor = tPrimaryColor.withOpacity(0.5);

  //---TEXT---
  static const TextStyle CategoryTitle = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 15,
    color: Color(0xff013440),
    fontWeight: FontWeight.w600,
  );
  static const TextStyle ProductTitle = TextStyle(
    fontFamily: 'Segoe UI',
    fontSize: 12,
    color: Color(0xff013440),
    fontWeight: FontWeight.w600,
  );
}
