import 'package:bootcamp_oua_f4/repositories/imageurl_repo.dart';
import 'package:bootcamp_oua_f4/screens/nav_screen.dart';
import 'package:bootcamp_oua_f4/splash_screen.dart';
import 'package:bootcamp_oua_f4/utilities/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'constants/constants.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'New App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const FirebaseInitPhase(),
    );
  }
}


class FirebaseInitPhase extends ConsumerStatefulWidget {
  const FirebaseInitPhase({Key? key}) : super(key: key);

  @override
  FirebaseInitPhaseState createState() => FirebaseInitPhaseState();
}

class FirebaseInitPhaseState extends ConsumerState<FirebaseInitPhase> {

  bool isFirebaseInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    setState(() {
      isFirebaseInitialized = true;
    });

    if(FirebaseAuth.instance.currentUser != null) {
      goToSplash();
    }

  }

  void goToSplash() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SplashScreen()));
  }

  Future<void> _signInAnonymously() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInAnonymously();
      // Handle the signed-in user
      User? user = userCredential.user;
      // Additional logic or navigation can be performed here
      print('Signed in anonymously: ${user!.uid}');
    } catch (e) {
      // Handle any errors that occur during the sign-in process
      print('Failed to sign in anonymously: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isFirebaseInitialized ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {

                  await signInWithGoogle();
                  final uid = FirebaseAuth.instance.currentUser!.uid;
                  await FirebaseFirestore.instance.collection('users').doc(uid).set({
                    'girisYaptiMi' : true,
                    'sonGirisTarihi' : FieldValue.serverTimestamp(),
                  },
                    SetOptions(merge: true),
                  );

                  await FirebaseFirestore.instance.collection('users').doc(uid).collection('kitchen').doc('first doc').set({
                    'collection started' : true,
                  });

                  await FirebaseFirestore.instance.collection('users').doc(uid).
                  collection('shoppingCart').doc('first doc').set({
                    'collection started' : true,
                  });

                  goToSplash();
                },
                child: const Text("Google Sign In")),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                  onPressed: () async {
                    await _signInAnonymously();
                    goToSplash();
                  },
                  child: const Text("Giriş Yapmadan Devam Et")),
            ),
          ],
        )
            : const CircularProgressIndicator(),
      ),
    );
  }

}


