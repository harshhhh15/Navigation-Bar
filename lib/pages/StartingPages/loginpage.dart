import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trynav/main.dart';
import 'package:trynav/pages/StartingPages/signuppage.dart';
import 'package:trynav/pages/user_drawer.dart';

import '../ADMIN/Admin_User.dart';
import 'ForgotPassword1.dart';

const String apiUrl = 'http://192.168.123.5/harsh_api';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final GlobalKey<FormState> _validatekey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _checklogindata(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/login.php'),
        body: {
          'password': password.text,
          'email': email.text,
        },
      );
      if (response.statusCode == 200) {
        // decode the JSON response
        Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('message') &&
            data['message'] == 'Login successfull') {
          // show the message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 10),
                  Text('Login Successfully',
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 10),
                  Text(data['message'], style: TextStyle(color: Colors.white)),
                ],
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );

          /*  Navigator.pushNamed(
            context,
            '/morepage',
            arguments: {'id': 7}, // pass the id parameter as arguments
          );*/

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => user_drawer(), // pass the id parameter here
            ),
          );

          // password.clear();
          // email.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.white),
                  SizedBox(width: 10),
                  Text(data['message'], style: TextStyle(color: Colors.white)),
                ],
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(10),
            ),
          );
        }
      } else {
        throw Exception('Error: ${response.reasonPhrase}');
      }
    } on SocketException {
      // handle network error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 10),
              Text('Network error', style: TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(10),
        ),
      );
    } catch (error) {
      // handle other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 10),
              Text('Error: $error', style: TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    } finally {}
  }

  bool _passwordVisible = true;
  bool changeButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        leadingWidth: 50,
        /* leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).primaryColor,
            )),*/
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _validatekey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Log in to continue',
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Container(
                            height: 240,
                            child: Image.asset("assets/images/welcome.png"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            onChanged: (value) {
                              name = value;
                              setState(() {});
                            },
                            controller: email,
                            validator: (input) {
                              return input!.isValidEmail()
                                  ? null
                                  : "Check your email address";
                            },
                            decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Theme.of(context).primaryColor)),
                                focusColor: Theme.of(context).primaryColor,
                                suffixIcon: Icon(
                                  Icons.mail_outline,
                                  color: Theme.of(context).primaryColor,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Email "),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: TextFormField(
                              controller: password,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Theme.of(context).primaryColor,
                                      )),
                                  border: OutlineInputBorder(),
                                  labelText: "Password"),
                              validator: (txt) {
                                if (txt == null || txt.isEmpty) {
                                  return "Please Enter some Value!";
                                }
                                if (txt.length < 8) {
                                  return "Password must has 8 characters";
                                }
                                if (!txt.contains(RegExp(r'[A-Z]'))) {
                                  return "Password must has uppercase";
                                }
                                if (!txt.contains(RegExp(r'[0-9]'))) {
                                  return "Password must has digits";
                                }
                                if (!txt.contains(RegExp(r'[a-z]'))) {
                                  return "Password must has lowercase";
                                }
                                if (!txt.contains(RegExp(r'[#?!@$%^&*-]'))) {
                                  return "Password must has special characters";
                                } else
                                  return null;
                              }),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              child: const Text(
                                'Forget password?',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.normal),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPassword1()));
                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.end,
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        Material(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              BorderRadius.circular(changeButton ? 50 : 14),
                          child: Container(
                            height: 56,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_validatekey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(Icons.check_circle,
                                              color: Colors.white),
                                          SizedBox(width: 10),
                                          Text('Login Successfully',
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
                                          builder: (context) => Admin_User()));
                                  // return _adddata();
                                }
                                /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Admin_User()));*/
                              },
                              child: Text("Login",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 20,
                                      color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signup()));
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                              children: [
                                TextSpan(
                                  text: "Create now",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
