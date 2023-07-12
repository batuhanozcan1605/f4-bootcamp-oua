import 'dart:async';
import 'package:bootcamp_oua_f4/screens/register_screen.dart';
import 'package:bootcamp_oua_f4/splash_screen.dart';
import 'package:bootcamp_oua_f4/utilities/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../constants/constants.dart';
import '../widgets/custom_form_field.dart';
import 'nav_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool isFirebaseInitialized = false;

class _LoginPageState extends State<LoginPage> {
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

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: isFirebaseInitialized
            ? SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height / 5,
                    ),
                    Image.asset(
                      'assets/images/fridge.png',
                      width: 100,
                      height: 100,
                      color: kGoogleBlue,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Kitchen ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'VarelaRound',
                            fontSize: 23,
                            color: kGoogleBlue,
                          ),
                        ),
                        Text(
                          'In ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'VarelaRound',
                            fontSize: 23,
                            color: Colors.teal,
                          ),
                        ),
                        Text(
                          'Pocket',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'VarelaRound',
                            fontSize: 23,
                            color: kGoogleBlue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomFormField(
                        hint: 'Email',
                        lines: 1,
                        type: TextInputType.emailAddress,
                        obscureText: false,
                        onChanged: (input) {},
                        icon: FontAwesomeIcons.user),
                    CustomFormField(
                      hint: 'Password*',
                      lines: 1,
                      type: TextInputType.name,
                      obscureText: true,
                      onChanged: (input) {},
                      icon: Icons.password,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    NiceButtons(
                      startColor: kGoogleBlue,
                      endColor: kGoogleBlue.withOpacity(0.4),
                      borderColor: Colors.teal.withOpacity(0.7),
                      height: 40,
                      stretch: false,
                      borderRadius: 8,
                      gradientOrientation: GradientOrientation.Horizontal,
                      onTap: (finish) {
                        Get.off(NavScreen());
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'VarelaRound',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'Don\'t have an account yet?',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'VarelaRound',
                              fontSize: 13),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Create one.',
                                style: TextStyle(
                                    color: kGoogleBlue,
                                    fontFamily: 'VarelaRound',
                                    fontSize: 13),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage()),
                                      ))
                          ]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: new Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 20.0),
                              child: Divider(
                                color: Color(0xff5f5e5e),
                                height: 36,
                              )),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Or sign in with',
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
                              child: Divider(
                                color: Color(0xff5f5e5e),
                                height: 36,
                              )),
                        ),
                      ],
                    ),

                    /*Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/google.png',
                      height: 30,
                    ),
                  ],
                ),
              ),*/
                    Container(
                      height: 50,
                      width: 205,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
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
                                height: 30.0,
                                width: 30.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/google.png'),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Sign In with Google",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'VarelaRound',
                                    fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'Skip',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kGoogleBlue,
                              fontFamily: 'VarelaRound',
                              fontSize: 15),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NavScreen()),
                                ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' to try app without Personalization',
                              style: TextStyle(
                                  color: Color(0xff474646),
                                  fontFamily: 'VarelaRound',
                                  fontSize: 13),
                            )
                          ]),
                    ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
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
        hintStyle: TextStyle(
          fontFamily: 'VarelaRound',
          fontSize: 13,
        ),
      ),
    );
  }
}
