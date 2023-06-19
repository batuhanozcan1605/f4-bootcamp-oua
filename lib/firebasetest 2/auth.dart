import 'package:bootcamp_oua_f4/firebasetest/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

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
      anaSayfayaGit();
    }
    // anaSayfayaGit();
  }

  void anaSayfayaGit() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()));
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
                    'hasSignedIn' : true,
                    'latestSignIn' : FieldValue.serverTimestamp(),
                  },
                    SetOptions(merge: true),
                  );
                  anaSayfayaGit();
                },
                child: const Text("Google Sign In")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    anaSayfayaGit();
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
