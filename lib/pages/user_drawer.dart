import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:trynav/pages/Profile/more.dart';
import 'package:trynav/pages/StartingPages/signuporsignin.dart';
import 'package:trynav/pages/homepage/About_page_user.dart';
import 'package:trynav/pages/user_settings.dart';

import 'SchedulePage/FeedbackPage.dart';
import 'homepage/NavbarMain.dart';
import 'homepage/helpsupport_User.dart';

class user_drawer extends StatefulWidget {
  const user_drawer({Key? key}) : super(key: key);

  @override
  _user_drawerState createState() => _user_drawerState();
}

class _user_drawerState extends State<user_drawer> {
  final _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        controller: _drawerController,
        menuScreen: MenuScreen2(),
        mainScreen: mainnavbar(),
        borderRadius: 24.0,
        showShadow: true,
        angle: -12.0,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.easeInCirc,
      ),
    );
  }
}

class MenuScreen2 extends StatelessWidget {
  MenuScreen2({Key? key}) : super(key: key);
  File? _image;

  @override
  Widget build(BuildContext context) {
    final defaultImage = AssetImage("assets/images/default_profile_pic.png");
    return SafeArea(
      child: Container(
        color: Colors.deepPurple[400],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16, bottom: 16),
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : defaultImage as ImageProvider<Object>,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      textAlign: TextAlign.start,
                      "Harsh Mistry",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "harshmistry0007@gmail.com",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => morepage(id: "7")));
                },
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                final controller = ZoomDrawer.of(context);
                controller?.toggle();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => morepage(
                              id: '8',
                            )));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.white,
              ),
              title: Text(
                'About',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.white,
              ),
              title: Text(
                'Help',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HelpAndSupportPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.feedback,
                color: Colors.white,
              ),
              title: Text(
                'Feedback',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FeedbackPage()));
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Logout'),
                            content: Text('Are you sure you want to log out?'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              TextButton(
                                child: Text('Logout'),
                                onPressed: () {
                                  // perform logout operation here
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(Icons.check_circle,
                                              color: Colors.white),
                                          SizedBox(width: 10),
                                          Text('Logout Successful',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.all(10),
                                    ),
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => signuporsignin(
                                        value: '',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
