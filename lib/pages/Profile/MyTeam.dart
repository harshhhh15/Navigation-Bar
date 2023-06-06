import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/Invitation/invitewithemail.dart';

class myteam extends StatefulWidget {
  const myteam({Key? key}) : super(key: key);

  @override
  State<myteam> createState() => _myteamState();
}

class _myteamState extends State<myteam> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).primaryColor,
              )),
          elevation: 1,
          backgroundColor: Colors.white,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Team",
                style: TextStyle(color: Colors.black87, fontSize: 20),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
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
                          "Admin",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text("Admin@gmail.com"),
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
                        "AD",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 28),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade200,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                      primary: Colors.white,
                      onPrimary: Colors.purple.shade100,
                    ),
                    onPressed: () {},
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.sms_outlined,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    label: Container(
                      width: double.infinity,
                      child: Text("INVITE WITH SMS",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Theme.of(context).primaryColor)),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                      primary: Colors.white,
                      onPrimary: Colors.purple.shade100,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => invitewithemail()));
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.mark_email_unread_outlined,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    label: Container(
                      width: double.infinity,
                      child: Text("INVITE WITH EMAIL",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Theme.of(context).primaryColor)),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade200,
              ),
              Container(
                width: double.infinity,
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 18, bottom: 8),
                  child: Text(
                    "7 free seats remaining",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _invitation_formData.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map data = _invitation_formData[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.grey.shade200,
                            child: Text(
                              data['email'].toUpperCase()[0],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 24),
                            ),
                          ),
                          title: Text(
                            data["email"],
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16),
                          ),
                          trailing: Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              child: Text(
                                "Invited",
                                style: TextStyle(color: Colors.teal),
                              ),
                            )),
                          ),
                        ),
                        Divider(
                          height: 20,
                          thickness: 1,
                          color: Colors.grey.shade200,
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
