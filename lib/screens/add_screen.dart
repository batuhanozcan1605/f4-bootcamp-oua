import 'package:flutter/material.dart';
// ignore: camel_case_types
class addScreen extends StatelessWidget {
  const addScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.front_hand),
                SizedBox(width: 8),
                Text('Kitchen'),
              ],
            ),
          ),
    ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: SizedBox(
              height: 80,
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Image.asset('assets/images/icon_ekle.jpg')),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Kendine Özel Ürün Ekle',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 15,
                                  color: Color(0xff013440),
                                  fontWeight: FontWeight.w600,
                                )
                            ),
                            Text('(Öncelikle arama kısmından kontrol edin.)',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 10,
                                  color: Color(0xFF4D818C),
                                )
                            )
                          ],
                        ),
                      )
                    ]
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {

                    return Row(
                      children: [
                        _buildCard(index),
                        const SizedBox(width: 10),
                        if (index + 1 < 100) _buildCard(index + 1),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          )

        ],
      ),


    );
  }
}
Widget _buildCard(int index) {
  // Define variables for each product
  String imageUrl = '';
  String title = '';
  String subtitle = '';

  // Set different values for each product
  if (index == 0) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  } else if (index == 1) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }else if (index == 2) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }
  else if (index == 3) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }
  else if (index == 4) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }
  else if (index == 5) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }
  else if (index == 6) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }
  else if (index == 7) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }else if (index == 8) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }else if (index == 9) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }else if (index == 10) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }else if (index == 11) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }else if (index == 12) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }else if (index == 13) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }else if (index == 14) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }else if (index == 15) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }else if (index == 16) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }else if (index == 17) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }else if (index == 18) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }else if (index == 19) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }else if (index == 20) {
    imageUrl = 'assets/images/biftek.jpg';
    title = 'Biftek';
  }

  return Container(
    width: 160,
    child: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 15,
                    color: Color(0xff013440),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 10,
                    color: Color(0xFF4D818C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
