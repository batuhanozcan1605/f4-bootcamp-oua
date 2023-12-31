import 'package:bootcamp_oua_f4/repositories/categories_repo.dart';
import 'package:bootcamp_oua_f4/repositories/imageurl_repo.dart';
import 'package:bootcamp_oua_f4/repositories/recipe_repo.dart';
import 'package:bootcamp_oua_f4/screens/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {

  /*void goToNavScreen() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const NavScreen()));
  }*/

  Future<List> fetchData (){
    return Future.wait([
    ref.read(categoriesProvider).fetchCategories(),
    ref.read(imageUrlProvider).fetchImageUrls(),
      Future.delayed(const Duration(seconds: 8)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: RiveAnimation.asset(
              'assets/images/anime.riv',
              fit: BoxFit.cover,
            ),);
          } else {
            return const NavScreen();
          }
        },
      ),
    );
  }
}
