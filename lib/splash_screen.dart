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
    print('debug: FETCH 1');
    await ref.read(categoriesProvider).fetchCategories();
    print('debug: FETCH 2');
    await ref.read(imageUrlProvider).fetchImageUrls();
    print('debug: FETCH 3');
  }

  @override
  void initState() {
    super.initState();
    fetchData().whenComplete(() => goToNavScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
