import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../user_drawer.dart';
import 'Admin_Drawer.dart';

class Admin_User extends StatefulWidget {
  const Admin_User({Key? key}) : super(key: key);

  @override
  State<Admin_User> createState() => _Admin_UserState();
}

class _Admin_UserState extends State<Admin_User> {
  bool changebutton = false;
  bool changesignup = false;

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
                        "Create checklists.\nConduct inspections.\nGenerate and share reports",
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
                        /* child: ElevatedButton(
                          onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Center(child: Text('Welcome Admin')),
                                backgroundColor:  Theme.of(context).primaryColor,
                                duration: Duration(seconds: 3),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    bottom: 16, left: 16, right: 16),
                              ),
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        signuporsignin(value: 'Admin')));
                          },
                          child: Text("As Admin",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 20,
                                  color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                          ),
                        ),*/
                        child: ElevatedButton(
                          onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Icon(Icons.check_circle,
                                        color: Colors.white),
                                    SizedBox(width: 10),
                                    Text('Welcome Admin',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                margin: EdgeInsets.all(10),
                              ),
                            );

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => admin_drawer()));
                          },
                          child: Text("As Admin",
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Icon(Icons.check_circle,
                                        color: Colors.white),
                                    SizedBox(width: 10),
                                    Text('Welcome User',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                margin: EdgeInsets.all(10),
                              ),
                            );

                            // do something
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        user_drawer())); /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signuporsignin(
                                          value: 'User',
                                        )));*/
                          },
                          child: Text("As User",
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
