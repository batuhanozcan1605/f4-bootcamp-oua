
import 'package:bootcamp_oua_f4/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../constants/constants.dart';
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
        toolbarHeight: 40,
        backgroundColor: Color(0xFF4D818C),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Sign up',
                    style: TextStyle(
                      fontFamily: 'VarelaRound',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Create an Account',
                    style: TextStyle(
                      fontFamily: 'VarelaRound',
                      color: Color(0xff7a7a7a),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomFormField(
              lines: 1,
              type: TextInputType.name,
              icon: Icons.person,
              hint: 'Name',
              obscureText: false,
              onChanged: (input) {
                registerController.name = input;
                print(registerController.name);
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomFormField(
              lines: 1,
              type: TextInputType.emailAddress,
              icon: Icons.person,
              hint: 'Surname',
              obscureText: false,
              onChanged: (input) {
                registerController.surname = input;
              },
            ),
            SizedBox(
              height: 10,
            ),
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
                            fontSize: 13),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Terms',
                              style: TextStyle(
                                  color: kGoogleBlue,
                                  fontFamily: 'VarelaRound',
                                  fontSize: 13),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return AlertDialog(
                                          title: Text('Legal Consent'),
                                          content: Column(
                                            children: [
                                              Text(
                                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras rhoncus, orci id lobortis auctor, ante magna semper odio, sed pulvinar nisi turpis eget sem. Morbi porttitor aliquam metus, ut feugiat ipsum aliquet vitae. Interdum et malesuada fames ac ante ipsum primis in faucibus. Etiam pretium justo vitae lorem dictum, ut feugiat mi convallis. Mauris dui nisi, imperdiet vel odio id, porttitor mattis justo. Duis dapibus lorem enim. Donec placerat, enim nec pulvinar faucibus, dui ex suscipit dui, id consectetur eros orci id mauris. Nulla ac tincidunt magna, vel egestas tortor. Suspendisse dictum mauris id consequat feugiat. Aenean eu libero sit amet risus facilisis ultricies. Aenean dictum ex mauris, vitae congue magna sagittis sed. Integer sodales auctor molestie. Aliquam non eros nisi. Ut accumsan id ante id finibus.'),
                                            ],
                                          ),
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
                onTap: (finish) {
                  Get.off(SplashScreen());
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
            SizedBox(
              height: 30,
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

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
