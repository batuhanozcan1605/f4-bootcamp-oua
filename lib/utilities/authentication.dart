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

    print('Sign in error: $e');
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

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print('User signed out');
    } catch (e) {
      print('Sign out error: $e');
    }
  }


}