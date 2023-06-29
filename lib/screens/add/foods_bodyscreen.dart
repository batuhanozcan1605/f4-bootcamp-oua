import 'package:bootcamp_oua_f4/models/CategoryModel.dart';
import 'package:bootcamp_oua_f4/repositories/foods_repo.dart';
import 'package:bootcamp_oua_f4/screens/add/foods_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodsBodyScreen extends ConsumerStatefulWidget {

  Category category;

  FoodsBodyScreen({super.key, required this.category});

  @override
  FoodsBodyScreenState createState() => FoodsBodyScreenState();
}

class FoodsBodyScreenState extends ConsumerState<FoodsBodyScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: (widget.category.categoryId - 1),
        length: 12,
        vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4D818C),
        title: const Text('Foods'),
        centerTitle: true,
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Fruits'),
            Tab(text: 'Vegetables'),
            Tab(text: 'Bakery'),
            Tab(text: 'Dairy'),
            Tab(text: 'Drinks'),
            Tab(text: 'Meats'),
            Tab(text: 'Snacks'),
            Tab(text: 'Oils'),
            Tab(text: 'Sea Food'),
            Tab(text: 'Legumes'),
            Tab(text: 'Spices'),
            Tab(text: 'Sauces'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FoodsScreen(categoryId: 1),
          FoodsScreen(categoryId: 2),
          FoodsScreen(categoryId: 3),
          FoodsScreen(categoryId: 4),
          FoodsScreen(categoryId: 5),
          FoodsScreen(categoryId: 6),
          FoodsScreen(categoryId: 7),
          FoodsScreen(categoryId: 8),
          FoodsScreen(categoryId: 9),
          FoodsScreen(categoryId: 10),
          FoodsScreen(categoryId: 11),
          FoodsScreen(categoryId: 12),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: screenWidth * (17 / 36),
                    child: ElevatedButton(
                        onPressed: () async {
                          ref.read(foodsProvider).addBatchToKitchen();
                        },
                        child: const Text("Add to Kitchen")),
                  ),
                  SizedBox(
                    width: screenWidth * (17 / 36),
                    child: ElevatedButton(
                        onPressed: () async {
                          ref.read(foodsProvider).addBatchToCart();
                        },
                        child: const Text("Add To Shopping Cart")),
                  )
                ],
              ),

      ),
    );
  }
}
