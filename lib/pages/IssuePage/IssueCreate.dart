import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/IssuePage/IssueDisplay.dart';

class createissue extends StatefulWidget {
  final String issueType;

  createissue({Key? key, required this.issueType}) : super(key: key);

  @override
  State<createissue> createState() => _createissueState();
}

class _createissueState extends State<createissue> {
  final _typeofissueKey = GlobalKey<FormState>();
  final titlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();

  late Database _database;
  List<Map<String, dynamic>> _formData = [];

  String? _selectedDueDate;
  DateTime? _selectedDue;

  String? _selectedCategory;
  List<String> _valuesCategory = [
    'observation',
    'Maintenance',
    'Incident',
    'Near Miss',
    'Hazard'
  ];

  String? _selectedStatus;
  List<String> _valuesStatus = ['Open', 'Close'];

  String? _selectedSite;
  List<String> _valuesSite = ['Site 1', 'Site 2', 'Site 3'];

  String? _selectedAssignee;
  List<String> _valuesAssignee = ['Assignee 1', 'Assignee 2', 'Assignee 3'];

  String? _selectedPriority;
  List<String> _valuesPriority = ['Low', 'Normal', 'High'];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _saveData(BuildContext context) async {
    if (_typeofissueKey.currentState!.validate()) {
      final title = titlecontroller.text;
      final description = descriptioncontroller.text;
      final status = _selectedStatus;
      final category = _selectedCategory;
      final site = _selectedSite;
      final assignee = _selectedAssignee;
      final priority = _selectedPriority;
      final duedate = _selectedDueDate;

      await _database.insert(
        'my_issuetable',
        {
          'title': title,
          'description': description,
          'status': status,
          'category': category,
          'site': site,
          'assignee': assignee,
          'priority': priority,
          'duedate': duedate,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Report Issue'),
            content: Text('Issue reported successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Reset feedback form
                  setState(() {});
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => issuepagescreen2()));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      titlecontroller.clear();
      descriptioncontroller.clear();
      _selectedStatus == null;
      _selectedCategory == null;
      _selectedSite == null;
      _selectedAssignee == null;
      _selectedPriority == null;
      _selectedDueDate == null;

      final formData = await _database.query('inspection_table');
      setState(() {
        _formData = formData;
      });
    }
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
                      "Type of Issue : ${widget.issueType}",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
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
              vertical: 10,
            ),
            child: Form(
              key: _typeofissueKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: titlecontroller,
                    maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Title';
                      }
                      return null;
                    },
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22),
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Title",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black26)),
                  ),
                  TextFormField(
                    controller: descriptioncontroller,
                    maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).primaryColor,
                        fontSize: 16),
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Description",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black26)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Status",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.green),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor),
                            labelText: 'Select Status',
                            border: OutlineInputBorder(),
                          ),
                          value: _selectedStatus,
                          onChanged: (String? selectedValue) {
                            setState(() {
                              _selectedStatus = selectedValue;
                            });
                          },
                          validator: (String? value) {
                            if (value == null) {
                              return 'Please select a Status';
                            }
                            return null;
                          },
                          items: _valuesStatus
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
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            // add your button press logic here
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 1.0),
                            child: Text('Resolve'),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Details",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField<String>(
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.green),
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      labelText: 'Select Category',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedCategory,
                    onChanged: (String? selectedValue) {
                      setState(() {
                        _selectedCategory = selectedValue;
                      });
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select Category';
                      }
                      return null;
                    },
                    items: _valuesCategory
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
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                    style: TextStyle(
                        fontSize: 18,
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
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select Site';
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
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.green),
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
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select Assignee';
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
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.green),
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      labelText: 'Add Priority',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedPriority,
                    onChanged: (String? selectedValue) {
                      setState(() {
                        _selectedPriority = selectedValue;
                      });
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select Priority';
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
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Due Date',
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.calendar_today),
                    ),
                    value: _selectedDueDate,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedDueDate = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select Due date';
                      }
                      return null;
                    },
                    items: List<DropdownMenuItem<String>>.generate(
                      7,
                      (index) => DropdownMenuItem<String>(
                        value: DateFormat('EEE, MMM d, yyyy').format(
                          DateTime.now().add(
                            Duration(days: index),
                          ),
                        ),
                        child: Text(
                          DateFormat('EEE, MMM d, yyyy').format(
                            DateTime.now().add(
                              Duration(days: index),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                    ],
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _saveData(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('Submit'),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // handle button press
                    },
                    icon: Icon(Icons.download),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 2),
                      child: Text('PDF'),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      // set button background color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // set border radius
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 2),
                      child: Text(
                        'View Report',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      primary: Colors.transparent,
                      onPrimary: Theme.of(context).primaryColor,
                      side: BorderSide(color: Colors.grey, width: 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    onPressed: () {},
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
