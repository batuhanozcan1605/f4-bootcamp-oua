// ignore_for_file: must_be_immutable

import 'package:bootcamp_oua_f4/services/data_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../constants/constants.dart';

import '../splash_screen.dart';
import '../utilities/authentication.dart';
import '../widgets/custom_form_field.dart';
import 'nav_screen.dart';

class RegisterController {
  late String name;
  late String surname;
  late String email;
  late String password;
  late String logInEmail;
  late String logInPassword;
}

class RegisterPage extends StatelessWidget {
  RegisterController registerController = RegisterController();
  bool agree = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          toolbarHeight: 50,
          backgroundColor: kGoogleBlue,
          leading: GestureDetector(
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 20,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          )),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: kGoogleBlue),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height / 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Sign up",
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create an account",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height / 30,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Column(
                          children: [
                            CustomFormField(
                              lines: 1,
                              type: TextInputType.emailAddress,
                              icon: Icons.mail,
                              hint: 'Email',
                              obscureText: false,
                              onChanged: (input) {
                                registerController.email = input;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomFormField(
                              lines: 1,
                              type: TextInputType.emailAddress,
                              icon: Icons.password_sharp,
                              hint: 'Password*',
                              obscureText: true,
                              onChanged: (input) {
                                registerController.password = input;
                              },
                            ),

                          ],
                        ),
                        SizedBox(
                          height: Get.height / 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'I have read and accept the ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'VarelaRound',
                                        fontSize: 15),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Terms',
                                          style: TextStyle(
                                              color: kGoogleBlue,
                                              fontFamily: 'VarelaRound',
                                              fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              showDialog(
                                                  context: context,
                                                  builder: ((context) {
                                                    return AlertDialog(
                                                      backgroundColor: Colors.grey.shade200,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                                      //contentPadding: EdgeInsets.only(top: 20.0, bottom: 25),
                                                      insetPadding: EdgeInsets.all(30),
                                                      elevation: 40.0,
                                                      title:
                                                      Text('Legal Consent', style: TextStyle(
                                                          decoration: TextDecoration.underline,
                                                          fontSize: 25),),
                                                      content: RichText(
                                                        text: TextSpan(
                                                          text: 'Ownership and Intellectual Property: All content on our website, including text, graphics, logos, images, and software, is the property of Kitchen in Pocket and is protected by intellectual property laws. You are prohibited from using, reproducing, distributing, or modifying any content without our prior written consent.',
                                                          style: TextStyle(color: Colors.black, fontSize: 18.0,),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: 'User Responsibilities: You are responsible for maintaining the confidentiality of any account credentials or passwords associated with our website. You agree not to engage in any unauthorized activities or interfere with the proper functioning of our website.',
                                                              style: TextStyle(color: Colors.black, fontSize: 18.0,),
                                                            ),
                                                          ],
                                                        ),
                                                      ),


                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text('Agree',style: TextStyle(fontSize: 20),),
                                                        ),

                                                      ],
                                                    );
                                                  }));
                                            }),
                                    ],
                                  ),
                                ),
                              ),
                              Checkbox(
                                side: BorderSide(
                                  width: 2,
                                  color: kGoogleBlue,
                                ),
                                value: true,
                                onChanged: (value) {},
                                activeColor: kGoogleBlue,
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: NiceButtons(
                            startColor: kGoogleBlue,
                            endColor: kGoogleBlue.withOpacity(0.4),
                            borderColor: Colors.teal.withOpacity(0.7),
                            height: 40,
                            stretch: false,
                            borderRadius: 30,
                            gradientOrientation: GradientOrientation.Horizontal,
                            onTap: (finish) async {
                              await registerWithEmailAndPassword(registerController.email, registerController.password);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => const SplashScreen()));
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: 'VarelaRound',
                              ),
                            ),
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
      ),
    );
  }

  TextStyle RegisterStyle() {
    return TextStyle(
        fontFamily: 'VarelaRound',
        fontSize: 12,
        color: kGoogleBlue.withOpacity(0.5));
  }

}
