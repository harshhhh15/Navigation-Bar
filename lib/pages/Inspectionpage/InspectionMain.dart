import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/user_drawer.dart';

import 'InspectionCreate.dart';

class inspectionpage extends StatefulWidget {
  const inspectionpage({Key? key}) : super(key: key);

  @override
  State<inspectionpage> createState() => _inspectionpageState();
}

class _inspectionpageState extends State<inspectionpage> {
  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  late Database _database;
  List<Map<String, dynamic>> _formData = [];

  Future<void> _initDatabase() async {
    final path = await getDatabasesPath();
    _database = await openDatabase(
      join(path, 'my_database45.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE inspection_table(id INTEGER PRIMARY KEY, title TEXT, descriptions TEXT, creator TEXT, status TEXT, note TEXT, site TEXT)', // add the date column to the table schema
        );
      },
      version:
          6, // increment the database version to trigger the onCreate callback
    );

    final formData = await _database.query('inspection_table');
    setState(() {
      _formData = formData;
    });
  }

  Future<void> _deleteData(int id) async {
    await _database.delete(
      'inspection_table',
      where: 'id = ?',
      whereArgs: [id],
    );

    final formData = await _database.query('inspection_table');
    setState(() {
      _formData = formData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: Theme.of(context).primaryColor,
              // Status bar brightness (optional)
              statusBarIconBrightness:
                  Brightness.light, // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            toolbarHeight: 134,
            leadingWidth: double.infinity,
            leading: Padding(
              padding: const EdgeInsets.only(left: 7, top: 6),
              child: Container(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Inspections",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => user_drawer()));
                          },
                          icon: Icon(
                            Icons.home_rounded,
                            color: Colors.deepPurple,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            cursorColor: Theme.of(context).primaryColor,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).primaryColor,
                              ),
                              hintText: "Search",
                              filled: true,
                              focusColor: Theme.of(context).primaryColor,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).primaryColor),
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
                                                      shadowColor:
                                                          Colors.transparent,
                                                      primary: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
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
                                              child: ElevatedButton.icon(
                                                  style: ElevatedButton.styleFrom(
                                                      shadowColor:
                                                          Colors.transparent,
                                                      primary: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
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
                            icon: Icon(Icons.add),
                            label: Text('Filter'),
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              labelPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              labelColor: Colors.white,
              indicatorPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).primaryColor,
              ),
              unselectedLabelColor: Colors.deepPurple.shade400,
              tabs: [
                Tab(
                  child: Text(
                    "In Process",
                    style: TextStyle(fontSize: 14, letterSpacing: 0.8),
                  ),
                ),
                Tab(
                  child: Text(
                    "Completed",
                    style: TextStyle(fontSize: 14, letterSpacing: 0.8),
                  ),
                ),
              ],
            ),
          ),

          body: TabBarView(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _formData.length,
                            itemBuilder: (context, index) {
                              final data = _formData[index];
                              if (data['status'] == "In Process")
                                return InkWell(
                                  onTap: () {},
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 4),
                                      child: ListTile(
                                        title: Text(
                                          "INSPECTION : " +
                                              data['id'].toString(),
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
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.api,
                                                    size: 16,
                                                    color:
                                                        Colors.deepPurple[600],
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
                                                    color:
                                                        Colors.deepPurple[600],
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    "Description : " +
                                                        data['descriptions'],
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
                                                    color:
                                                        Colors.deepPurple[600],
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    "Created by : " +
                                                        data['creator'],
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
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 1),
                                                  child: Text(
                                                    data['status'],
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.teal),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.villa_outlined,
                                                    size: 16,
                                                    color:
                                                        Colors.deepPurple[600],
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    "Site : " + data['site'],
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
                                                    Icons.notes,
                                                    size: 16,
                                                    color:
                                                        Colors.deepPurple[600],
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    "Note : " + data['note'],
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
                                                  title: const Text(
                                                      'Are you sure?'),
                                                  content: const Text(
                                                      'This will delete all data.'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        await _deleteData(
                                                            data['id']);
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Row(
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .white),
                                                                SizedBox(
                                                                    width: 10),
                                                                Text(
                                                                    'Site deleted Successfully.',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ],
                                                            ),
                                                            backgroundColor:
                                                                Colors.red,
                                                            duration: Duration(
                                                                seconds: 2),
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10),
                                                          ),
                                                        );
                                                      },
                                                      child:
                                                          const Text('Delete'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              else {
                                return SizedBox.shrink();
                              }
                              ;
                            })
                      ],
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _formData.length,
                              itemBuilder: (context, index) {
                                final data = _formData[index];
                                if (data['status'] == "Completed")
                                  return InkWell(
                                    onTap: () {},
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 4),
                                        child: ListTile(
                                          title: Text(
                                            "INSPECTION : " +
                                                data['id'].toString(),
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
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.api,
                                                      size: 16,
                                                      color: Colors
                                                          .deepPurple[600],
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      "Title : " +
                                                          data['title'],
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
                                                      Icons
                                                          .description_outlined,
                                                      size: 16,
                                                      color: Colors
                                                          .deepPurple[600],
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      "Description : " +
                                                          data['descriptions'],
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
                                                      color: Colors
                                                          .deepPurple[600],
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      "Created by : " +
                                                          data['creator'],
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5.0,
                                                        vertical: 1),
                                                    child: Text(
                                                      data['status'],
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.teal),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.villa_outlined,
                                                      size: 16,
                                                      color: Colors
                                                          .deepPurple[600],
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      "Site : " + data['site'],
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
                                                      Icons.notes,
                                                      size: 16,
                                                      color: Colors
                                                          .deepPurple[600],
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      "Note : " + data['note'],
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
                                                    title: const Text(
                                                        'Are you sure?'),
                                                    content: const Text(
                                                        'This will delete all data.'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          await _deleteData(
                                                              data['id']);
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Row(
                                                                children: [
                                                                  Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .white),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                      'Site deleted Successfully.',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                ],
                                                              ),
                                                              backgroundColor:
                                                                  Colors.red,
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          2),
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                            ),
                                                          );
                                                        },
                                                        child: const Text(
                                                            'Delete'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                else {
                                  return SizedBox.shrink();
                                }
                                ;
                              }),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
          floatingActionButton: FloatingActionButton(
            tooltip: 'add',
            elevation: 0,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => inspectioncreatepage()));
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
