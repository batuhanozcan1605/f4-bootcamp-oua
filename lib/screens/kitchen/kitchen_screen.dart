import 'package:bootcamp_oua_f4/repositories/foods_repo.dart';
import 'package:bootcamp_oua_f4/repositories/kitchen_state.dart';
import 'package:bootcamp_oua_f4/screens/kitchen/tabbar_screen.dart';
import 'package:bootcamp_oua_f4/utilities/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../main.dart';

class KitchenScreen extends ConsumerStatefulWidget {
  const KitchenScreen({Key? key}) : super(key: key);

  @override
  KitchenScreenState createState() => KitchenScreenState();
}


class KitchenScreenState extends ConsumerState<KitchenScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final foodsRepo = ref.watch(foodsProvider);
    final kitchenState = ref.watch(buttonTapProvider.notifier);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: foodsRepo.tapInKitchen ? AppBar(
              backgroundColor: Color(0xFF013440),
              title: Center(),
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                      onPressed: (){
                        ref.read(foodsProvider).cancelTapInKitchen();
                      },
                      icon: Icon(Icons.cancel_outlined));
                },
              ),
              actions: [
                IconButton(
                    onPressed: () async {
                      foodsRepo.tapInKitchen = false;
                      await foodsRepo.deleteBatchFromKitchen();
                      kitchenState.setButtonTap();
                    },
                    icon: Icon(
                      Icons.delete,
                    )),
                IconButton(
                    onPressed: (){

                    },
                    icon: Icon(
                      Icons.swap_horiz_rounded,
                    )),
              ],
          ) :
          AppBar(
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
