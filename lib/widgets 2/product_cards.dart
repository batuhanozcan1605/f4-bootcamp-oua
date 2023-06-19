import 'package:bootcamp_oua_f4/screens/kitchen_secreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductCard extends StatelessWidget {
  String name;
  Color backgroundColor;


  ProductCard(
      {required this.backgroundColor,
        required this.name,
        });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          color: backgroundColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Padding(
              padding: EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'VarelaRound',
                        color: Colors.blue,
                      ),
                      maxLines: 1,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KitchenSecreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
