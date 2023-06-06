import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:trynav/pages/StartingPages/signuporsignin.dart';
import 'package:trynav/pages/user_settings.dart';

import 'About_page_ADMIN.dart';
import 'Admin_Main.dart';
import 'Admin_More.dart';
import 'ReferApplication.dart';
import 'helpsupport_Admin.dart';

class admin_drawer extends StatefulWidget {
  const admin_drawer({Key? key}) : super(key: key);

  @override
  _admin_drawerState createState() => _admin_drawerState();
}

class _admin_drawerState extends State<admin_drawer> {
  final _drawerAdminController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        controller: _drawerAdminController,
        menuScreen: Admin_Drawer_Menu(),
        mainScreen: adminmain(),
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

class Admin_Drawer_Menu extends StatefulWidget {
  const Admin_Drawer_Menu({Key? key}) : super(key: key);

  @override
  State<Admin_Drawer_Menu> createState() => _Admin_Drawer_MenuState();
}

class _Admin_Drawer_MenuState extends State<Admin_Drawer_Menu> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    final defaultImage = AssetImage("assets/images/default_profile_pic.png");
    return SafeArea(
      child: Container(
        color: Colors.deepPurple[500],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Admin",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Admin@gmail.com",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Admin_more()));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Admin_more()));
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
                    MaterialPageRoute(builder: (context) => aboutpageadmin()));
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
                        builder: (context) => helpAndSupportForm()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.ios_share,
                color: Colors.white,
              ),
              title: Text(
                'Share',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReferScreen()));
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(Icons.check_circle,
                                              color: Colors.white),
                                          SizedBox(width: 10),
                                          Text('Admin logout Successfull',
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
                                  // perform logout operation here
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
