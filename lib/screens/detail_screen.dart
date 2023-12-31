import 'package:bootcamp_oua_f4/screens/kitchen/kitchen_screen.dart';
import 'package:bootcamp_oua_f4/services/data_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import '../constants/constants.dart';
import '../repositories/kitchen_state.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final food;
  final imageUrl;

  DetailScreen({
    required this.food,
    this.imageUrl,
  });

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends ConsumerState<DetailScreen> {
  bool switchUsed = false;
  DateTime nullDate = DateTime(0);
  late Timestamp? newTimestamp;
  late DocumentReference documentReference;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    setState(() {
      newTimestamp = widget.food['newExpiryDate'];
      documentReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('kitchen').doc(widget.food.id);
      switchUsed = widget.food['dontUseExpiryDate'] == false ? false : true;
    });

  }


  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(buttonTapProvider, (bool? previousState, bool newState) {
      setState(() {
      });
    });

    int shelfTime = widget.food['shelfTime'];
    Timestamp? timestamp = widget.food['enterDate'];

    DateTime enterDate = timestamp!.toDate();
    DateTime expireDate = DateTime.now().add(Duration(days: shelfTime));
    DateTime? newExpiryDate = newTimestamp != null ? newTimestamp!.toDate() : nullDate;

    Duration difference = expireDate.difference(enterDate);
    Duration newDifference = newExpiryDate != nullDate ? newExpiryDate.difference(enterDate) : const Duration(days: 0);

    int dayCount = newTimestamp == null ? difference.inDays : newDifference.inDays;
    String formattedDate = newTimestamp == null ? DateFormat('dd.MM.yy').format(expireDate) :
    DateFormat('dd.MM.yy').format(newExpiryDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D818C),
        title: const Text("Food Detail"),
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
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text('Do not use expiry date', style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.bold,)),
              ),
              Switch(
                value: switchUsed,
                activeColor: Constants.tPrimaryColor,
                onChanged: (bool value) {
                  setState(() {
                    switchUsed = value;
                  });
                },
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: switchUsed == false ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Expiry date',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                         Text(
                          '$dayCount days left',
                          style: const TextStyle(fontSize: 18, color: Colors.green),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          ' $formattedDate',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    await pickDateAndSave();
                    final kitchenState = ref.watch(buttonTapProvider.notifier);
                    kitchenState.setButtonTap();

                  },
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
                      'Edit and Save',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
              ],
            ) : const Center(),
          ),
          const SizedBox(height: 20),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Text(
                'Added to Kitchen in',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              DateFormat('dd.MM.yy').format(enterDate),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
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
                    onPressed: ()  {
                        saveDetails();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                          const KitchenScreen(),
                        ),
                      );

                    },
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
  Future<void> pickDateAndSave() async {

    // Show date picker
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      await documentReference.update({'newExpiryDate': selectedDate});
      final snackBar = SnackBar(
        action: SnackBarAction(
            label: 'Refresh',
            onPressed: ()  async {
              final doc = await documentReference.get();
              setState(() {
                newTimestamp = doc['newExpiryDate'];
              });
            }),
        content: const Text("Expiry date updated.",
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        backgroundColor: const Color(0xFF013440),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> saveDetails() async {
      await documentReference.update({'dontUseExpiryDate': switchUsed});

  }
}
