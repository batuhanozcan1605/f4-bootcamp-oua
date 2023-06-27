import 'package:flutter/material.dart';
import '../../widgets/content_builder.dart';

class FridgeScreen extends StatefulWidget {
  const FridgeScreen({Key? key}) : super(key: key);

  @override
  State<FridgeScreen> createState() => _FridgeScreenState();
}

class _FridgeScreenState extends State<FridgeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverToBoxAdapter(
          child: ContentBuilder(1, "Fruits", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(2, "Vegetables", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(3, "Bakery", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(4, "Dairy", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(5, "Drinks", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(6, "Meats", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(7, "Snacks", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(8, "Oils", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(9, "Sea Food", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(10, "Legumes", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(11, "Spices", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(12, "Sauces", "b"),
        ),
      ],
    );
  }
}