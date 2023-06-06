import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class allacountpage extends StatefulWidget {
  const allacountpage({Key? key}) : super(key: key);

  @override
  State<allacountpage> createState() => _allacountpageState();
}

class _allacountpageState extends State<allacountpage> {
  final _formkey = GlobalKey<FormState>();

  late Database _account_database;
  List _account_formData = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final path = await getDatabasesPath();
    _account_database = await openDatabase(
      join(path, 'my_database8.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE _Signupdata_table(id INTEGER PRIMARY KEY, email TEXT, password TEXT, fname TEXT, lname TEXT)',
        );
      },
      version: 1,
    );
    final formData = await _account_database.query('_Signupdata_table');
    setState(() {
      _account_formData = formData;
    });
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
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 260,
                  child: Image.asset("assets/images/accounts.png"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "All Accounts",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _account_formData.length,
                    itemBuilder: (context, index) {
                      final data = _account_formData[index];
                      return ListTile(
                        title: Text("Email Address : " + data['email']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Password : " + data['password']),
                            Text("First Name : " + data['fname']),
                            Text("Last Name : " + data['lname']),
                          ],
                        ),
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
    );
  }
}
