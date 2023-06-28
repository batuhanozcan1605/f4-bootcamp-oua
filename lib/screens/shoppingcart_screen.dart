import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ShoppingCardScreen extends ConsumerWidget {
  const ShoppingCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D818C),
        title: SvgPicture.asset('assets/images/appbar_logo.svg'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text("My Shopping Cart",
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 18,
              color: Color(0xff013440),
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(),
          FutureBuilder<QuerySnapshot>(
            future: null,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var foods = snapshot.data!.docs;
                if (foods.isNotEmpty) {
                  return ListView.builder(
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot food = foods[index];

                        return Row(
                          children: [

                          ],
                        );
                      });
                } else {
                  return Center();
                }
            } else {
                return const Center(child: Text(""));
              }
            }),
        ],
      ),
    );
  }
}
