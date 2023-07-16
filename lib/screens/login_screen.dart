
import 'package:bootcamp_oua_f4/screens/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../constants/constants.dart';
import '../widgets/custom_form_field.dart';
import 'nav_screen.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kGoogleBlue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: Get.height / 20,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/fridge.png',
                    height: Get.height / 7,
                    color: Colors.white,
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
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: <Widget>[
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
                          ],
                        ),
                        SizedBox(
                          height: 35,
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
                          height: 30,
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
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
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
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Color(0xff5f5e5e),
                                    height: 40,
                                  )),
                            ),
                            RichText(
                              text: TextSpan(
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
                                  child: Divider(
                                    color: Color(0xff5f5e5e),
                                    height: 40,
                                  )),
                            ),
                          ],
                        ),
                        Container(
                          height: 40,
                          width: 170,
                          child: MaterialButton(
                            color: Colors.white,
                            elevation: 10,
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 25.0,
                                  width: 25.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/google.png'),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Sign In with Google",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontFamily: 'VarelaRound',
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
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
                                      color: Colors.black,
                                      fontFamily: 'VarelaRound',
                                      fontSize: 13),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
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

