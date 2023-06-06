import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/ADMIN/create_projects.dart';
import 'package:trynav/pages/ADMIN/project_site_display.dart';

import '../homepage/notification.dart';
import 'Add_Site.dart';

class adminmain extends StatefulWidget {
  @override
  State<adminmain> createState() => _adminmainState();
}

class _adminmainState extends State<adminmain> {
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  late Database _database;
  List<Map<String, dynamic>> _formData = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
    _initDatabaseforsite();
  }

  Future<void> _initDatabase() async {
    final path = await getDatabasesPath();
    _database = await openDatabase(
      join(path, 'my_database101.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE my_project_table(id INTEGER PRIMARY KEY, projectname TEXT, projectdetails TEXT, clientname TEXT, clientaddress TEXT, clientphonecode TEXT, clientnumber TEXT, clientemail TEXT, contactname TEXT, contactpersonphonecode TEXT, contactpersonnumber TEXT, contactpersonemail TEXT, note TEXT, created_on TEXT)', // add the date column to the table schema
        );
      },
      version:
          6, // increment the database version to trigger the onCreate callback
    );

    final formData = await _database.query('my_project_table');
    setState(() {
      _formData = formData;
    });
  }

  Future<void> _deleteItem(int id) async {
    await _database.delete(
      'my_project_table',
      where: 'id = ?',
      whereArgs: [id],
    );

    final formData = await _database.query('my_project_table');
    setState(() {
      _formData = formData;
    });
  }

// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  late Database _sitedatabase;
  List<Map<String, dynamic>> _siteformData = [];

  late Database action_database;
  List action_data_storage = [];

  Future<void> _initDatabaseforsite() async {
    final path = await getDatabasesPath();
    _sitedatabase = await openDatabase(
      join(path, 'my_database100.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE my_table(id INTEGER PRIMARY KEY, title TEXT, description TEXT, siteowner TEXT, status TEXT, priority TEXT, location TEXT)',
        );
      },
      version: 1,
    );
    final formData = await _sitedatabase.query('my_table');
    setState(() {
      _siteformData = formData;
    });
  }

  Future<void> _deleteSite(int id) async {
    await _sitedatabase.delete(
      'my_table',
      where: 'id = ?',
      whereArgs: [id],
    );

    final formData = await _sitedatabase.query('my_table');
    setState(() {
      _siteformData = formData;
    });
  }

// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.deepPurple,
            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          leadingWidth: double.infinity,
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          toolbarHeight: 103,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          final controller = ZoomDrawer.of(context);
                          controller?.toggle();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: Colors.deepPurple,
                        )),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoNotificationsPage()));
                        },
                        icon: Icon(
                          Icons.notifications_none,
                          color: Colors.deepPurple,
                        )),
                    /*IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: Container(
                                  height: 130,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 56,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shadowColor:
                                                      Colors.transparent,
                                                  primary: Theme.of(context)
                                                      .primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14))),
                                              onPressed: () {
                    */
                    /* Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => invitationsent()));*/
                    /*
                                              },
                                              child: Text("View Inspections",
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    letterSpacing: 1,
                                                    fontSize: 20,
                                                  ))),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 56,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shadowColor:
                                                      Colors.transparent,
                                                  primary: Theme.of(context)
                                                      .primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14))),
                                              onPressed: () {
                     Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => invitationsent()));
                                              },
                                              child: Text("View Query",
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    letterSpacing: 1,
                                                    fontSize: 20,
                                                  ))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.more_vert_rounded,
                          color: Colors.deepPurple,
                        )),*/
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Admin Dashboard",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                )
              ],
            ),
          ),
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  TabBar  -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

          bottom: TabBar(
            labelPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            labelColor: Colors.white,
            indicatorPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(12), // Creates border
                color: Colors.deepPurple),
            unselectedLabelColor: Colors.deepPurple.shade400,
            tabs: [
              Tab(
                child: Text(
                  "List of SITES",
                  style: TextStyle(fontSize: 14, letterSpacing: 1.2),
                ),
              ),
              Tab(
                child: Text(
                  textAlign: TextAlign.center,
                  "List of Project",
                  style: TextStyle(fontSize: 14, letterSpacing: 1.2),
                ),
              ),
            ],
          ),
        ),
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  Body  -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

        body: TabBarView(
          children: [
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  TabBarView  1 -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

            Scaffold(
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        ListTile(
                          title: Text('List of SITES'),
                        ),
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _siteformData.length,
                          itemBuilder: (context, index) {
                            final data = _siteformData[index];
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
                                    "SITE : " + data['id'].toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.api,
                                              size: 16,
                                              color: Colors.deepPurple[600],
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "Title : " + data['title'],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.description_outlined,
                                              size: 16,
                                              color: Colors.deepPurple[600],
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "Description : " +
                                                  data['description'],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person_2_outlined,
                                              size: 16,
                                              color: Colors.deepPurple[600],
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              'Site Owner : ' +
                                                  data['siteowner'],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: 16,
                                              color: Colors.deepPurple[600],
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              'Location : ' + data['location'],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.beenhere_outlined,
                                              size: 16,
                                              color: Colors.deepPurple[600],
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              'Priority : ' + data['priority'],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade50,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0, vertical: 1),
                                            child: Text(
                                              data['status'],
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.teal),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.deepPurple),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await _deleteSite(data['id']);
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Row(
                                                        children: [
                                                          Icon(Icons.delete,
                                                              color:
                                                                  Colors.white),
                                                          SizedBox(width: 10),
                                                          Text(
                                                              'Site deleted Successfully.',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ],
                                                      ),
                                                      backgroundColor:
                                                          Colors.red,
                                                      duration:
                                                          Duration(seconds: 2),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      margin:
                                                          EdgeInsets.all(10),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
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
                          content: Text('Want to add new Sites'),
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
                                        builder: (context) => Add_Sites()));
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
                )),

// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  TabBarView 2 -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

            Scaffold(
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        ListTile(
                          title: Text('List of PROJECTS'),
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
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              projects_site_display()),
                                    );
                                  },
                                  title: Text(
                                    "PROJECT : " + data['id'].toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text(
                                        "Project details : ",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.api,
                                                  size: 17,
                                                  color: Colors.deepPurple[600],
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Name : " +
                                                      data['projectname'],
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.description_outlined,
                                                  size: 16,
                                                  color: Colors.deepPurple[600],
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Details : " +
                                                      data['projectdetails'],
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Client details : ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  size: 16,
                                                  color: Colors.deepPurple[600],
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Client: " +
                                                      data['clientname'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 16,
                                                  color: Colors.deepPurple[600],
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Address: " +
                                                      data['clientaddress'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  size: 16,
                                                  color: Colors.deepPurple[600],
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Phone: " +
                                                      data['clientphonecode'] +
                                                      " " +
                                                      data['clientnumber'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.email,
                                                  size: 16,
                                                  color: Colors.deepPurple[600],
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Email: " +
                                                      data['clientemail'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Contact person details : ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.person_pin,
                                                  size: 16,
                                                  color: Colors.deepPurple[600],
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Contact Person: " +
                                                      data['contactname'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  size: 16,
                                                  color: Colors.deepPurple[600],
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Phone: " +
                                                      data[
                                                          'contactpersonphonecode'] +
                                                      " " +
                                                      data[
                                                          'contactpersonnumber'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.email,
                                                  size: 16,
                                                  color: Colors.deepPurple[600],
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Contact : " +
                                                      data[
                                                          'contactpersonemail'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Other details : ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.note_alt_outlined,
                                                  size: 16,
                                                  color: Colors.deepPurple[600],
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  'Notes: ' + data['note'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.date_range,
                                                  size: 16,
                                                  color: Colors.deepPurple[600],
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  'Created On: ' +
                                                      data['created_on'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      size: 26,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Are you sure?'),
                                            content: Text(
                                                'This will delete all data.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await _deleteItem(data['id']);
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Row(
                                                        children: [
                                                          Icon(Icons.delete,
                                                              color:
                                                                  Colors.white),
                                                          SizedBox(width: 10),
                                                          Text(
                                                              'Site deleted Successfully.',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ],
                                                      ),
                                                      backgroundColor:
                                                          Colors.red,
                                                      duration:
                                                          Duration(seconds: 2),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      margin:
                                                          EdgeInsets.all(10),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
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
                          title: Text('Add Project'),
                          content: Text('Want to new add Project'),
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
                                        builder: (context) => add_projects()));
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
                )),
          ],
        ),
      ),
    );
  }
}
