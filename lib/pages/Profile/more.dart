import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trynav/pages/Profile/MyTeam.dart';
import 'package:trynav/pages/Profile/updateprofile.dart';

const String apiUrl = 'http://192.168.246.5/harsh_api';

class morepage extends StatefulWidget {
  final String id;

  morepage({required this.id});

  @override
  State<morepage> createState() => _morepageState();
}

class _morepageState extends State<morepage> {
  File? _image;

  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _getUserData(context, widget.id);
  }

  Future<void> _getUserData(BuildContext context, String id) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/profile.php'),
        body: {'id': widget.id},
      );
      if (response.statusCode == 200) {
        // decode the JSON response
        Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('data')) {
          // show the retrieved data to the user
          Map<String, dynamic> userData = data['data'][0];

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'User data retrieved successfully!\nFirst Name: ${userData['firstname']}\nEmail: ${userData['email']}',
              ),
            ),
          );

          setState(() {
            _userData = userData;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User data not found')),
          );
        }
      } else {
        throw Exception('Error: ${response.reasonPhrase}');
      }
    } on SocketException {
      // handle network error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error')),
      );
    } catch (error) {
      // handle other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
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
              )),
          title: Text("More"),
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: _userData == null
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePicturePage()));
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
                                    "Harsh Mistry",
                                    // "${_userData!['firstname']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "harshmistry0007@gmail.com",
                                    // "${_userData!['email'] ?? ""}",
                                  ),
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
                                radius: 30,
                                backgroundColor: Colors.grey.shade200,
                                child: Text(
                                  "harshmistry0007@gmail.com"
                                      // "${_userData!['email'] ?? ""}"
                                      .substring(0, 2)
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      fontSize: 28),
                                ),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 10),
                              primary: Colors.white,
                              onPrimary: Colors.purple.shade100,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => myteam()));
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 10),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 10),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 10),
                              primary: Colors.white,
                              onPrimary: Colors.purple.shade100,
                            ),
                            onPressed: () {},
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 10),
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
                            padding: const EdgeInsets.only(
                                top: 18.0, left: 18, bottom: 8),
                            child: Text(
                              "Help",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 22),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 22),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 22),
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
                            padding: const EdgeInsets.only(
                                top: 18.0, left: 18, bottom: 8),
                            child: Text(
                              "Account",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 22),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 22),
                              primary: Colors.white,
                              onPrimary: Colors.purple.shade100,
                            ),
                            onPressed: () {},
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
      ),
    );
  }
}
