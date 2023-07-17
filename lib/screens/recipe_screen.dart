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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D818C),
        title: SvgPicture.asset('assets/images/appbar_logo.svg'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<void>(
          future: _fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  children: [
                    Text('Recipes are Loading...'),
                    SizedBox(height: 16,),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('An error occurred while fetching recipes.'),
              );
            } else {
              final recipeRepo = ref.watch(recipeProvider);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recipes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: const Icon(Icons.refresh),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Expanded(
                    child: recipeRepo.recipeTitles.isEmpty
                        ? const Center(
                      child: Column(
                        children: [
                          Text('No recipes available.'),
                        ],
                      ),
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
                                  fontSize: 18,
                                ),
                              ),
                              onTap: () {
                                fetchRecipeDetails(
                                  recipeRepo.recipeTitles[index],
                                  context,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _fetchData() async {
    final recipeRepo = ref.read(recipeProvider);
    await recipeRepo.fetchNames();
    await recipeRepo.fetchRecipes();
  }
}
