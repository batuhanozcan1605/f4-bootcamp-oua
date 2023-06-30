import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageTest extends StatefulWidget {
  const ImageTest({Key? key}) : super(key: key);

  @override
  State<ImageTest> createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<String>>(
          future: getImageUrls('categories/'),
          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                value: 0.7,
                backgroundColor: Colors.blue,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                strokeWidth: 6.0,
              );
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No images found');
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Adjust the number of columns as needed
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                String imageUrl = snapshot.data![index];
                return CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(
                    value: 0.7,
                    backgroundColor: Colors.blue,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    strokeWidth: 20.0,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                );
              },
            );
          },
        ),
      ),
    );
  }
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<List<String>> getImageUrls(String path) async {
    List<String> imageUrls = [];
    ListResult result = await storage.ref().child(path).listAll();

    for (Reference ref in result.items) {
      String url = await ref.getDownloadURL();
      imageUrls.add(url);
    }

    return imageUrls;
  }



}
