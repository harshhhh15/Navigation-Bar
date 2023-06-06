import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/user_drawer.dart';

import 'IssueCreate.dart';

class issuepagescreen2 extends StatefulWidget {
  const issuepagescreen2({Key? key}) : super(key: key);

  @override
  State<issuepagescreen2> createState() => _issuepagescreen2State();
}

class _issuepagescreen2State extends State<issuepagescreen2> {
  List _displayIssueData = [];
  late Database _DisplayIssuedatabase;

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
      join(path, 'my_database91.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE my_issuetable(id INTEGER PRIMARY KEY, title TEXT, description TEXT, status TEXT, category TEXT, site TEXT, assignee TEXT, priority TEXT, duedate TEXT)',
        );
      },
      version: 1,
    );
    final formData = await _database.query('my_issuetable');
    setState(() {
      _formData = formData;
    });
  }

  Future<void> _deleteData(int id) async {
    await _database.delete(
      'my_issuetable',
      where: 'id = ?',
      whereArgs: [id],
    );

    final formData = await _database.query('my_issuetable');
    setState(() {
      _formData = formData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Theme.of(context).primaryColor,
            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: Colors.deepPurple,
          shadowColor: Colors.transparent,
          toolbarHeight: 100,
          leadingWidth: double.infinity,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(primary: Colors.white),
                        child: Text(
                          "Back",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        )),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => user_drawer()));
                        },
                        style: TextButton.styleFrom(primary: Colors.white),
                        icon: Icon(Icons.home_rounded)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Issue",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      /* TextButton.icon(
                        onPressed: () {},
                        icon: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.settings,
                            size: 25.0,
                            color: Colors.white,
                          ),
                        ),
                        label: Text(
                          'Flow',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                      )*/
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: Theme.of(context).primaryColor,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).primaryColor,
                        ),
                        hintText: "Search",
                        filled: true,
                        focusColor: Theme.of(context).primaryColor,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey.shade50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              width: 2, color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: ElevatedButton.icon(
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
                                        child: ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                                shadowColor: Colors.transparent,
                                                primary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14))),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.calendar_today,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            label: Text("Overdue actions",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.normal,
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
                                        child: ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                                shadowColor: Colors.transparent,
                                                primary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14))),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.person,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            label: Text("Assign to me",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
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
                          },
                        );
                      },
                      icon: Icon(Icons.filter_list),
                      label: Text('Filter'),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: _formData.length,
                  itemBuilder: (context, index) {
                    final data = _formData[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4),
                        child: ListTile(
                          title: Text(
                            "ISSUE : " + data['id'].toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
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
                                      "Description : " + data['description'],
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
                                      'Category : ' + data['category'],
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
                                      'Site : ' + data['site'],
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
                                      "Assign to : " + data['assignee'],
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
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 1),
                                    child: Text(
                                      "Status : " + data['status'],
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.teal),
                                    ),
                                  ),
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
                                      "Priority : " + data['priority'],
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
                                      "Due Date : " + data['duedate'],
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
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await _deleteData(data['id']);
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
                ),
              ),
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
        floatingActionButton: FloatingActionButton(
          tooltip: 'add',
          elevation: 0,
          onPressed: () {
            {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // Build the dialog widget
                  return AlertDialog(
                    title: Text('Report new issue'),
                    content: Text('Report new Issue'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Report'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => createissue(
                                        issueType: '',
                                      )));
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
