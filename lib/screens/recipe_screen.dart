import 'dart:convert';
import 'package:bootcamp_oua_f4/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  //3 adet ürün olacak
  List<String> ingredients = [

  ]; // Malzemeleri tutacak liste
  List<String> recipes = []; // Tarifleri tutacak liste
  @override
  void initState() {
    super.initState();
    Future.wait([
      fetchNames(),
      fetchRecipes(), // Tarifleri getiren fonksiyon
      Future.delayed(const Duration(seconds: 0)),
    ]);

  }

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
            SizedBox(height: 16),
            Text(
              'Recipes:',
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
                          padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 10,
                            shadowColor: Colors.black,
                            child: ListTile(
                              tileColor: Colors.grey.shade100,
                              selectedTileColor: kGoogleBlue.withOpacity(0.5),
                              visualDensity: const VisualDensity(vertical: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  height: 40.0,
                                  width: 40.0,
                                  child: const Icon(
                                    Icons.restaurant_outlined,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  color: kGoogleBlue,
                                ),
                              ),
                              title: Text(
                                recipes[index].toUpperCase(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'VarelaRound',
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              /*trailing: IconButton(
                                  iconSize: 40,
                                  icon: const Icon(
                                    Icons.arrow_right_sharp,
                                    color: kGoogleBlue,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    fetchRecipeDetails(recipes[index]);
                                  }),*/
                              onTap: () {
                                fetchRecipeDetails(recipes[index]);
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

  Future<void> fetchRecipes() async {
    final apiKey =
        '0444ff2bef2f4a949766be8b9b6343bc'; // Spoonacular API anahtarı

    List<String> combinedIngredients = [];

    // Malzemeleri sırayla birbiriyle kombinasyon yaparak yeni bir liste oluştur
    for (int i = 0; i < ingredients.length; i++) {
      for (int j = i + 1; j < ingredients.length; j++) {
        combinedIngredients.add('${ingredients[i]},${ingredients[j]}');
      }
    }
    var responseCount = combinedIngredients.length < 10 ? combinedIngredients.length : 10;
    List<String> newRecipes = [];


    // Kombine edilmiş malzemelerle sorguları yap ve tarifleri al
    for (int i = 0; i < responseCount; i++) {
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
    final screenHeight = MediaQuery.of(context).size.height;
    final apiKey =
        '4644d9a5b8133608bbbbd0deefe949e77014aee240970af20c2c72e9e4f79c93'; // SerpApi API anahtarı

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
          backgroundColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          insetPadding: EdgeInsets.all(30),
          elevation: 40.0,
          content: SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: <Widget>[
                if (recipeImage == null)
                  Positioned(
                    top: -100,
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(80),
                        child: Image.asset(
                          "8.jpg",
                          width: 150,
                          height: 150,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                if (recipeImage != null)
                  Positioned(
                    top: -100,
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(80),
                        child: Image.network(
                          recipeImage,
                          width: 150,
                          height: 150,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Column(
                    children: [
                      Text(
                        recipeTitle.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'VarelaRound',
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Recipe:',
                        style: TextStyle(
                          fontFamily: 'VarelaRound',
                          color: Colors.black38,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        recipeDetails['snippet'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'VarelaRound',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Close',
                style: TextStyle(fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {
                launch(recipeLink);
                // Open the recipe link in the browser
              },
              child: Text(
                'Link',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      );
    } else {
      throw Exception('Tarif detayları alınırken bir hata oluştu');
    }
  }

  Future<void> fetchNames() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try{
      FirebaseFirestore.instance.collection('users').doc(uid).collection('kitchen')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (DocumentSnapshot doc in querySnapshot.docs) {
        final foodName = doc['name'] as String;
        setState(() {
          ingredients.add(foodName);
        });
      }
    });
  } catch(e) {

    }
  }
}
