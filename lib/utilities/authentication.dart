import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
Future<void> signInWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;
    print('User signed in: ${user!.email}');
  } catch (e) {

    if (e is FirebaseAuthException) {
      if (e.code == 'user-not-found') {
        // Email does not exist
        print('User not found. Please check your email.');
      } else if (e.code == 'wrong-password') {
        // Incorrect password
        print('Incorrect password. Please try again.');
      }
    } else {
      // Other non-authentication related error
      print('Sign in error: $e');
    }
    return;
  }
  }

Future<void> registerWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // User successfully registered
    User? user = userCredential.user;
    print('User registered: ${user!.email}');
  } catch (e) {
    // Error occurred during registration
    print('Registration error: $e');
  }
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


}

Future<void> signOut() async {
  try {
    await _auth.signOut();
    print('User signed out');
  } catch (e) {
    print('Sign out error: $e');
  }
}