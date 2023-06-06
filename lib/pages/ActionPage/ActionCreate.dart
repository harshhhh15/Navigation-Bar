import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/ActionPage/ActionDisplay.dart';

import '../ADMIN/Add_Site.dart';
import '../Inspectionpage/showaddedmedia.dart';

class actioncreatepage extends StatefulWidget {
  const actioncreatepage({Key? key}) : super(key: key);

  @override
  State<actioncreatepage> createState() => _actioncreatepageState();
}

class _actioncreatepageState extends State<actioncreatepage> {
  final _fKey = GlobalKey<FormState>();
  final titlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  final notecontroller = TextEditingController();
  final createdbycontroller = TextEditingController();

  late Database _note_database;
  List<Map<String, dynamic>> _note_formData = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  String? _selectedStatus;
  List<String> _values = ['Created', 'In Process', 'Completed'];

  String? _selectedSite;
  List<String> _valuesSite = ['Site 1', 'Site 2', 'Site 3'];

  String? _selectedAssignee;
  List<String> _valuesAssignee = ['Assignee 1', 'Assignee 2', 'Assignee 3'];

  String? _selectedPriority;
  List<String> _valuesPriority = ['Low', 'Normal', 'High', 'Urgent'];

  String? _selectedlabel;
  List<String> _valueslabel = ['label 1', 'label 2', 'label 3'];

  late Database _database;
  List<Map<String, dynamic>> _formData = [];

  late Database action_database;
  List action_data_storage = [];

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
    });
  }

  Future<void> _saveData(BuildContext context) async {
    if (_fKey.currentState!.validate()) {
      final title = titlecontroller.text;
      final description = descriptioncontroller.text;
      final createdby = createdbycontroller.text;
      final note = notecontroller.text;
      final status = _selectedStatus;
      final site = _selectedSite;
      final assignee = _selectedAssignee;
      final priority = _selectedPriority;
      final label = _selectedlabel;
      final duedate = _selectedDueDate;

      await _database.insert(
        'my_table',
        {
          'title': title,
          'description': description,
          'createdby': createdby,
          'status': status,
          'site': site,
          'assignee': assignee,
          'priority': priority,
          'label': label,
          'duedate': duedate,
          'note': note,
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
                          builder: (context) => actionscreen2display()));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      titlecontroller.clear();
      descriptioncontroller.clear();
      createdbycontroller.clear();
      notecontroller.clear();
      _selectedStatus = null;
      _selectedSite = null;
      _selectedAssignee = null;
      _selectedPriority = null;
      _selectedlabel = null;
      _selectedDueDate = null;

      final formData = await _database.query('my_table');
      setState(() {
        _formData = formData;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data saved successfully.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  String? _selectedDueDate;
  DateTime? _selectedDue;

// ----------------------------------------------------------------------------------------------------------  Image Pick karava mate-------------------------------------------------------------------------------------------------------------------------------------------

  final picker = ImagePicker();

  void _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imagePath = pickedFile.path;
      await DatabaseHelperphotos.instance.insertPhoto(imagePath);
      setState(() {});
    }
  }

// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  AppBar  -------------------------------------------------------------------------------------------------------------------------------------------
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
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 100,
          leadingWidth: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => actionscreen2display()));
                },
                style: TextButton.styleFrom(primary: Colors.deepPurple),
                child: Text(
                  "Back",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Action",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 7),
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
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  Form  -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

            child: Form(
              key: _fKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: titlecontroller,
                    maxLines: 1,
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
                        hintText: "Title",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black26)),
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
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
                      fontSize: 18,
                    ),
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      suffixIcon: SizedBox(
                        width: 0,
                        child: Icon(Icons.edit),
                      ),
                      border: InputBorder.none,
                      hintText: "Description",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: createdbycontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Creator name';
                      }
                      return null;
                    },
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 18),
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.person_outline,
                        ),
                        border: InputBorder.none,
                        hintText: "Created by",
                        hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54)),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    "Status",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.green),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            labelText: 'Select Status',
                            border: OutlineInputBorder(),
                          ),
                          value: _selectedStatus,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select Status";
                            }
                            return null;
                          },
                          onChanged: (String? selectedValue) {
                            setState(() {
                              _selectedStatus = selectedValue;
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
                                const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Text('Complete'),
                          ),
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
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      labelText: 'Select Site',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedSite,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select Site";
                      }
                      return null;
                    },
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
                              style: TextStyle(color: Colors.deepPurple),
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
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      labelText: 'Add Assignee',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedAssignee,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select Assignee to";
                      }
                      return null;
                    },
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
                              style: TextStyle(color: Colors.deepPurple),
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
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      labelText: 'Add Priority',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedPriority,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select Priority";
                      }
                      return null;
                    },
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
                              style: TextStyle(color: Colors.deepPurple),
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
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      labelText: 'Add label',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedlabel,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select Label";
                      }
                      return null;
                    },
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
                              style: TextStyle(color: Colors.deepPurple),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select Due data";
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      setState(() {
                        _selectedDueDate = value!;
                      });
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
                    height: 16,
                  ),
                  Text(
                    "Add Note",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter some Value";
                      }
                      return null;
                    },
                    controller: notecontroller,
                    minLines: 10,
                    maxLines: null,
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      hintText: "Add note",
                      focusColor: Theme.of(context).primaryColor,
                      contentPadding: EdgeInsets.all(14),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 1, color: Colors.deepOrange.shade900),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            width: 1, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Add Media",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _pickImage();
                    },
                    label: Text(
                      "Add Media",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).primaryColor),
                    ),
                    style: TextButton.styleFrom(primary: Colors.deepPurple),
                    icon: Icon(
                      Icons.collections,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  FutureBuilder<List<String>>(
                    future: DatabaseHelperphotos.instance.getAllPhotos(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.hasData) {
                        return CarouselSlider(
                          items: snapshot.data!.map((photoPath) {
                            return GestureDetector(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.file(
                                  File(photoPath),
                                  width: 700,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => showaddedpic(
                                        thumbnail: File(photoPath)),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            height: 200,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            reverse: false,
                            aspectRatio: 5.0,
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  SizedBox(
                    height: 17,
                  ),
                ],
              ),
            ),
          ),
        ),

// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  BottomNavigationBar  -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
                      child: Text('Submit'),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
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
