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
          child: ContentBuilder(1, "Meyveler", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(2, "Sebzeler", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(3, "Fırın", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(4, "Mandıra", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(5, "İçecekler", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(6, "Etler", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(7, "Atıştırmalıklar", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(8, "Alkollü İçecekler", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(9, "Çerezler", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(10, "Yağlar", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(11, "Deniz Ürünleri", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(12, "Baklalar", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(13, "Baharatlar", "b"),
        ),
        SliverToBoxAdapter(
          child: ContentBuilder(14, "Soslar", "b"),
        ),
      ],
    );
  }
}