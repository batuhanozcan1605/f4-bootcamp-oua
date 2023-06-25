import 'package:flutter/material.dart';

class ContentBuilder extends StatefulWidget {
  int categoryId;
  String categoryName;
  String place;

  ContentBuilder(this.categoryId, this.categoryName, this.place);

  @override
  State<ContentBuilder> createState() => _ContentBuilderState();
}

class _ContentBuilderState extends State<ContentBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 10),
          child: Text("",
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 15,
              color: const Color(0xff013440),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context,index){

            }
        ),
      ],
    );
  }
}
