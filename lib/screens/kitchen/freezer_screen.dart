import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/content_builder.dart';

class FreezerScreen extends StatefulWidget {
  const FreezerScreen({Key? key}) : super(key: key);

  @override
  State<FreezerScreen> createState() => _FreezerScreenState();
}

class _FreezerScreenState extends State<FreezerScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverToBoxAdapter(
          child: ContentBuilder(1, "Fruits", "d"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(2, "Vegetables", "d"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(3, "Bakery", "d"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(4, "Dairy", "d"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(5, "Drinks", "d"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(6, "Meats", "d"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(7, "Snacks", "d"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(8, "Oils", "d"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(9, "Sea Food", "d"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(10, "Legumes", "d"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(11, "Spices", "d"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(12, "Sauces", "d"),
        ),
      ],
    );
  }
}
