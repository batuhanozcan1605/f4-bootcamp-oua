import 'package:bootcamp_oua_f4/constants/constants.dart';
import 'package:flutter/material.dart';

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
  int? selectedStorageOption;

  @override
  void dispose() {
    foodNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['Category 1', 'Category 2', 'Category 3'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.tPrimaryColor,
        title: Container(
          padding: const EdgeInsets.all(30.0),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wallet),
              SizedBox(width: 5),
              Text(
                'cep mutfak',
                style: TextStyle(fontFamily: 'VarelaRound', fontSize: 16),
              ),
            ],
          ),
        ),
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
                        'https://nationaltoday.com/wp-content/uploads/2020/06/Soul-Food-1-1.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
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
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Expanded(
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
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedCategory = value as String?;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'Shelf Time',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              const Text('(Day)', style: Constants.CategoryTitle),
                              Switch(
                                value: isSwitchOn,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    isSwitchOn = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isSwitchOn,
                          child: Expanded(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (_defaultValue > 0) {
                                          _defaultValue--;
                                        }
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '$_defaultValue',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        _defaultValue++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Where would you like to store the food?")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<int>(
                          value: 0,
                          groupValue: selectedStorageOption,
                          onChanged: (int? value) {
                            setState(() {
                              selectedStorageOption = value;
                            });
                          },
                        ),
                        Text('Fridge'),
                        Radio<int>(
                          value: 1,
                          groupValue: selectedStorageOption,
                          onChanged: (int? value) {
                            setState(() {
                              selectedStorageOption = value;
                            });
                          },
                        ),
                        Text('Freezer'),
                        Radio<int>(
                          value: 2,
                          groupValue: selectedStorageOption,
                          onChanged: (int? value) {
                            setState(() {
                              selectedStorageOption = value;
                            });
                          },
                        ),
                        Text('Pantry'),
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
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Constants.tPrimaryColor,
          ),
          child: Text('Add Custom Food'),
        ),
      ),
    );
  }
}
