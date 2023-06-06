import 'package:flutter/material.dart';
import 'package:trynav/pages/StartingPages/loginpage.dart';

class ForgotPassword4 extends StatefulWidget {
  const ForgotPassword4({Key? key}) : super(key: key);

  @override
  State<ForgotPassword4> createState() => _ForgotPassword4State();
}

String name = "";

class _ForgotPassword4State extends State<ForgotPassword4> {
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
                          "New password\nsuccessful set",
                          style: TextStyle(
                              fontSize: 28,
                              letterSpacing: 0.4,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Container(
                            height: 200,
                            child: Image.asset("assets/images/done.png"),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "You have successfully confirm your new password. Please, use your new password when logging in.",
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => loginpage()));
                  },
                  child: Text("Okay",
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
