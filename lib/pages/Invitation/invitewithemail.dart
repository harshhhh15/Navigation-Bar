import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'invitationsent.dart';

class invitewithemail extends StatefulWidget {
  const invitewithemail({Key? key}) : super(key: key);

  @override
  State<invitewithemail> createState() => _invitewithemailState();
}

class _invitewithemailState extends State<invitewithemail> {
  final _invitationkey = GlobalKey<FormState>();
  final _invitation_email_controller = TextEditingController();

  late Database _invitation_database;
  List _invitation_formData = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final path = await getDatabasesPath();
    _invitation_database = await openDatabase(
      join(path, 'my_database2.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE _invitation_table(id INTEGER PRIMARY KEY, email TEXT)',
        );
      },
      version: 1,
    );
    final formData = await _invitation_database.query('_invitation_table');
    setState(() {
      _invitation_formData = formData;
    });
  }

  Future<void> _saveData() async {
    if (_invitationkey.currentState!.validate()) {
      final email = _invitation_email_controller.text;

      await _invitation_database.insert(
        '_invitation_table',
        {
          'email': email,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      _invitation_email_controller.clear();

      final formData = await _invitation_database.query('_invitation_table');
      setState(() {
        _invitation_formData = formData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _invitationkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 230,
                  child: Image.asset("assets/images/invitewithmail.png"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Invite with Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  textAlign: TextAlign.start,
                  "Invite up to 8 users to your team for free by entering their email addresses below. Need more? You can always upgrade your plan.",
                  style: TextStyle(
                    letterSpacing: 0.2,
                    fontSize: 17,
                    height: 1.5,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  textAlign: TextAlign.start,
                  "Email",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter Email address";
                            }
                            // if (!value.contains(
                            //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')) {
                            //   return 'Invalid Email';
                            // }
                            return null;
                          },
                          controller: _invitation_email_controller,
                          decoration:
                              InputDecoration(hintText: "Enter email address"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: _saveData,
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    child: Text(
                      "ADD ANOTHER EMAIL",
                      style: TextStyle(
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Theme.of(context).primaryColor),
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _invitation_formData.length,
                    itemBuilder: (context, index) {
                      final data = _invitation_formData[index];
                      return ListTile(
                        title: Text(data['email']),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      )),
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
                              builder: (context) => invitationsent()));
                    },
                    child:
                        Text("Send Invites", style: TextStyle(fontSize: 18))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
