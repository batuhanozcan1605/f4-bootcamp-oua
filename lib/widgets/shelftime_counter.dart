import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShelfTimeCounter extends StatelessWidget {
  const ShelfTimeCounter({Key? key, required this.food}) : super(key: key);
  final food;

  @override
  Widget build(BuildContext context) {
    DateTime nullDate = DateTime(0);

    int shelfTime = food['shelfTime'];
    Timestamp? timestamp = food['enterDate'];
    DateTime enterDate = timestamp!.toDate();
    DateTime expireDate = DateTime.now().add(Duration(days: shelfTime));
    Duration difference = expireDate.difference(enterDate);

    Timestamp? newTimestamp = food['newExpiryDate'];
    DateTime? newExpiryDate = newTimestamp != null ? newTimestamp.toDate() : nullDate;
    Duration newDifference = newExpiryDate != nullDate ? newExpiryDate.difference(enterDate) : const Duration(days: 0);

    int dayCount = newTimestamp == null ? difference.inDays : newDifference.inDays;

    return dayCount < 5 && food['place'] != 'd' && food['dontUseExpiryDate'] == false ? Align(
      alignment: Alignment.topRight,
      child: FractionallySizedBox(
        widthFactor: 0.25,
        heightFactor: 0.25,
        child: Container(
          decoration: BoxDecoration(
            color: dayCount <= 0 ? Colors.red : const Color(0xffff9f00),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(5.0),
            ),
          ),
          child: Center(
            child: Text(
              "${dayCount}d",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 12,
                color: Color(0xffffffff),
                fontWeight: FontWeight.w600,
              ),
              softWrap: false,
            ),
          ),
        ),
      ),
    ) : const Center();
  }
}
