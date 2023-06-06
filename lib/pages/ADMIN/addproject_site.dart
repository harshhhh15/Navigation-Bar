import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/ADMIN/project_site_display.dart';

class add_projects_site extends StatefulWidget {
  const add_projects_site({Key? key}) : super(key: key);

  @override
  State<add_projects_site> createState() => _add_projects_siteState();
}

class _add_projects_siteState extends State<add_projects_site> {
  final _addprojectsitekey = GlobalKey<FormState>();
  final sitenamecontroller = TextEditingController();

  late Database _database;
  List<Map<String, dynamic>> _formData = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _saveData(BuildContext context) async {
    if (_addprojectsitekey.currentState!.validate()) {
      final sitename = sitenamecontroller.text;
      final createdDate = DateTime.now();
      final formattedDate = DateFormat('dd-MM-yyyy').format(createdDate);
      await _database.insert(
        'my_project_site_table',
        {
          'sitename': sitename,
          'created_on': formattedDate
              .toString(), // Save the created date in the database as a string
          // save the selected date in the database
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Action Status'),
            content: Text('Action created successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Reset feedback form
                  setState(() {});
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => projects_site_display()));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      // clear the input fields and reset selected values
      sitenamecontroller.clear();

      // update the form data and reset the selected date
      final formData = await _database.query('my_project_site_table');
      setState(() {
        _formData = formData;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('Data saved Successfully.',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(10),
        ),
      );
    }
  }

  Future<void> _initDatabase() async {
    final path = await getDatabasesPath();
    _database = await openDatabase(
      join(path, 'my_database44.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE my_project_site_table(id INTEGER PRIMARY KEY, sitename TEXT, created_on TEXT)', // add the date column to the table schema
        );
      },
      version:
          6, // increment the database version to trigger the onCreate callback
    );

    final formData = await _database.query('my_project_site_table');
    setState(() {
      _formData = formData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  AppBar -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Theme.of(context)
                .primaryColor, // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: Colors.deepPurple,
          elevation: 1,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
              )),
          title: Text('Project management site'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),

// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  Form  -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

            child: Form(
              key: _addprojectsitekey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "PROJECT MANAGEMENT SITE",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),

                  SizedBox(
                    height: 14,
                  ),

                  Text(
                    "Site Name",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: sitenamecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Site Name is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: Theme.of(context).primaryColor)),
                      suffixIcon: Icon(
                        Icons.perm_identity,
                      ),
                      border: OutlineInputBorder(),
                      labelText: "Enter Site Name",
                    ),
                  ),
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  Form  -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _saveData(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'ADD PROJECTS',
                        style: TextStyle(letterSpacing: 1),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
