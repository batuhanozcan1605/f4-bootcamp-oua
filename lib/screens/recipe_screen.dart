import 'dart:convert';
import 'package:bootcamp_oua_f4/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class RecipeScreen extends StatefulWidget {
    const RecipeScreen({Key? key}) : super(key: key);

    @override
    _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
    List<String> ingredients = [
        'tomato',
        'milk',
        "potato"
    ]; // Malzemeleri tutacak liste
    List<String> recipes = []; // Tarifleri tutacak liste

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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                            'Malzemeler:',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                            ),
                        ),
                        SizedBox(height: 8),
                        Container(
                            height: 80,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: ingredients.length,
                                itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Chip(
                                            label: Text(ingredients[index]),
                                        ),
                                    );
                                },
                            ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                            onPressed: fetchRecipes,
                            child: const Text('Tarifleri Bul'),
                        ),
                        SizedBox(height: 16),
                        Text(
                            'Tarifler:',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                            ),
                        ),
                        Expanded(
                            child: recipes.isEmpty
                                ? Center(
                                child: Text('Tarif bulunamadı.'),
                            )
                                : ListView.builder(

                                itemCount: recipes.length,
                                itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 7.0,bottom: 7.0),
                                      child: ListTile(

                                          visualDensity: const VisualDensity(vertical: 1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              side: BorderSide(width: 2, color: Constants.tPrimaryColor),
                                          ),
                                          leading: CircleAvatar(child: const Icon(Icons.menu_book, size: 18,color: Colors.white,), backgroundColor: kGoogleBlue,),
                                          title: Text(recipes[index], textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: 'VarelaRound',
                                                  fontSize: 20,
                                              ),),
                                          trailing:  IconButton(
                                              iconSize: 40,
                                              icon: const Icon(
                                                  Icons.arrow_right_sharp,
                                                  color: kGoogleBlue,
                                                  size: 40,
                                              ),
                                           onPressed: () { fetchRecipeDetails(recipes[index]); }),
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

    Future<void> fetchRecipes() async {
        final apiKey =
            'c09738cb0fe4473784dafda3b321f2dd'; // Spoonacular API anahtarını buraya ekleyin

        List<String> combinedIngredients = [];

        // Malzemeleri sırayla birbiriyle kombinasyon yaparak yeni bir liste oluştur
        for (int i = 0; i < ingredients.length; i++) {
            for (int j = i + 1; j < ingredients.length; j++) {
                combinedIngredients.add('${ingredients[i]},${ingredients[j]}');
            }
        }

        List<String> newRecipes = [];

        // Kombine edilmiş malzemelerle sorguları yap ve tarifleri al
        for (int i = 0; i < combinedIngredients.length; i++) {
            final url = Uri.parse(
                'https://api.spoonacular.com/recipes/findByIngredients?apiKey=$apiKey&ingredients=${combinedIngredients[i]}&number=5');
            final response = await http.get(url);

            if (response.statusCode == 200) {
                final List<dynamic> data = jsonDecode(response.body);

                final List<String> recipes =
                data.map<String>((recipe) => recipe['title'] as String).toList();

                newRecipes.addAll(recipes);
            } else {
                throw ('Tarifler alınırken bir hata oluştu');
            }
        }

        setState(() {
            recipes = newRecipes;
        });
    }

    Future<void> fetchRecipeDetails(String recipeTitle) async {
        final apiKey =
            '4644d9a5b8133608bbbbd0deefe949e77014aee240970af20c2c72e9e4f79c93'; // SerpApi API anahtarını buraya ekleyin

        final url = Uri.parse(
            'https://serpapi.com/search?q=$recipeTitle&hl=tr&gl=tr&api_key=$apiKey');
        final response = await http.get(url);

        if (response.statusCode == 200) {
            final Map<String, dynamic> data = jsonDecode(response.body);

            if (data.isEmpty ||
                data['organic_results'] == null ||
                data['organic_results'].isEmpty) {
                throw Exception('Tarif detayları bulunamadı');
            }

            final recipeDetails = data['organic_results'][0];
            final recipeImage = recipeDetails['thumbnail'];
            final recipeLink = recipeDetails['link'];

            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    contentPadding: EdgeInsets.only(top: 10.0),
                    elevation: 40.0,
                    title: Text(recipeTitle, textAlign: TextAlign.center,style: TextStyle(
                        fontFamily: 'VarelaRound',
                        color: Colors.grey,
                        fontSize: 20,
                    ),),

                    content: SingleChildScrollView(

                        child: Column(

                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                if (recipeImage != null)
                                    ClipOval(
                                      child: SizedBox.fromSize(
                                          size: Size.fromRadius(80),
                                        child: Image.network(
                                            recipeImage,
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                SizedBox(height: 10),
                                Text('Recipe:' , style: TextStyle(
                                fontFamily: 'VarelaRound',
                                color: Colors.grey,
                                fontSize: 17,
                                ),),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(recipeDetails['snippet'], textAlign: TextAlign.center,),
                                ),
                            ],
                        ),
                    ),
                    actions: [
                        TextButton(
                            onPressed: () {
                                Navigator.pop(context);
                            },
                            child: Text('Close'),
                        ),
                        TextButton(
                            onPressed: () {
                                // Open the recipe link in the browser
                                launch(recipeLink);
                            },
                            child: Text('Link'),
                        ),
                        /*ElevatedButton(
                            onPressed: () {
                                // Open the recipe link in the browser
                                launch(recipeLink);
                            },
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                    Text('Link'), // <-- Text
                                    SizedBox(
                                        width: 5,
                                    ),
                                    Icon( // <-- Icon
                                        Icons.link,
                                        size: 24.0,
                                    ),
                                ],
                            ),
                        ),*/
                    ],
                ),
            );
        } else {
            throw Exception('Tarif detayları alınırken bir hata oluştu');
        }
    }
}
