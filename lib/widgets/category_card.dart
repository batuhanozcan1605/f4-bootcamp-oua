import 'package:bootcamp_oua_f4/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
                          DataService().getImageUrl(category.category_image),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(strokeWidth: 2.0, color: Constants.tPrimaryColor,);
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                        String imageUrl = snapshot.data ?? '';
                        return CachedNetworkImage(
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            imageUrl: imageUrl);
                        }
                      }))),
          Align(
            alignment: Alignment(0.509, 0.0),
            child: Text(
              category.category_name,
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
