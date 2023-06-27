import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/content_builder.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({Key? key}) : super(key: key);

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverToBoxAdapter(
          child: ContentBuilder(1, "Fruits", "k"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(2, "Vegetables", "k"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(3, "Bakery", "k"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(4, "Dairy", "k"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(5, "Drinks", "k"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(6, "Meats", "k"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(7, "Snacks", "k"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(8, "Oils", "k"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(9, "Sea Food", "k"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(10, "Legumes", "k"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(11, "Spices", "k"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(12, "Sauces", "k"),
        ),
      ],
    );
  }
}
