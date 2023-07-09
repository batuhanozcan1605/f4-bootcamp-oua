import 'package:bootcamp_oua_f4/screens/kitchen/kitchen_screen.dart';
import 'package:bootcamp_oua_f4/services/data_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import '../constants/constants.dart';

class DetailScreen extends StatefulWidget {
  final food;
  final imageUrl;

  DetailScreen({
    required this.food,
    this.imageUrl,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool switchUsed = false;

  @override
  Widget build(BuildContext context) {
    int shelfTime = widget.food['shelfTime'];
    Timestamp? timestamp = widget.food['enterDate'];
    DateTime enterDate = timestamp!.toDate();
    DateTime expireDate = DateTime.now().add(Duration(days: shelfTime));
    Duration difference = expireDate.difference(enterDate);
    int dayCount = difference.inDays;
    String formattedDate = DateFormat('dd.MM.yy').format(expireDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D818C),
        title: Text("Food Detail"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 150,
              width: 150,
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: widget.imageUrl != null
                    ? CachedNetworkImage(
                        fit: BoxFit.fitHeight,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageUrl: widget.imageUrl)
                    : SpinKitRing(
                        color: Constants.tPrimaryColor,
                        size: 50.0,
                        lineWidth: 2.0,
                      ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.center,
            child: Text(
              widget.food['name'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text('Do not use expiry date', style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.bold,)),
              ),
              Switch(
                // This bool value toggles the switch.
                value: switchUsed,
                activeColor: Constants.tPrimaryColor,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    switchUsed = value;
                  });
                },
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Expire date',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '${dayCount} days left',
                          style: TextStyle(fontSize: 18, color: Colors.green),
                        ),
                        SizedBox(width: 10),
                        Text(
                          ' $formattedDate',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.teal),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('kilo'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      DataService().deleteFromDetails(widget.food.id);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const KitchenScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text('Delete Food'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
