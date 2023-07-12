import 'package:bootcamp_oua_f4/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class AddCustomFood extends StatefulWidget {
  @override
  _AddCustomFoodState createState() => _AddCustomFoodState();
}

class _AddCustomFoodState extends State<AddCustomFood> {
  List<String> foodNames = [];
  String? selectedCategory;
  TextEditingController foodNameController = TextEditingController();
  int _defaultValue = 0;
  bool isSwitchOn = false;
  String? selectedStorageOption;
  DateTime? selectedExpireDate;
  late int categoryId;
  String formattedDate = '';


  @override
  void dispose() {
    foodNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['Fruits', 'Vegetables', 'Bakery', 'Dairy', 'Drinks', 'Meats', 'Snacks', 'Oils', 'Sea Food', 'Legumes', 'Spices', 'Sauces'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D818C),
        title: SvgPicture.asset('assets/images/appbar_logo.svg'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: Container(
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Image.network(
                        'https://5.imimg.com/data5/SELLER/Default/2022/12/EB/KL/FW/31012184/5d3f90b6-2353-4c4b-9cfd-5ca5c5775ff4-500x500.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 20,
                            child: TextFormField(
                              controller: foodNameController,
                              decoration: InputDecoration(
                                hintText: 'Food Name',
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Select Category:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: DropdownButton(
                              value: selectedCategory,
                              items: categories.map((String category) {
                                return DropdownMenuItem(
                                  value: categories.indexOf(category).toString(),
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedCategory = value as String;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Set an expiry date", style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold,)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(formattedDate, style: TextStyle(
                                  fontSize: 18,
                                color: Constants.tselectedItemColor,
                              ),),
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );
                              setState(() {
                                selectedExpireDate = selectedDate;
                                formattedDate = DateFormat('dd.MM.yy').format(selectedExpireDate!);
                              });
                        },
                            style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.teal),
                          ),
                        ),
                            child: const Text(
                              'SET DATE',
                              style: TextStyle(
                                color: Colors.teal,
                              ),
                            ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Where would you like to store the food?")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: 'b',
                          groupValue: selectedStorageOption,
                          onChanged: (String? value) {
                            setState(() {
                              selectedStorageOption = value;
                            });
                          },
                        ),
                        const Text('Fridge'),
                        Radio<String>(
                          value: 'k',
                          groupValue: selectedStorageOption,
                          onChanged: (String? value) {
                            setState(() {
                              selectedStorageOption = value;
                            });
                          },
                        ),
                        const Text('Pantry'),
                        Radio<String>(
                          value: 'd',
                          groupValue: selectedStorageOption,
                          onChanged: (String? value) {
                            setState(() {
                              selectedStorageOption = value;
                            });
                          },
                        ),
                        const Text('Freezer'),

                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: ElevatedButton(
          onPressed: () {
            addCustomFood();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Constants.tPrimaryColor,
          ),
          child: const Text('Add Custom Food'),
        ),
      ),
    );
  }

  Future<void> addCustomFood() async {
    if(selectedCategory == null) {
      return;
    }else{
    categoryId = int.parse(selectedCategory!) + 1;
    }

    Duration difference = selectedExpireDate!.difference(DateTime.now());


    Map<String, dynamic> data = {
      'categoryId' : categoryId,
      'name' : foodNameController.text,
      'enterDate' : FieldValue.serverTimestamp(),
      'newExpiryDate' : selectedExpireDate,
      'place' : selectedStorageOption,
      'image' : '$selectedCategory.png',
      'shelftime' : difference.inDays
    };
    Constants.kitchenRef.doc().set(data);
  }

}
