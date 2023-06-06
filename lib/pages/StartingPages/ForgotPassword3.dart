import 'package:flutter/material.dart';

import 'ForgotPassword4.dart';

class ForgotPassword3 extends StatefulWidget {
  const ForgotPassword3({Key? key}) : super(key: key);

  @override
  State<ForgotPassword3> createState() => _ForgotPassword3State();
}

String name = "";

class _ForgotPassword3State extends State<ForgotPassword3> {
  final _validatekey = GlobalKey<FormState>();
  final _emailvalidatecontroller = TextEditingController();
  final _passwordvalidatecontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  /* void Validate(String value) {
    bool isvalid = EmailValidator.validate(value);
    print(isvalid);
  }*/

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
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _validatekey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "Please, enter a new password below.",
                            style: TextStyle(
                                fontSize: 28,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Container(
                              height: 240,
                              child: Image.asset(
                                  "assets/images/enterpasswordbelow.png"),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _passwordvalidatecontroller,
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
                                  floatingLabelStyle: TextStyle(fontSize: 24),
                                  labelText: "New password"),
                              /*validator: (txt) {
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
                              }*/
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _passwordvalidatecontroller,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Theme.of(context).primaryColor)),
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
                                floatingLabelStyle: TextStyle(fontSize: 24),
                                labelText: "Confirm a new password",
                              ),
                              /*validator: (txt) {
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
                              }*/
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
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword4()));
                  },
                  child: Text("Save",
                      style: TextStyle(
                          letterSpacing: 1, fontSize: 20, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
