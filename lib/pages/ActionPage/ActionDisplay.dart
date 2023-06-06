import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/ActionPage/ActionCreate.dart';

import '../user_drawer.dart';

class actionscreen2display extends StatefulWidget {
  const actionscreen2display({Key? key}) : super(key: key);

  @override
  State<actionscreen2display> createState() => _actionscreen2displayState();
}

class _actionscreen2displayState extends State<actionscreen2display> {
  bool _isSwitched = false;
  bool isAllSelected = false;

  List<Map<String, dynamic>> _formData = [];
  late Database _database;

  List<bool> _isSelected = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Map<int, bool> selectedFlag = {};
  bool isSelectionMode = false;

  Future<void> _initDatabase() async {
    final path = await getDatabasesPath();
    _database = await openDatabase(
      join(path, 'my_database99.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE my_table(id INTEGER PRIMARY KEY, title TEXT, description TEXT, createdby TEXT, status TEXT, site TEXT, assignee TEXT, priority TEXT, label TEXT, duedate TEXT, note TEXT )',
        );
      },
      version: 1,
    );
    final formData = await _database.query('my_table');
    setState(() {
      _formData = formData;
      _isSelected = List.generate(formData.length, (_) => false);
    });
  }

  Future<void> _deleteItem(int id) async {
    await _database.delete(
      'my_table',
      where: 'id = ?',
      whereArgs: [id],
    );

    final formData = await _database.query('my_table');
    setState(() {
      _formData = formData;
      _isSelected = List.generate(formData.length, (_) => false);
    });
  }

  void _selectAll() {
    setState(() {
      _isSelected = List.generate(_formData.length, (_) => true);
    });
  }

  void _deselectAll() {
    setState(() {
      _isSelected = List.generate(_formData.length, (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            leadingWidth: double.infinity,
            backgroundColor: Colors.deepPurple,
            shadowColor: Colors.transparent,
            toolbarHeight: 100,
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
                          style:
                              TextButton.styleFrom(primary: Colors.deepPurple),
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
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Actions",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        /* Row(
                          children: [
                            Text(
                              "Hide closed",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54),
                            ),
                            CupertinoSwitch(
                              value: _isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  _isSwitched = value;
                                });
                              },
                              activeColor: Colors.green,
                            ),
                          ],
                        ),*/
                      ],
                    ),
                  )
                ],
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  Search & Filter  -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  Select All & CSV  -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Theme.of(context).primaryColor,
                        value: _isSelected.every((isSelected) => isSelected),
                        onChanged: (value) {
                          if (value == true) {
                            _selectAll();
                          } else {
                            _deselectAll();
                          }
                        },
                      ),
                      Text('Select all'),
                    ],
                  ),
                  /* TextButton.icon(
                    onPressed: () {
                      // handle button press
                    },
                    icon: Icon(Icons.file_download_outlined),
                    label: Text(''),
                  ),*/
                ],
              ),

// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------- My List  -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

              Flexible(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _formData.length,
                  itemBuilder: (context, index) {
                    final data = _formData[index];
                    final isSelected = _isSelected[index];
                    return Dismissible(
                      key: Key(data['id'].toString()),
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          await _deleteItem(data['id']);
                        } else {
                          await _deleteItem(data['id']);
                        }
                      },
                      background: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                            ),
                            child: CheckboxListTile(
                              activeColor: Theme.of(context).primaryColor,
                              value: isSelected,
                              onChanged: (value) {
                                setState(() {
                                  _isSelected[index] = value!;
                                });
                              },
                              title: Text(
                                "ACTION : " + data['id'].toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(
                                  left: 4.0,
                                  right: 4,
                                  top: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                          "Created by : " + data['createdby'],
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
                                          Icons.villa_outlined,
                                          size: 16,
                                          color: Colors.deepPurple[600],
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
                                      height: 8,
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
                                          Icons.manage_accounts_outlined,
                                          size: 16,
                                          color: Colors.deepPurple[600],
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "Assignee : " + data['assignee'],
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
                                          Icons.auto_awesome_outlined,
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
                                          Icons.label_important_outline,
                                          size: 16,
                                          color: Colors.deepPurple[600],
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "Label : " + data['label'],
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
                                          Icons.calendar_today_outlined,
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
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.note_alt_outlined,
                                          size: 16,
                                          color: Colors.deepPurple[600],
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
                                    SizedBox(
                                      height: 5,
                                    ),
                                    /*Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      children: [
                                        Text("45 second ago"),
                                      ],
                                    ),*/
                                  ],
                                ),
                              ),
                            ),
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
                    title: Text('Create New Action'),
                    content: Text('Put Your Plans into Action'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Create'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => actioncreatepage()));
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
        ),
      ),
    );
  }
}

class SelectableItem {
  final String title;
  bool isSelected;

  SelectableItem({required this.title, this.isSelected = false});
}
