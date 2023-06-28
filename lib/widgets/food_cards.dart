import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../services/data_service.dart';

Widget foodCard(food) => Card(
  margin: EdgeInsets.all(7),
  elevation: 5,
  clipBehavior: Clip.antiAlias,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
      child: Stack(
        clipBehavior: Clip.antiAlias,
        fit: StackFit.expand,
        children: [
          FutureBuilder<String>(
              future: DataService().getFoodImageUrl(food.image),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Constants.tPrimaryColor,
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  String imageUrl = snapshot.data ?? '';
                  return CachedNetworkImage(
                    fit: BoxFit.fitHeight,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageUrl: imageUrl);
                }
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 25,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                color: Colors.white,
              ),
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    food.name,
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 15,
                      color: Color(0xff013440),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
