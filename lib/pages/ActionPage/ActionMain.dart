import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/ActionPage/ActionCreate.dart';

import '../user_settings.dart';
import 'ActionDisplay.dart';

class actionpage extends StatefulWidget {
  const actionpage({Key? key}) : super(key: key);

  @override
  State<actionpage> createState() => _actionpageState();
}

class _actionpageState extends State<actionpage> {
  final _fKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionsController = TextEditingController();
  final _creatorController = TextEditingController();
  final _labelController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  late Database _database;
  List _formData = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _saveData() async {
    if (_fKey.currentState!.validate()) {
      final name = _nameController.text;
      final descriptions = _descriptionsController.text;
      final creator = _creatorController.text;
      final label = _selectedValue;
      final date = _selectedDate.toString(); // get the selected date

      await _database.insert(
        'my_tablle',
        {
          'name': name,
          'descriptions': descriptions,
          'creator': creator,
          'label': label,
          'date': date, // save the selected date in the database
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // clear the input fields and reset selected values
      _nameController.clear();
      _descriptionsController.clear();
      _creatorController.clear();
      _selectedValue = null;
      _labelController.clear();

      // update the form data and reset the selected date
      final formData = await _database.query('my_tablle');
      setState(() {
        _formData = formData;
        _selectedDate = DateTime.now();
      });
    }
  }

  Future<void> _initDatabase() async {
    final path = await getDatabasesPath();
    _database = await openDatabase(
      join(path, 'my_database1.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE my_tablle(id INTEGER PRIMARY KEY, name TEXT, descriptions TEXT, creator TEXT, label TEXT, date TEXT)', // add the date column to the table schema
        );
      },
      version:
          6, // increment the database version to trigger the onCreate callback
    );

    final formData = await _database.query('my_tablle');
    setState(() {
      _formData = formData;
    });
  }

  String? _selectedValue;
  List<String> _values = ['In Process', 'Complete'];

  String? _selectedSite;
  List<String> _valuesSite = ['Site 1', 'Site 2', 'Site 3'];

  String? _selectedAssignee;
  List<String> _valuesAssignee = ['Assignee 1', 'Assignee 2', 'Assignee 3'];

  String? _selectedPriority;
  List<String> _valuesPriority = ['Low', 'Normal', 'High'];

  String? _selectedlabel;
  List<String> _valueslabel = ['label 1', 'label 2', 'label 3'];

  String? _selectedDatedue;
  List<String> _valuesDatedue = ['Datedue 1', 'Datedue 2', 'Datedue 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Theme.of(context).primaryColor,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        leadingWidth: double.infinity,
        backgroundColor: Colors.deepPurple,
        shadowColor: Colors.transparent,
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Actions",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()));
                        },
                        icon: Icon(Icons.settings))
                    /*TextButton.icon(
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
                        'Setting',
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
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                      height: 300,
                      child:
                          Image(image: AssetImage("assets/images/action.png"))),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Turn findings into actions",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 26),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "Drive resoluctions from findings and empower your team to flag tasks by assigning actions.",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 2),
                      child: Text(
                        'Create action',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      primary: Theme.of(context).primaryColor,
                      side: BorderSide(color: Colors.transparent, width: 0),
                      textStyle: const TextStyle(
                        fontSize: 25,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => actioncreatepage()));
                    },
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 2),
                      child: Text(
                        'View Action',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      primary: Theme.of(context).primaryColor,
                      side: BorderSide(color: Colors.transparent, width: 0),
                      textStyle: const TextStyle(
                        fontSize: 25,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => actionscreen2display()));
                    },
                  ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      floatingActionButton: FloatingActionButton(
        tooltip: 'add',
        elevation: 0,
        onPressed: () {
          showModalBottomSheet<void>(
            backgroundColor: Colors.white,
            context: context,
            isScrollControlled: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            builder: (BuildContext context) {
              return FractionallySizedBox(
                heightFactor: 0.9,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                        primary: Colors.deepPurple),
                                    child: Text(
                                      "Close",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white),
                                    )),
                                TextButton(
                                    onPressed: _saveData,
                                    style: TextButton.styleFrom(
                                        primary: Colors.deepPurple),
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20,
                                          color: Colors.white),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DateTimePicker(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.calendar_today_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            initialValue: DateTime.now().toString(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            // dateLabelText: 'Date',
                            onChanged: (val) => print(val),
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) => print(val),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 0),
                          child: Form(
                            key: _fKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: _nameController,
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
                                      fontSize: 20),
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                      suffixIcon: SizedBox(
                                        width: 0,
                                        child: Icon(Icons.edit),
                                      ),
                                      border: InputBorder.none,
                                      hintText: "Test Action",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black26)),
                                ),
                                TextFormField(
                                  controller: _descriptionsController,
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
                                    fontSize: 18,
                                  ),
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                    suffixIcon: SizedBox(
                                      width: 0,
                                      child: Icon(Icons.edit),
                                    ),
                                    border: InputBorder.none,
                                    hintText: "Do this and that",
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _creatorController,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18),
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.person_outline,
                                      ),
                                      border: InputBorder.none,
                                      hintText: "Prepared by",
                                      hintStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black54)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                Text(
                                  "Details",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DropdownButtonFormField<String>(
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.green),
                                  decoration: InputDecoration(
                                    labelStyle:
                                        TextStyle(color: Colors.deepPurple),
                                    labelText: 'Select Status',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: _selectedValue,
                                  onChanged: (String? selectedValue) {
                                    setState(() {
                                      _selectedValue = selectedValue;
                                    });
                                  },
                                  items: _values
                                      .map(
                                        (value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        ),
                                      )
                                      .toList(),
                                ),
                                Divider(
                                  thickness: 0.5,
                                  height: 0.1,
                                  color: Colors.deepPurple.shade100,
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                Text(
                                  "Details",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DropdownButtonFormField<String>(
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.green),
                                  decoration: InputDecoration(
                                    labelStyle:
                                        TextStyle(color: Colors.deepPurple),
                                    labelText: 'Select Site',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: _selectedSite,
                                  onChanged: (String? selectedValue) {
                                    setState(() {
                                      _selectedSite = selectedValue;
                                    });
                                  },
                                  items: _valuesSite
                                      .map(
                                        (value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                color: Colors.deepPurple),
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
                                        TextStyle(color: Colors.deepPurple),
                                    labelText: 'Add Assignee',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: _selectedAssignee,
                                  onChanged: (String? selectedValue) {
                                    setState(() {
                                      _selectedAssignee = selectedValue;
                                    });
                                  },
                                  items: _valuesAssignee
                                      .map(
                                        (value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                color: Colors.deepPurple),
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
                                        TextStyle(color: Colors.deepPurple),
                                    labelText: 'Add Priority',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: _selectedPriority,
                                  onChanged: (String? selectedValue) {
                                    setState(() {
                                      _selectedPriority = selectedValue;
                                    });
                                  },
                                  items: _valuesPriority
                                      .map(
                                        (value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                color: Colors.deepPurple),
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
                                        TextStyle(color: Colors.deepPurple),
                                    labelText: 'Add label',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: _selectedlabel,
                                  onChanged: (String? selectedValue) {
                                    setState(() {
                                      _selectedlabel = selectedValue;
                                    });
                                  },
                                  items: _valueslabel
                                      .map(
                                        (value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                color: Colors.deepPurple),
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
                                        TextStyle(color: Colors.deepPurple),
                                    labelText: 'Add Date Due',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: _selectedDatedue,
                                  onChanged: (String? selectedValue) {
                                    setState(() {
                                      _selectedDatedue = selectedValue;
                                    });
                                  },
                                  items: _valuesDatedue
                                      .map(
                                        (value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                color: Colors.deepPurple),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 0.5,
                          height: 0.1,
                          color: Colors.deepPurple.shade100,
                        ),
                        Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _formData.length,
                            itemBuilder: (builder, index) {
                              Map data = _formData[index];
                              return Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "name : " + data['name'],
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "descriptions : " + data['descriptions'],
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "creator : " + data['creator'],
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "label : " + data['label'],
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              );
                              /* ListTile(
                                          title: Text(
                                            data['name'],
                                            // "${data['email']}",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 18),
                                          ),
                                        );*/
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
