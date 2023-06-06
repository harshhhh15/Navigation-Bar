import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../user_drawer.dart';

class invitationsent extends StatefulWidget {
  const invitationsent({Key? key}) : super(key: key);

  @override
  State<invitationsent> createState() => _invitationsentState();
}

class _invitationsentState extends State<invitationsent> {
  late Database _invitation_database;
  List<Map<String, dynamic>> _invitation_formData = [];

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

  List<Map> staticData = [
    {
      "id": 1,
      "name": "Marchelle",
      // "email": "mailward0@hibu.com",
      // "address": "57 Bowman Drive"
    },
    {
      "id": 2,
      "name": "Modesty",
      // "email": "mviveash1@sohu.com",
      // "address": "2171 Welch Avenue"
    },
    {
      "id": 3,
      "name": "Maure",
      // "email": "mdonaghy2@dell.com",
      // "address": "4623 Chinook Circle"
    },
    {
      "id": 4,
      "name": "Myrtie",
      // "email": "mkilfoyle3@yahoo.co.jp",
      // "address": "406 Kings Road"
    },
    {
      "id": 5,
      "name": "Winfred",
      // "email": "wvenn4@baidu.com",
      // "address": "2444 Pawling Lane"
    }
  ];
  Map<int, bool> selectedFlag = {};
  bool isSelectionMode = false;

  Widget _buildSelectIcon(bool isSelected, Map data) {
    if (isSelectionMode) {
      return Icon(
        isSelected ? (Icons.check_circle) : Icons.circle_outlined,
        color: Colors.deepPurple,
      );
    } else {
      return Container(
        child: Icon(
          Icons.circle_outlined,
          color: Colors.deepPurple,
        ),
      );
    }
  }

  void onLongPress(bool isSelected, int index) {
    setState(() {
      selectedFlag[index] = !isSelected;
      // If there will be any true in the selectionFlag then
      // selection Mode will be true
      isSelectionMode = selectedFlag.containsValue(true);
    });
  }

  void onTap(bool isSelected, int index) {
    if (isSelectionMode) {
      setState(() {
        selectedFlag[index] = !isSelected;
        isSelectionMode = selectedFlag.containsValue(true);
      });
    } else {
      // Open Detail Page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: 240,
                child: Image.asset("assets/images/Mailbox.png"),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Invites Sent",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                textAlign: TextAlign.center,
                "Great job! Your team has now been invited. You can always add more team members via the 'More' menu.",
                style: TextStyle(
                  fontSize: 17,
                  height: 1.5,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _invitation_formData.length,
                  itemBuilder: (builder, index) {
                    Map data = _invitation_formData[index];
                    selectedFlag[index] = selectedFlag[index] ?? false;
                    bool? isSelected = selectedFlag[index];
                    return ListTile(
                      onLongPress: () => onLongPress(isSelected!, index),
                      onTap: () => onTap(isSelected!, index),
                      title: Text(
                        data['email'],
                        // "${data['email']}",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18),
                      ),
                      trailing: _buildSelectIcon(isSelected!, data),
                    );
                  },
                ),
              ),
            ],
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.white),
                              SizedBox(width: 10),
                              Text('Invitation send successfully',
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => user_drawer()));
                    },
                    child: Text("Get Started",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          letterSpacing: 1,
                          fontSize: 20,
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
