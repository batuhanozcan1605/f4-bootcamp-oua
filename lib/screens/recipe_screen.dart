import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecipeSecreen extends StatefulWidget {
  const RecipeSecreen({Key? key}) : super(key: key);

  @override
  State<RecipeSecreen> createState() => _RecipeSecreenState();
}

class _RecipeSecreenState extends State<RecipeSecreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D818C),
        title: SvgPicture.asset('assets/images/appbar_logo.svg'),
        centerTitle: true,
      ),
      body: const Center(
      ),
    );
  }
}