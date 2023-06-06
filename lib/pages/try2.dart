import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String apiUrl = 'http://192.168.246.5/harsh_api';

class try2 extends StatefulWidget {
  final String id;

  try2({required this.id});

  @override
  State<try2> createState() => _try2State();
}

class _try2State extends State<try2> {
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

          /*ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'User data retrieved successfully!\nFirst Name: ${userData['firstname']}\nEmail: ${userData['email']}',
              ),
            ),
          );*/

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: _userData == null
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_userData!['firstname']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "${_userData!['email'] ?? ""}",
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
                                "${_userData!['email'] ?? ""}"
                                    .substring(0, 2)
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                    fontSize: 28),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
