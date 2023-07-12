import 'package:bootcamp_oua_f4/constants/constants.dart';
import 'package:bootcamp_oua_f4/repositories/foods_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future <void> signOutWithGoogle() async {
  final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.isAnonymous) {
      await FirebaseAuth.instance.signOut();
      await user.delete();
    }


  await FirebaseAuth.instance.signOut();
  final googleSignIn = GoogleSignIn();
  await googleSignIn.signOut();

}
