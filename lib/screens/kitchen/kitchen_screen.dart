import 'package:bootcamp_oua_f4/screens/kitchen/tabbar_screen.dart';
import 'package:bootcamp_oua_f4/utilities/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../main.dart';

class KitchenScreen extends StatefulWidget {
  const KitchenScreen({Key? key}) : super(key: key);

  @override
  State<KitchenScreen> createState() => _KitchenScreenState();
}


class _KitchenScreenState extends State<KitchenScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TabController = _tabController = TabController(length: 3, vsync: this),
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF4D818C),
            title: SvgPicture.asset('assets/images/appbar_logo.svg'),
            centerTitle: true,
            // geçici log out butonu
            actions: [
              IconButton(
                  onPressed: () async {
                    await signOutWithGoogle();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const FirebaseInitPhase()));
               }, icon: Icon(Icons.logout))
            ],
          ),
          body: const TabBarScreen(),
        ),
      ),
    );
  }
}
