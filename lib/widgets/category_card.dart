import 'package:bootcamp_oua_f4/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/data_service.dart';

Widget categoryCard(category) => Card(
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
                  child: FutureBuilder<String>(
                      future:
                          DataService().getImageUrl(category.categoryImage),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              SpinKitWaveSpinner(
                                color: Colors.blueAccent,
                                size: 50.0,
                                //lineWidth: 2.0,
                              ),
                             // Icon(Icons.favorite, color: Colors.red),
                            ],
                          );

                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                        String imageUrl = snapshot.data ?? '';
                        return CachedNetworkImage(
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(
                                  value: 0.7,
                                  backgroundColor: Colors.blue,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                                  strokeWidth: 6.0,
                                ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            imageUrl: imageUrl);
                        }
                      }))),
          Align(
            alignment: Alignment(0.509, 0.0),
            child: Text(
              category.categoryName,
              style: const TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 12,
                color: Color(0xff013440),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
