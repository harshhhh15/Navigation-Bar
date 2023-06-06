import 'package:flutter/material.dart';
import 'package:trynav/main.dart';

import 'ForgotPassword2.dart';

class ForgotPassword1 extends StatefulWidget {
  const ForgotPassword1({Key? key}) : super(key: key);

  @override
  State<ForgotPassword1> createState() => _ForgotPassword1State();
}

String name = "";

class _ForgotPassword1State extends State<ForgotPassword1> {
  final _validatekey = GlobalKey<FormState>();
  final _emailvalidatecontroller = TextEditingController();

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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Forgot your password?",
                            style: TextStyle(
                                fontSize: 28,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "Please, enter your e-mail address below\nto receive your new password.",
                            style: TextStyle(
                                fontSize: 17,
                                letterSpacing: 0.3,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Container(
                              height: 290,
                              child: Image.asset("assets/images/forgot.png"),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              onChanged: (value) {
                                name = value;
                                setState(() {});
                              },
                              controller: _emailvalidatecontroller,
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
                                          color:
                                              Theme.of(context).primaryColor)),
                                  focusColor: Theme.of(context).primaryColor,
                                  suffixIcon: Icon(
                                    Icons.mail_outline,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  border: OutlineInputBorder(),
                                  labelText: "Email "),
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
                    if (_validatekey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword2()));
                      // return _adddata();
                    }
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword2()));*/
                  },
                  child: Text("Reset password",
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
