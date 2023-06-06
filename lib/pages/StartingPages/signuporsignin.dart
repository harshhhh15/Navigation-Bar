import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:trynav/pages/StartingPages/signuppage.dart';

import 'loginpage.dart';

class signuporsignin extends StatefulWidget {
  final String value;

  signuporsignin({Key? key, required this.value}) : super(key: key);

  @override
  State<signuporsignin> createState() => _signuporsigninState();
}

class _signuporsigninState extends State<signuporsignin> {
  bool changebutton = false;
  bool changesignup = false;

  late String _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
              opacity: 0.1,
              child:
                  RiveAnimation.asset("assets/RiveAssets/harsh_animation.riv")),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
              child: SizedBox(),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 70),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "Join the community and unlock endless possibilities.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: Container(
                            height: 300,
                            child: Image.asset("assets/images/meeting.png")),
                      ),
                      Container(
                        height: 56,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            /*  await Future.delayed(Duration(milliseconds: 100));*/
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signup()));
                          },
                          child: Text("Sign up Now",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 20,
                                  color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        height: 56,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // do something
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => loginpage()));
                          },
                          child: Text("Login",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 20,
                                  color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
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
    );
  }
}
