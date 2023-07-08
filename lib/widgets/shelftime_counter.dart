import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShelfTimeCounter extends StatelessWidget {
  const ShelfTimeCounter({Key? key, required this.food}) : super(key: key);
  final food;

  @override
  Widget build(BuildContext context) {

    int shelfTime = food['shelfTime'];
    Timestamp? timestamp = food['enterDate'];
    DateTime enterDate = timestamp!.toDate();
    DateTime expireDate = DateTime.now().add(Duration(days: shelfTime));
    Duration difference = expireDate.difference(enterDate);
    int dayCount = difference.inDays.abs();


    return Align(
      alignment: Alignment.topRight,
      child: FractionallySizedBox(
        widthFactor: 0.25,
        heightFactor: 0.25,
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xffff9f00),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(5.0),
            ),
          ),
          child: Center(
            child: Text(
              "${dayCount}d",
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 12,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              softWrap: false,
            ),
          ),
        ),
      ),
    ) ;
  }
}
