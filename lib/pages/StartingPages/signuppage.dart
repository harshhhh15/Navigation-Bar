import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trynav/main.dart';
import 'package:trynav/pages/StartingPages/loginpage.dart';

const String apiUrl = 'http://192.168.246.5/harsh_api';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  TextEditingController _countryCodeController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String? _selectedSite;
  List<String> _valuesSite = [
    /*'Super Admin',*/ 'Project Admin',
    'Contributor'
  ];

  Future<void> _adddata() async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/register.php'),
        body: {
          'firstname': firstname.text,
          'lastname': lastname.text,
          'password': password.text,
          'email': email.text,
        },
      );
      if (response.statusCode == 200) {
        // decode the JSON response
        Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('message') &&
            data['message'] == 'Registration successful') {
          // show the message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 10),
                  Text('Register Successfully',
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
          // navigate to the new page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => loginpage()),
          );
          firstname.clear();
          lastname.clear();
          password.clear();
          email.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
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
    } catch (error) {
      // Handle error case
      print('Error: $error');
    } finally {}
  }

  @override
  void initState() {
    super.initState();
  }

  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        leadingWidth: 50,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).primaryColor,
            )),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Text(
                          "CREATE YOUR ACCOUNT",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Join our community today and start enjoying our features",
                          style: TextStyle(fontSize: 17.0, color: Colors.grey),
                        ),

// --------------------------------------------------------------------------------------------------------------   FOrmFields   -------------------------------------------------------------------------------------------------------------------------------------------

                        Container(
                          height: 240,
                          child: Image.asset("assets/images/createaccount.png"),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: TextFormField(
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
                                suffixIcon: Icon(
                                  Icons.mail_outline,
                                  color: Theme.of(context).primaryColor,
                                ),
                                border: OutlineInputBorder(),
                                labelText: "Email Address"),
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
                                  /*Icon(
                                    Icons.remove_red_eye_outlined,
                                    color:  Theme.of(context).primaryColor,
                                  ),*/
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: DropdownButtonFormField<String>(
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.green),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.deepPurple),
                              labelText: 'Role',
                              border: OutlineInputBorder(),
                            ),
                            value: _selectedSite,
                            onChanged: (String? selectedValue) {
                              setState(() {
                                _selectedSite = selectedValue;
                              });
                            },
                            validator: (String? value) {
                              if (value == null) {
                                return 'Please select Role';
                              }
                              return null;
                            },
                            items: _valuesSite
                                .map(
                                  (value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style:
                                          TextStyle(color: Colors.deepPurple),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            controller: firstname,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Full name is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Theme.of(context).primaryColor)),
                              suffixIcon: Icon(
                                Icons.perm_identity,
                                color: Theme.of(context).primaryColor,
                              ),
                              border: OutlineInputBorder(),
                              labelText: "Full name",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 60,
                                width: 70,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textCapitalization: TextCapitalization.words,
                                  controller: _countryCodeController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter the country code";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    border: OutlineInputBorder(),
                                    labelText: "Code",
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textCapitalization: TextCapitalization.words,
                                  controller: _phoneNumberController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter the phone number";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    suffixIcon: Icon(
                                      Icons.phone,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: "Phone Number",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "By Creating an account, you agree to our Terms and Conditions and privacy policy.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

// --------------------------------------------------------------------------------------------------------------   LOCATION   -------------------------------------------------------------------------------------------------------------------------------------------

                        Container(
                          width: double.infinity,
                          height: 56,
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14))),
                              child: const Text(
                                'Create account',
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              onPressed: () async {
                                if (_formkey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(Icons.check_circle,
                                              color: Colors.white),
                                          SizedBox(width: 10),
                                          Text('Account Created Successful',
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
                                          builder: (context) => loginpage()));
                                  return _adddata();
                                }

                                /*if (_formkey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                          content: Text("Welcome")),
                                    );
                                  }*/
                              }),
                        ),

// --------------------------------------------------------------------------------------------------------------   Already have Account   -------------------------------------------------------------------------------------------------------------------------------------------

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => loginpage()));
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Already have account? ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                              children: [
                                TextSpan(
                                  text: "Login",
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
