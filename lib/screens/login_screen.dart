import 'dart:async';
import 'package:bootcamp_oua_f4/screens/register_screen.dart';
import 'package:bootcamp_oua_f4/splash_screen.dart';
import 'package:bootcamp_oua_f4/utilities/authentication.dart';
import 'package:bootcamp_oua_f4/utilities/google_sign_in.dart';
import 'package:bootcamp_oua_f4/widgets/sign_in_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nice_buttons/nice_buttons.dart';
import '../constants/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool isFirebaseInitialized = false;

class _LoginPageState extends State<LoginPage> {

  String email = '';
  String password = '';

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    setState(() {
      isFirebaseInitialized = true;
    });
    print("DEBUG: ${FirebaseAuth.instance.currentUser}");
    if (FirebaseAuth.instance.currentUser != null) {
      print("GİRDİ DEBUG: ${FirebaseAuth.instance.currentUser}");
      goToSplash();
    }
  }

  void goToSplash() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SplashScreen()));
  }

  void googleSignInButton() async {
    await signInWithGoogle();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(
      {
        'girisYaptiMi': true,
        'sonGirisTarihi': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('kitchen')
        .doc('first doc')
        .set({
      'collection started': true,
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('shoppingCart')
        .doc('first doc')
        .set({
      'collection started': true,
    });

    goToSplash();
  }

  Future<void> signInAnonymously() async {
    try {

      UserCredential userCredential =
      await FirebaseAuth.instance.signInAnonymously();
      // Handle the signed-in user
      User? user = userCredential.user;
      // Additional logic or navigation can be performed here
      print('Signed in anonymously: ${user!.uid}');
      goToSplash();
    } catch (e) {
      // Handle any errors that occur during the sign-in process
      print('Failed to sign in anonymously: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: isFirebaseInitialized
          ? Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kGoogleBlue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height / 15,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/fridge.png',
                    height: Get.height / 6,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Kitchen ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'VarelaRound',
                          fontSize: 23,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'In ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'VarelaRound',
                          fontSize: 23,
                          color: Color(0xff98d7d1),
                        ),
                      ),
                      Text(
                        'Pocket',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'VarelaRound',
                          fontSize: 23,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),


            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(

                      children: [
                        const SizedBox(height: 30,),
                        SignInForm(),
                        const SizedBox(height: 20,),
                        NiceButtons(
                          startColor: kGoogleBlue,
                          endColor: kGoogleBlue.withOpacity(0.4),
                          borderColor: Colors.teal.withOpacity(0.7),
                          height: 40,
                          stretch: false,
                          borderRadius: 8,
                          gradientOrientation: GradientOrientation.Horizontal,
                          onTap: (finish) async {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => RegisterPage()));
                          },
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: 'VarelaRound',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 20.0),
                                  child: const Divider(
                                    color: Color(0xff5f5e5e),
                                    height: 40,
                                  )),
                            ),
                            RichText(
                              text: const TextSpan(
                                text: 'OR',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'VarelaRound',
                                    fontSize: 13),
                              ),
                            ),
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 10.0),
                                  child: const Divider(
                                    color: Color(0xff5f5e5e),
                                    height: 40,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                          width: 190,
                          child: MaterialButton(
                            color: Colors.white,
                            elevation: 10,
                            onPressed: () {
                              googleSignInButton();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 25.0,
                                  width: 25.0,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/google.png'),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Flexible(
                                  child: Text(
                                    "Sign In with Google",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontFamily: 'VarelaRound',
                                        fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        GestureDetector(
                          onTap: () {
                            signInAnonymously();
                          },
                          child: RichText(
                            text: const TextSpan(
                                text: 'Skip',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kGoogleBlue,
                                    fontFamily: 'VarelaRound',
                                    fontSize: 17),

                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' to try app without Personalization',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'VarelaRound',
                                        fontSize: 16),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      )
          : const Center(child: CircularProgressIndicator()),

    );
  }
}

class CustomTextField extends StatelessWidget {
  late String hint;
  CustomTextField({required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.red,
      onChanged: (value) {},
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'VarelaRound',
          fontSize: 13,
        ),
      ),
    );
  }
}
