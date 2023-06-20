import 'package:bootcamp_oua_f4/models/CategoryModel.dart';
import 'package:bootcamp_oua_f4/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'foods_bodyscreen.dart';

class AddSecreen extends StatefulWidget {
  const AddSecreen({Key? key}) : super(key: key);

  @override
  State<AddSecreen> createState() => _AddSecreenState();
}

class _AddSecreenState extends State<AddSecreen> {

  String query = '';
  bool isSearching = false;
  List categories = [];

  showAllCategories() {

  }


  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(isSearching) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF4D818C),
          title: SvgPicture.asset('assets/images/appbar_logo.svg'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            searchBar(),
            isSearching ? const Center() : Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: SizedBox(
                height: 80,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: SvgPicture.asset('assets/images/icon_ekle.svg')),
                         Align(
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
                                  )
                              ),
                              Text('(First, check it from the search bar.)',
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 10,
                                    color: Color(0xFF4D818C),
                                  )
                              ),
                            ],
                          ),
                        )
                      ]
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Category>>(
                  future: showAllCategories(), //firebase method
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var categoryList = snapshot.data;
                      return GridView.builder(
                          padding: const EdgeInsets.all(20),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 5 / 2),
                          itemCount: categoryList!.length,
                          itemBuilder: (context, index) {
                            var category = categoryList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FoodsBodyScreen(
                                          category: category,
                                        )));
                              },
                              child: categoryCard(category.category_name, category.category_image),
                            );
                          });
                    } else {
                      return const Center(child: Text(""));
                    }
                  }),
            ),

          ],
        ),

      ),
    );

  }

  Widget searchBar() => Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: const Color(0x1a000000),
          offset: Offset(0, 3),
          blurRadius: 6,
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 6),
      child: TextField(
        decoration: InputDecoration(
          fillColor: Color(0xFF4D818C),
          prefixIconColor: Color(0xFF4D818C),
          prefixIcon: const Icon(Icons.search),
          suffix: isSearching ? IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: (){
              setState(() {
                isSearching = false;
              });
            },
          ) : const Center(),
          hintText: 'Add Food',
        ),
        onTap: (){
          setState(() {
            isSearching = true;
          });
        },
        onChanged: (result){
          setState(() {
            query = result;
            print(result);
          });
        },
      ),
    ),
  );



}