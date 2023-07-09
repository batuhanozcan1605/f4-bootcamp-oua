import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DateRepo extends ChangeNotifier {

Map<String, DateTime> newDates = {};

void updateImageUrl(DateTime newDate, String name) {
  newDates[name] = newDate;
  notifyListeners();
}

Future<void> fetchNewDate() async {
  try{

      } catch(e) {

  }
  //notifyListeners();
}
}
