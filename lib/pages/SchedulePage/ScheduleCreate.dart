import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/SchedulePage/ScheduleMain.dart';

class schedulecreate extends StatefulWidget {
  const schedulecreate({Key? key}) : super(key: key);

  @override
  State<schedulecreate> createState() => _schedulecreateState();
}

class _schedulecreateState extends State<schedulecreate> {
  final _createmyscheduleKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  bool _isChecked = false;

  String? _selectedSite;
  List<String> _valuesSite = ['Site 1', 'Site 2', 'Site 3'];

  String? _selectedTemplates;
  List<String> _valuesTemplates = ['Tem 1', 'Tem 2', 'Tem 3'];

  String? _selectedAssignee;
  List<String> _valuesAssignee = ['Assignee 1', 'Assignee 2', 'Assignee 3'];

  String? _selectedHowOften;
  List<String> _valuesPriority = ['Low', 'Normal', 'High'];

  late Database _database;
  List<Map<String, dynamic>> _formData = [];

  Future<void> _saveData(BuildContext context) async {
    if (_createmyscheduleKey.currentState!.validate()) {
      final title = _titleController.text;
      final status = _selectedSite;
      final templates = _selectedTemplates;
      final assignee = _selectedAssignee;
      final howOften = _selectedHowOften;

      // get the selected date

      await _database.insert(
        'schedule_table',
        {
          'title': title,
          'status': status,
          'templates': templates,
          'assignee': assignee,
          'howOften': howOften,
          // save the selected date in the database
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Schedule Status'),
            content: Text('Schedule created successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Reset feedback form
                  setState(() {});
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => schedulepage()));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

      // clear the input fields and reset selected values
      _titleController.clear();
      _selectedSite = null;
      _selectedAssignee = null;
      _selectedHowOften = null;
      _selectedTemplates = null;

      // update the form data and reset the selected date
      final formData = await _database.query('schedule_table');
      setState(() {
        _formData = formData;
      });
    }
  }

  Future<void> _initDatabase() async {
    final path = await getDatabasesPath();
    _database = await openDatabase(
      join(path, 'my_database46.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE schedule_table(id INTEGER PRIMARY KEY, title TEXT, status TEXT, templates TEXT, howOften TEXT, assignee TEXT)', // add the date column to the table schema
        );
      },
      version:
          6, // increment the database version to trigger the onCreate callback
    );

    final formData = await _database.query('schedule_table');
    setState(() {
      _formData = formData;
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
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          toolbarHeight: 110,
          leadingWidth: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: Text(
                    "Back",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).primaryColor),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Build Your Schedule",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "Take control of your day",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            child: Form(
              key: _createmyscheduleKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Templates",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField<String>(
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.green),
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      labelText: 'Add Templates',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedTemplates,
                    onChanged: (String? selectedValue) {
                      setState(() {
                        _selectedTemplates = selectedValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a value';
                      }
                      return null;
                    },
                    items: _valuesTemplates
                        .map(
                          (value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    "Site",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField<String>(
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.green),
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      labelText: 'Select Site',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedSite,
                    onChanged: (String? selectedValue) {
                      setState(() {
                        _selectedSite = selectedValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a value';
                      }
                      return null;
                    },
                    items: _valuesSite
                        .map(
                          (value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    "Assignee to",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField<String>(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      labelText: 'Add Assignee',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedAssignee,
                    onChanged: (String? selectedValue) {
                      setState(() {
                        _selectedAssignee = selectedValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a value';
                      }
                      return null;
                    },
                    items: _valuesAssignee
                        .map(
                          (value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    "How often",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField<String>(
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.green),
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      labelText: 'Everyday',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedHowOften,
                    onChanged: (String? selectedValue) {
                      setState(() {
                        _selectedHowOften = selectedValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select Time Line';
                      }
                      return null;
                    },
                    items: _valuesPriority
                        .map(
                          (value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  /*SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 1.1 / 3,
                        height: 56,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DateTimePicker(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.calendar_today_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            labelText: 'From',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                          initialValue: DateTime.now().toString(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          onChanged: (val) => print(val),
                          validator: (val) {
                            print(val);
                            return null;
                          },
                          onSaved: (val) => print(val),
                        ),
                      ),
                      Text("~"),
                      Container(
                        width: MediaQuery.of(context).size.width * 1.1 / 3,
                        height: 56,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DateTimePicker(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.calendar_today_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                            labelText: 'To',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                          initialValue: DateTime.now().toString(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          onChanged: (val) => print(val),
                          validator: (val) {
                            print(val);
                            return null;
                          },
                          onSaved: (val) => print(val),
                        ),
                      ),
                    ],
                  ),*/
                  SizedBox(
                    height: 17,
                  ),
                  Divider(
                    thickness: 0.5,
                    height: 0.1,
                    color: Colors.deepPurple.shade100,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CheckboxListTile(
                    title: Text(
                      'Allow Inspection to be submitted after the due date',
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _isChecked!,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Enter Title',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 17,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 1 / 4,
                  child: ElevatedButton(
                      child: Text('Create'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () async {
                        _saveData(context);
                      }),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 1 / 4,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => schedulepage()));
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.black26, width: 1),
                        ),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
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
