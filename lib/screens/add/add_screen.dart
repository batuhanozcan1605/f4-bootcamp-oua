import 'package:bootcamp_oua_f4/repositories/categories_repo.dart';
import 'package:bootcamp_oua_f4/repositories/foods_repo.dart';
import 'package:bootcamp_oua_f4/screens/add/add_custom_food.dart';
import 'package:bootcamp_oua_f4/services/data_service.dart';
import 'package:bootcamp_oua_f4/widgets/category_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'foods_bodyscreen.dart';

class AddSecreen extends ConsumerStatefulWidget {
  const AddSecreen({Key? key}) : super(key: key);

  @override
  AddSecreenState createState() => AddSecreenState();
}

class AddSecreenState extends ConsumerState<AddSecreen> {
  String query = '';
  bool isSearching = false;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  void _showSnackBar1(BuildContext context, document) {
    final snackBar = SnackBar(action: SnackBarAction(
        label: 'Undo',
        onPressed: (){
          DataService().undoAddToCart();
        }),
        content: Text("${document['name']} has been added to your Shopping Cart.",
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
        backgroundColor: const Color(0xFF013440),);
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  void _showSnackBar2(BuildContext context, document) {
    final snackBar = SnackBar(action: SnackBarAction(
        label: 'Undo',
        onPressed: (){
          DataService().undoAdd();
        }),
      content: Text("${document['name']} has been added to your Kitchen.",
        style: const TextStyle(
          color: Colors.white70,
        ),
      ),
      backgroundColor: const Color(0xFF013440),);
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final categoriesRepo = ref.watch(categoriesProvider);
    return WillPopScope(
      onWillPop: () async {
        if (isSearching) {
          return false;
        } else {
          return true;
        }
      },
      child: ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF4D818C),
            title: SvgPicture.asset('assets/images/appbar_logo.svg'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              searchBar(),
              isSearching
                  ? const Center()
                  : Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: SizedBox(
                        height: 80,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddCustomFood()));
                          },
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(children: [
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: SvgPicture.asset(
                                      'assets/images/icon_ekle.svg')),
                              const Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Add Custom Food',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 15,
                                          color: Color(0xff013440),
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Text('(First, check it from the search bar.)',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 10,
                                          color: Color(0xFF4D818C),
                                        )),
                                  ],
                                ),
                              )
                            ]),
                          ),
                        ),
                      ),
                    ),
              isSearching
                  ? searchFoodsWidget(query)
                  : Expanded(
                      child: GridView.builder(
                          padding: const EdgeInsets.all(20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 5 / 2),
                          itemCount: categoriesRepo.categories.length,
                          itemBuilder: (context, index) {
                            var category = categoriesRepo.categories[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FoodsBodyScreen(
                                              category: category,
                                            )));
                              },
                              child: categoryCard(category),
                            );
                          }),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar() => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x1a000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 6),
          child: TextField(
            decoration: InputDecoration(
              fillColor: const Color(0xFF4D818C),
              prefixIconColor: const Color(0xFF4D818C),
              prefixIcon: const Icon(Icons.search),
              suffix: isSearching
                  ? IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          isSearching = false;
                        });
                      },
                    )
                  : const Center(),
              hintText: 'Add Food',
            ),
            onTap: () {
              setState(() {
                isSearching = true;
              });
            },
            onChanged: (result) {
              setState(() {
                query = result;
              });
            },
          ),
        ),
      );

  Widget searchFoodsWidget(String query) {

    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('foods').orderBy('name').snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
            List<QueryDocumentSnapshot> filteredDocuments =
            snapshot.data!.docs.where((doc) {
              String searchText = query.toLowerCase();
              String fieldValue = doc['name'].toString().toLowerCase();
              return fieldValue.contains(searchText);
            }).toList();
            return ListView.builder(
                itemCount: filteredDocuments.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = filteredDocuments[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          document['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                DataService().addSingleFoodToCart(document.id);
                                _showSnackBar1(context, document);
                              },
                              icon: const Icon(
                                Icons.add_shopping_cart,
                                color: Color(0xFF4D818C),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                DataService().addSingleFoodToKitchen(document.id);
                               _showSnackBar2(context, document);
                              },
                              icon: const Icon(
                                Icons.add_circle,
                                color: Color(0xFF4D818C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  );
                });
            } else {
              return const Center();
            }
          }),
    );
  }
}
