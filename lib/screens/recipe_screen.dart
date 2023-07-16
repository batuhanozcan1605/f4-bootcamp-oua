import 'package:bootcamp_oua_f4/constants/constants.dart';
import 'package:bootcamp_oua_f4/repositories/recipe_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/recipe_details.dart';

class RecipeScreen extends ConsumerStatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  RecipeScreenState createState() => RecipeScreenState();
}

class RecipeScreenState extends ConsumerState<RecipeScreen> {

  //List<String> ingredients = [ ]; // Malzemeleri tutacak liste
  //List<String> recipes = []; // Tarifleri tutacak liste
  @override
  void initState() {
    super.initState();
    ref.read(recipeProvider).fetchRecipes();
  }


  @override
  Widget build(BuildContext context) {
    final recipeRepo = ref.watch(recipeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D818C),
        title: SvgPicture.asset('assets/images/appbar_logo.svg'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recipes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(onPressed: (){
                  setState(() {

                  });
                }, icon: Icon(Icons.refresh)),
              ],
            ),
            SizedBox(height: 12,),
            Expanded(
              child: recipeRepo.recipeTitles.isEmpty
                  ? Center(
                      child: Text('Recipes are Loading...'),
                    )
                  : ListView.builder(
                            itemCount: recipeRepo.recipeTitles.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 7.0, bottom: 7.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 10,
                                  shadowColor: Colors.black,
                                  child: ListTile(
                                    tileColor: Colors.grey.shade100,
                                    selectedTileColor:
                                        kGoogleBlue.withOpacity(0.5),
                                    visualDensity:
                                        const VisualDensity(vertical: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Container(
                                        height: 40.0,
                                        width: 40.0,
                                        color: kGoogleBlue,
                                        child: const Icon(
                                          Icons.restaurant_outlined,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      recipeRepo.recipeTitles[index]
                                          .toUpperCase(),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontFamily: 'VarelaRound',
                                        //fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    onTap: () {
                                      fetchRecipeDetails(
                                          recipeRepo.recipeTitles[index],
                                      context
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),

                      ),
          ],
        ),
      ),
    );
  }



}
