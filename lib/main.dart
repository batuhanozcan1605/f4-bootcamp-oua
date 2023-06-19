import 'package:bootcamp_oua_f4/screens/nav_screen.dart';
import 'package:bootcamp_oua_f4/utilities/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: const SplashScreen(),
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

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
      goToNavScreen();
    }

  }

  void goToNavScreen() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const NavScreen()));
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

                  String uid = FirebaseAuth.instance.currentUser!.uid;

                  await FirebaseFirestore.instance.collection('users').doc(uid).set({
                    'girisYaptiMi' : true,
                    'sonGirisTarihi' : FieldValue.serverTimestamp(),
                  },
                    SetOptions(merge: true),
                  );

                  CollectionReference myKitchen = await FirebaseFirestore.instance.collection('users').doc(uid).collection('kitchen');
                  await myKitchen.doc('first doc').set({
                    'collection started' : true,
                  },
                  );

                  goToNavScreen();
                },
                child: const Text("Google Sign In")),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                  onPressed: () {
                    goToNavScreen();
                  },
                  child: Text("Giriş Yapmadan Devam Et")),
            ),
          ],
        )
            : const CircularProgressIndicator(),
      ),
    );
  }

}


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}