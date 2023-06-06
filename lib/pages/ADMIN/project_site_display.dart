import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/ADMIN/Admin_Drawer.dart';

import 'addproject_site.dart';

class projects_site_display extends StatefulWidget {
  const projects_site_display({Key? key}) : super(key: key);

  @override
  State<projects_site_display> createState() => _projects_site_displayState();
}

class _projects_site_displayState extends State<projects_site_display> {
  late Database _database;
  List<Map<String, dynamic>> _formData = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
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

  Future<void> _deleteItem(int id) async {
    await _database.delete(
      'my_project_site_table',
      where: 'id = ?',
      whereArgs: [id],
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => admin_drawer()));
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
              )),
          title: Text('Project site'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                ListTile(
                  title: Text('List of Sites'),
                  onTap: () {
                    // Handle navigation to the view inspection page
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: _formData.length,
                  itemBuilder: (context, index) {
                    final data = _formData[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4),
                        child: ListTile(
                          title: Text(
                            "SITE ID : " + data['id'].toString(),
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Site Name : " + data['sitename'],
                                style: TextStyle(color: Colors.black45),
                              ),
                              /*SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Parent ID : ',
                                style: TextStyle(color: Colors.black45),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Created By : ',
                                style: TextStyle(color: Colors.black45),
                              ),*/
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Created On : ' + data['created_on'],
                                style: TextStyle(color: Colors.black45),
                              ),

                              /* Row(
                                children: [
                                  Text(
                                    'Last updated By : ',
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Last updated On  : ',
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),*/
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              size: 26,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Are you sure?'),
                                    content: const Text(
                                        'This will delete all data.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await _deleteItem(data['id']);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'add',
          elevation: 0,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Add Site'),
                  content: Text('Want to add new Site'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Add'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => add_projects_site()));
                      },
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: Colors.deepPurple,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
