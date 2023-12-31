import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<void> fetchRecipeDetails(String recipeTitle, context) async {
  final apiKey =
      'f94e3f44a4d7c1caf9fa227706e733c3b79936afd959079d93c7b1c1a798cfb1'; // SerpApi API anahtarı

  final url = Uri.parse(
      'https://serpapi.com/search?q=$recipeTitle&hl=tr&gl=tr&api_key=$apiKey');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);

    if (data.isEmpty ||
        data['organic_results'] == null ||
        data['organic_results'].isEmpty) {
      throw Exception('Tarif detayları bulunamadı');
    }

    final recipeDetails = data['organic_results'][0];
    final recipeImage = recipeDetails['thumbnail'];
    final recipeLink = recipeDetails['link'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade200,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        insetPadding: const EdgeInsets.all(30),
        elevation: 40.0,
        content: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: <Widget>[
              if (recipeImage == null)
                Positioned(
                  top: -100,
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(80),
                      child: Image.asset(
                        "8.jpg",
                        width: 150,
                        height: 150,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              if (recipeImage != null)
                Positioned(
                  top: -100,
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(80),
                      child: CachedNetworkImage(
                          imageUrl: recipeImage,
                          imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.red, BlendMode.colorBurn)),
                              ))),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Column(
                  children: [
                    Text(
                      recipeTitle.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'VarelaRound',
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Recipe:',
                      style: TextStyle(
                        fontFamily: 'VarelaRound',
                        color: Colors.black38,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      recipeDetails['snippet'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'VarelaRound',
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Close',
              style: TextStyle(fontSize: 20),
            ),
          ),
          TextButton(
            onPressed: () {
              launch(recipeLink);
              // Open the recipe link in the browser
            },
            child: const Text(
              'Go to Recipe',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  } else {
    throw Exception('Tarif detayları alınırken bir hata oluştu');
  }
}
