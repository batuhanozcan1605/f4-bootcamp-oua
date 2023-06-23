import 'package:bootcamp_oua_f4/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../constants/constants.dart';
import '../widgets/slider.dart';
import 'login_screen.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<LandingPage> {
  int _currentPage = 0;
  PageController _controller = PageController();
  final GlobalKey<SlideActionState> _key = GlobalKey();

  // ignore: prefer_final_fields
  List<Widget> _pages = [
    SliderPage(
      description: 'Welcome to the Kitchen in your pocket!',
      image: "assets/images/1.jpg",
      title: 'Kitchen in Pocket!',
    ),
    SliderPage(
      description: 'Receive alerts when your products are set to expire',
      image: "assets/images/3.jpg",
      title: 'More Saving, Less Wastage',
    ),
    SliderPage(
      description: 'Get recipe ideas based on what\'s already in your kitchen',
      image: "assets/images/2.1.jpg",
      title: 'More Variety, Less Work!',
    ),
  ];

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Stack(
          children: <Widget>[
            PageView.builder(
              scrollDirection: Axis.horizontal,
              onPageChanged: _onchanged,
              controller: _controller,
              itemCount: _pages.length,
              itemBuilder: (context, int index) {
                return _pages[index];
              },
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    _pages.length,
                        (int index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 5,
                        width: (index == _currentPage) ? 20 : 10,
                        margin:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: (index == _currentPage)
                              ? kGoogleBlue
                              : kGoogleBlue.withOpacity(0.5),
                        ),
                      );
                    },
                  ),
                ),
                Spacer(),
                Container(
                  child: (_currentPage == (_pages.length - 1))
                      ? Padding(
                    padding: const EdgeInsets.only(
                        top: 64, right: 32, left: 32),
                    child: SlideAction(
                      animationDuration: Duration(milliseconds: 900),
                      submittedIcon: Icon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                      ),
                      text: 'Let\'s get start',
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'VarelaRound',
                        fontSize: 18,
                      ),
                      elevation: 1,
                      sliderButtonIcon: FaIcon(
                        Icons.arrow_forward,
                        size: 22,
                        color: Color(0xFF4D818C),
                      ),
                      sliderButtonIconPadding: 10,
                      outerColor: Color(0xFF4D818C).withOpacity(0.8),
                      sliderButtonIconSize: 14,
                      height: 50,
                      key: _key,
                      onSubmit: () {
                        Get.off(LoginPage());
                      },
                    ),
                  )
                      : IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      size: 30,
                      color: Color(0xFF4D818C),
                    ),
                    onPressed: () {
                      _controller.nextPage(
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeInOutQuint);
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
