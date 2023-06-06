import 'package:flutter/material.dart';

import 'ForgotPassword3.dart';

class ForgotPassword2 extends StatefulWidget {
  const ForgotPassword2({Key? key}) : super(key: key);

  @override
  State<ForgotPassword2> createState() => _ForgotPassword2State();
}

String name = "";

class _ForgotPassword2State extends State<ForgotPassword2> {
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
                          height: 12,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Password reset e-mail\nhas been sent",
                          style: TextStyle(
                              fontSize: 28,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Container(
                            height: 240,
                            child: Image.asset("assets/images/verify.png"),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "A password reset email has been sent to your E-mail address.",
                          style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 0.1,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
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
                            builder: (context) => ForgotPassword3()));
                  },
                  child: Text("Set a new password",
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
