import 'package:bootcamp_oua_f4/repositories/categories_repo.dart';
import 'package:bootcamp_oua_f4/repositories/imageurl_repo.dart';
import 'package:bootcamp_oua_f4/screens/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {

  void goToNavScreen() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const NavScreen()));
  }

  Future<void> fetchData () async {

    await ref.read(categoriesProvider).fetchCategories();

    await ref.read(imageUrlProvider).fetchImageUrls();

    await Future.delayed(Duration(seconds: 3));
  }

  @override
  void initState() {
    super.initState();
    fetchData().whenComplete(() => goToNavScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Center(
              child: Text('Kitchen is Loading'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
