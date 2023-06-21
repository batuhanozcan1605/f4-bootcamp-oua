import 'package:bootcamp_oua_f4/models/CategoryModel.dart';
import 'package:bootcamp_oua_f4/screens/add/foods_screen.dart';
import 'package:flutter/material.dart';

class FoodsBodyScreen extends StatefulWidget {

  Category category;

  FoodsBodyScreen({super.key, required this.category});

  @override
  State<FoodsBodyScreen> createState() => _FoodsBodyScreenState();
}

class _FoodsBodyScreenState extends State<FoodsBodyScreen> with TickerProviderStateMixin {
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
            Tab(text: 'Meyveler'),
            Tab(text: 'Sebzeler'),
            Tab(text: 'Fırın'),
            Tab(text: 'Mandıra'),
            Tab(text: 'İçecekler'),
            Tab(text: 'Etler'),
            Tab(text: 'Atıştırmalıklar'),
            Tab(text: 'Alkollü İçecekler'),
            Tab(text: 'Çerezler'),
            Tab(text: 'Yağlar'),
            Tab(text: 'Deniz Ürünler'),
            Tab(text: 'Baklalar'),
            Tab(text: 'Baharatlar'),
            Tab(text: 'Soslar'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FoodsScreen(categoryId: 1),
          FoodsScreen(categoryId: 1),
          FoodsScreen(categoryId: 1),
          FoodsScreen(categoryId: 1),
          FoodsScreen(categoryId: 1),
          FoodsScreen(categoryId: 1),
          FoodsScreen(categoryId: 1),
          FoodsScreen(categoryId: 1),
          FoodsScreen(categoryId: 1),
          FoodsScreen(categoryId: 1),
          FoodsScreen(categoryId: 1),
          FoodsScreen(categoryId: 1),
          FoodsScreen(categoryId: 1),
          FoodsScreen(categoryId: 1),
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
                          print("test: pressed");

                        },
                        child: Text("Mutfağa Ekle")),
                  ),
                  SizedBox(
                    width: screenWidth * (17 / 36),
                    child: ElevatedButton(
                        onPressed: () async {
                          print("test: pressed");

                        },
                        child: Text("Alışveriş Listesine Ekle")),
                  )
                ],
              ),

      ),
    );
  }
}
