import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/ADMIN/updateprofileadmin.dart';
import 'package:trynav/pages/Profile/MyTeam.dart';

import '../StartingPages/signuporsignin.dart';
import 'ReferApplication.dart';

class Admin_more extends StatefulWidget {
  const Admin_more({Key? key}) : super(key: key);

  @override
  State<Admin_more> createState() => _Admin_moreState();
}

class _Admin_moreState extends State<Admin_more> {
  File? _image;
  final _formkey = GlobalKey<FormState>();

  late Database _account_database;
  List _account_formData = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final path = await getDatabasesPath();
    _account_database = await openDatabase(
      join(path, 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE _Signupdata_table(id INTEGER PRIMARY KEY, email TEXT, password TEXT, fname TEXT, lname TEXT)',
        );
      },
      version: 1,
    );
    final formData = await _account_database.query('_Signupdata_table');
    setState(() {
      _account_formData = formData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultImage = AssetImage("assets/images/default_profile_pic.png");
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              )),
          elevation: 1,
          backgroundColor: Colors.deepPurple,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Profile",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              /* Text(
                "Sync",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),*/
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => adminProfilePicturePage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Admin",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text("Admin@gmail.com"),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              child: Text(
                                "Free Account",
                                style: TextStyle(color: Colors.teal),
                              ),
                            )),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : defaultImage as ImageProvider<Object>,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade200,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                      primary: Colors.white,
                      onPrimary: Colors.purple.shade100,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => myteam()));
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.group_outlined,
                        size: 28,
                        color: Colors.black87,
                      ),
                    ),
                    label: Container(
                      width: double.infinity,
                      child: Text(
                        "My Team",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                      primary: Colors.white,
                      onPrimary: Colors.purple.shade100,
                    ),
                    onPressed: () {},
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.sensors_rounded,
                        size: 28,
                        color: Colors.black87,
                      ),
                    ),
                    label: Container(
                      width: double.infinity,
                      child: Text(
                        "Sensors",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                      primary: Colors.white,
                      onPrimary: Colors.purple.shade100,
                    ),
                    onPressed: () {},
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.local_library_outlined,
                        size: 28,
                        color: Colors.black87,
                      ),
                    ),
                    label: Container(
                      width: double.infinity,
                      child: Text(
                        "Public Library",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                      primary: Colors.white,
                      onPrimary: Colors.purple.shade100,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReferScreen()));
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.share_outlined,
                        size: 28,
                        color: Colors.black87,
                      ),
                    ),
                    label: Container(
                      width: double.infinity,
                      child: Text(
                        "Refer Security Culture",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                      primary: Colors.white,
                      onPrimary: Colors.purple.shade100,
                    ),
                    onPressed: () {},
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.volume_up_outlined,
                        size: 28,
                        color: Colors.black87,
                      ),
                    ),
                    label: Container(
                      width: double.infinity,
                      child: Text(
                        "Heads Up",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade200,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 18.0, left: 18, bottom: 8),
                    child: Text(
                      "Help",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                      primary: Colors.white,
                      onPrimary: Colors.purple.shade100,
                    ),
                    onPressed: () {},
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "Knowledge base",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                      primary: Colors.white,
                      onPrimary: Colors.purple.shade100,
                    ),
                    onPressed: () {},
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "Live chat with support",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                      primary: Colors.white,
                      onPrimary: Colors.purple.shade100,
                    ),
                    onPressed: () {},
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "Send Diagnostics",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade200,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 18.0, left: 18, bottom: 8),
                    child: Text(
                      "Account",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                      primary: Colors.white,
                      onPrimary: Colors.purple.shade100,
                    ),
                    onPressed: () {},
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "Settings",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 22),
                      primary: Colors.white,
                      onPrimary: Colors.purple.shade100,
                    ),
                    onPressed: () {
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
                    },
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "Log out",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
