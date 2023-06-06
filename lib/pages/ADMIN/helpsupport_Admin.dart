import 'package:flutter/material.dart';

class helpAndSupportForm extends StatefulWidget {
  @override
  _helpAndSupportFormState createState() => _helpAndSupportFormState();
}

class _helpAndSupportFormState extends State<helpAndSupportForm> {
  // Define variables for the form inputs
  late String email = "";
  late String phone = "";
  late String chat = "";

  // Define functions to handle changes to the form inputs
  void handleEmailChange(String value) {
    setState(() {
      email = value;
    });
  }

  void handlePhoneChange(String value) {
    setState(() {
      phone = value;
    });
  }

  void handleChatChange(String value) {
    setState(() {
      chat = value;
    });
  }

  // Define a function to submit the form data
  void handleSubmit() {
    // Do something with the form data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
              )),
          title: Text('Edit Help & Support Page'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(24.0),
            child:
                ListView(physics: BouncingScrollPhysics(), children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: email,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                onChanged: handleEmailChange,
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                ),
                onChanged: handlePhoneChange,
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: chat,
                decoration: InputDecoration(
                  labelText: 'Chat',
                ),
                onChanged: handleChatChange,
              ),
              SizedBox(height: 30),
              Container(
                height: 46,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    /* if (_validatekey.currentState!.validate()) {
                          return _checklogindata(context);
                        }*/
                  },
                  child: Text("Save Contact Details",
                      style: TextStyle(
                          letterSpacing: 1, fontSize: 20, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 44),
              Text(
                'FAQ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Question',
                    ),
                    onChanged: (value) {
                      // Handle question change
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Answer',
                    ),
                    onChanged: (value) {
                      // Handle answer change
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                height: 46,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    /* if (_validatekey.currentState!.validate()) {
                          return _checklogindata(context);
                        }*/
                  },
                  child: Text("Save FAQ",
                      style: TextStyle(
                          letterSpacing: 1, fontSize: 20, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                ),
              ),
            ])));
  }
}
