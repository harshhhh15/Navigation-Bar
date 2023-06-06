import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:trynav/pages/StartingPages/loginpage.dart';
import 'package:trynav/pages/StartingPages/signuppage.dart';

class tryanima extends StatefulWidget {
  const tryanima({Key? key}) : super(key: key);

  @override
  State<tryanima> createState() => _tryanimaState();
}

bool changebutton = false;
bool changesignup = false;

class _tryanimaState extends State<tryanima> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
              opacity: 0.3,
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
                        "Create checklists.\nConduct inspections.\nGenerate and share reports",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      Image.asset("assets/images/meeting.png"),
                      Material(
                        color: Colors.deepPurple,
                        borderRadius:
                            BorderRadius.circular(changesignup ? 50 : 14),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              if (changebutton = true) {
                                changebutton = false;
                              }
                              changesignup = true;
                            });
                            await Future.delayed(Duration(milliseconds: 350));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signup()));
                          },
                          onDoubleTap: () {
                            setState(() {
                              changesignup = false;
                            });
                          },
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: Duration(milliseconds: 300),
                            width: changesignup ? 56 : 400,
                            height: 56,
                            child: changesignup
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )
                                : Text("Sign up for free",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 1,
                                      fontSize: 20,
                                    )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Material(
                        color: Colors.deepPurple,
                        borderRadius:
                            BorderRadius.circular(changebutton ? 50 : 14),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              if (changesignup = true) {
                                changesignup = false;
                              }
                              changebutton = true;
                            });
                            await Future.delayed(Duration(milliseconds: 350));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => loginpage()));
                          },
                          onDoubleTap: () {
                            setState(() {
                              changebutton = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(
                                    changebutton ? 50 : 14)),
                            width: changebutton ? 56 : 400,
                            height: 56,
                            alignment: Alignment.center,
                            child: changebutton
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )
                                : Text("Login",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        fontSize: 20,
                                        color: Colors.white)),
                          ),
                        ),
                      )
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
