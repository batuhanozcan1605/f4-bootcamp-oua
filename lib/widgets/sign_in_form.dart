import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../constants/constants.dart';
import '../splash_screen.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      print('User signed in: ${user!.email}');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SplashScreen()));

    } catch (e) {
      _showErrorMessage("You have entered wrong e-mail or password");
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          // Email does not exist
          setState(() {
            _formKey.currentState?.validate();
          });
        } else if (e.code == 'wrong-password') {
          // Incorrect password
          setState(() {
            _formKey.currentState?.validate();
          });
        }
      } else {
        // Other non-authentication related error
        print('Sign in error: $e');
      }
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            controller: _emailController,
            autofocus: false,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'VarelaRound',
            ),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: kGoogleBlue),
              floatingLabelStyle: TextStyle(color: kGoogleBlue),
              focusColor: kGoogleBlue,
              prefixIcon: Icon(
                Icons.email,
                color: Colors.grey,
                size: 16,
              ),
              fillColor: kGoogleBlue,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.black26,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kGoogleBlue, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              hintText: 'E-mail',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            validator: _validateEmail,
          ),
          SizedBox(height: 16,),
          TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.name,
            obscureText: true,
            controller: _passwordController,
            autofocus: false,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'VarelaRound',
            ),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: kGoogleBlue),
              floatingLabelStyle: TextStyle(color: kGoogleBlue),
              focusColor: kGoogleBlue,
              prefixIcon: Icon(
                Icons.password,
                color: Colors.grey,
                size: 16,
              ),
              fillColor: kGoogleBlue,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.black26,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kGoogleBlue, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              hintText: 'Password*',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            validator: _validatePassword,
          ),
          SizedBox(height: 16.0),
          NiceButtons(
            startColor: kGoogleBlue,
            endColor: kGoogleBlue.withOpacity(0.4),
            borderColor: Colors.teal.withOpacity(0.7),
            height: 40,
            stretch: false,
            borderRadius: 8,
            gradientOrientation: GradientOrientation.Horizontal,
            onTap: (finish) async {
              if (_formKey.currentState?.validate() == true) {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                signInWithEmailAndPassword(email, password);
              }
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
        ],
      ),
    );
  }
}
