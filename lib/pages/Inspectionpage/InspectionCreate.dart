import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../ADMIN/Add_Site.dart';
import '../Inspectionpage/showaddedmedia.dart';
import 'InspectionMain.dart';

class inspectioncreatepage extends StatefulWidget {
  const inspectioncreatepage({Key? key}) : super(key: key);

  @override
  State<inspectioncreatepage> createState() => _inspectioncreatepageState();
}

class _inspectioncreatepageState extends State<inspectioncreatepage> {
  final _fKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionsController = TextEditingController();
  final _creatorController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  late Database _database;
  List<Map<String, dynamic>> _formData = [];

  String? _selectedValue;
  List<String> _values = ['In Process', 'Completed'];

  String? _selectedSite;
  List<String> _valuesSite = ['Site 1', 'Site 2', 'Site 3'];

  Future<void> _saveData(BuildContext context) async {
    if (_fKey.currentState!.validate()) {
      final title = _titleController.text;
      final descriptions = _descriptionsController.text;
      final creator = _creatorController.text;
      final note = _noteController.text;
      final status = _selectedValue;
      final site = _selectedSite;
      // get the selected date

      await _database.insert(
        'inspection_table',
        {
          'title': title,
          'descriptions': descriptions,
          'creator': creator,
          'status': status,
          'site': site,
          'note': note,
          // save the selected date in the database
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // clear the input fields and reset selected values
      _titleController.clear();
      _descriptionsController.clear();
      _creatorController.clear();
      _noteController.clear();
      _selectedValue = null;
      _selectedSite = null;

      // update the form data and reset the selected date
      final formData = await _database.query('inspection_table');
      setState(() {
        _formData = formData;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Inspection Status'),
            content: Text('Inspection created successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {});
                  Navigator.pop(context);
                  // Reset feedback form
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => inspectionpage()));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _initDatabase() async {
    final path = await getDatabasesPath();
    _database = await openDatabase(
      join(path, 'my_database45.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE inspection_table(id INTEGER PRIMARY KEY, title TEXT, descriptions TEXT, creator TEXT, status TEXT, site TEXT, note TEXT)', // add the date column to the table schema
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
                  Navigator.pop(context);
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
                      "Create Inspection",
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
                    controller: _titleController,
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
                      hintText: "Description",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Creator';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.sentences,
                    controller: _creatorController,
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
                          validator: (String? value) {
                            if (value == null) {
                              return 'Please select Category';
                            }
                            return null;
                          },
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.green),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.deepPurple),
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
                    validator: (String? value) {
                      if (value == null) {
                        return 'Please select Category';
                      }
                      return null;
                    },
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

                  /*DropdownButtonFormField<String>(
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
                  ),*/
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                    controller: _noteController,
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
                            width: 2, color: Colors.deepOrange.shade900),
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
                      child: Text(
                        'CREATE',
                        style: TextStyle(letterSpacing: 3),
                      ),
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
