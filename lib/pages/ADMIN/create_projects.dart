import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/main.dart';

import 'Admin_Drawer.dart';

class add_projects extends StatefulWidget {
  const add_projects({Key? key}) : super(key: key);

  @override
  State<add_projects> createState() => _add_projectsState();
}

class _add_projectsState extends State<add_projects> {
  final _addprojectkey = GlobalKey<FormState>();
  final projectNameController = TextEditingController();
  final projectDetailsController = TextEditingController();
  final clientnameController = TextEditingController();
  final clientaddressController = TextEditingController();
  final clientnumberController = TextEditingController();
  final clientemailController = TextEditingController();
  final contactnameController = TextEditingController();
  final contactpersonphonecodeController = TextEditingController();
  final contactpersonnumberController = TextEditingController();
  final contactpersonemailController = TextEditingController();
  final notescontroller = TextEditingController();

  late Database _database;
  List<Map<String, dynamic>> _formData = [];

  String? _selectedCountrycode;
  String? _selectedCountrycodeContactperson;
  List<String> _valuesCountryCode = [
    '+1',
    '+44',
    '+91',
    '+971',
    '+972',
    '+973',
    '+974',
    '+975',
    '+976',
    '+977',
    '+98'
  ];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _saveData(BuildContext context) async {
    if (_addprojectkey.currentState!.validate()) {
      final projectname = projectNameController.text;
      final projectdetails = projectDetailsController.text;
      final clientname = clientnameController.text;
      final clientaddress = clientaddressController.text;
      final clientphonecode = _selectedCountrycode;

      final clientnumber = clientnumberController.text;
      final clientemail = clientemailController.text;
      final contactname = contactnameController.text;
      final contactpersonphonecode = _selectedCountrycodeContactperson;
      final contactpersonnumber = contactpersonnumberController.text;
      final contactpersonemail = contactpersonemailController.text;
      final note = notescontroller.text;
      final createdDate = DateTime.now();
      final formattedDate = DateFormat('dd-MM-yyyy').format(createdDate);
// Create a new DateTime object with the current date and time
      await _database.insert(
        'my_project_table',
        {
          'projectname': projectname,
          'projectdetails': projectdetails,
          'clientname': clientname,
          'clientaddress': clientaddress,
          'clientphonecode': clientphonecode,
          'clientnumber': clientnumber,
          'clientemail': clientemail,
          'contactname': contactname,
          'contactpersonphonecode': contactpersonphonecode,
          'contactpersonnumber': contactpersonnumber,
          'contactpersonemail': contactpersonemail,
          'note': note,
          'created_on': formattedDate
              .toString(), // Save the created date in the database as a string
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Project Status'),
            content: Text('New Project created successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Reset feedback form
                  setState(() {});
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => admin_drawer()));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      // clear the input fields and reset selected values
      projectNameController.clear();
      projectDetailsController.clear();
      clientnameController.clear();
      clientaddressController.clear();
      clientnumberController.clear();
      clientemailController.clear();
      contactnameController.clear();
      contactpersonnumberController.clear();
      contactpersonemailController.clear();
      notescontroller.clear();
      _selectedCountrycode = null;
      _selectedCountrycodeContactperson = null;

      // update the form data and reset the selected date
      final formData = await _database.query('my_project_table');
      setState(() {
        _formData = formData;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('Data saved successfully.',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(10),
        ),
      );
    }
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
          title: Text('Create Project'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              )),
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
              key: _addprojectkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "PROJECT INFORMATION",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),

                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Project Name",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: projectNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Project Name is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: Theme.of(context).primaryColor)),
                      suffixIcon: Icon(
                        Icons.perm_identity,
                      ),
                      border: OutlineInputBorder(),
                      labelText: "Enter Project Name",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Project Details",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Project Details is required";
                      }
                      return null;
                    },
                    controller: projectDetailsController,
                    minLines: 3,
                    maxLines: null,
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      hintText: "Write here...",
                      focusColor: Theme.of(context).primaryColor,
                      contentPadding: EdgeInsets.all(14),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            width: 2, color: Colors.deepOrange.shade900),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),

// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  Form  -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "CLIENT INFORMATION",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),

                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Client Name",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: clientnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Client name is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: Theme.of(context).primaryColor)),
                      suffixIcon: Icon(
                        Icons.perm_identity,
                      ),
                      border: OutlineInputBorder(),
                      labelText: "Enter Client name",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Client Address",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Client Address";
                      }
                      return null;
                    },
                    controller: clientaddressController,
                    minLines: 3,
                    maxLines: null,
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      hintText: "Write here...",
                      focusColor: Theme.of(context).primaryColor,
                      contentPadding: EdgeInsets.all(14),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            width: 2, color: Colors.deepOrange.shade900),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Client Contact (Phone) ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 130,
                          child: DropdownButtonFormField<String>(
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.green),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.deepPurple),
                              labelText: 'Country Code',
                              border: OutlineInputBorder(),
                            ),
                            value: _selectedCountrycode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please select Country Code";
                              }
                              return null;
                            },
                            onChanged: (String? selectedValue) {
                              setState(() {
                                _selectedCountrycode = selectedValue;
                              });
                            },
                            items: _valuesCountryCode
                                .map(
                                  (value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style:
                                          TextStyle(color: Colors.deepPurple),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                            controller: clientnumberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a phone number.';
                              }

                              // This regular expression matches only digits
                              final RegExp digitRegex = RegExp(r'^[0-9]+$');

                              if (!digitRegex.hasMatch(value)) {
                                return 'Phone number can only contain digits.';
                              }

                              if (value.length < 8 || value.length > 15) {
                                return 'Phone number must be between 8 and 15 digits long.';
                              }

                              // If no error, return null
                              return null;
                            },
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Theme.of(context).primaryColor)),
                              suffixIcon: Icon(
                                Icons.phone,
                                color: Theme.of(context).primaryColor,
                              ),
                              border: OutlineInputBorder(),
                              labelText: "Phone Number",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Client Contact (Email) ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: clientemailController,
                    validator: (input) {
                      return input!.isValidEmail()
                          ? null
                          : "Check your email address";
                    },
                    decoration: InputDecoration(
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor)),
                        suffixIcon: Icon(
                          Icons.mail_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Email Address"),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "CONTACT PERSON INFORMATION",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Contact Person",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: contactnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Full name is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: Theme.of(context).primaryColor)),
                      suffixIcon: Icon(
                        Icons.perm_identity,
                        color: Theme.of(context).primaryColor,
                      ),
                      border: OutlineInputBorder(),
                      labelText: "Full name",
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Contact Person (Phone)",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 130,
                        child: DropdownButtonFormField<String>(
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.green),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            labelText: 'Country Code',
                            border: OutlineInputBorder(),
                          ),
                          value: _selectedCountrycodeContactperson,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select Country Code";
                            }
                            return null;
                          },
                          onChanged: (String? selectedValue) {
                            setState(() {
                              _selectedCountrycodeContactperson = selectedValue;
                            });
                          },
                          items: _valuesCountryCode
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
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                          controller: contactpersonnumberController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a phone number.';
                            }

                            // This regular expression matches only digits
                            final RegExp digitRegex = RegExp(r'^[0-9]+$');

                            if (!digitRegex.hasMatch(value)) {
                              return 'Phone number can only contain digits.';
                            }

                            if (value.length < 8 || value.length > 15) {
                              return 'Phone number must be between 8 and 15 digits long.';
                            }

                            // If no error, return null
                            return null;
                          },
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).primaryColor)),
                            suffixIcon: Icon(
                              Icons.phone,
                              color: Theme.of(context).primaryColor,
                            ),
                            border: OutlineInputBorder(),
                            labelText: "Phone Number",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Client Contact (Email) ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: contactpersonemailController,
                    validator: (input) {
                      return input!.isValidEmail()
                          ? null
                          : "Check Contact Person email address";
                    },
                    decoration: InputDecoration(
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor)),
                        suffixIcon: Icon(
                          Icons.mail_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Email Address"),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Notes",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Notes";
                      }
                      return null;
                    },
                    controller: notescontroller,
                    minLines: 3,
                    maxLines: null,
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      hintText: "Write here...",
                      focusColor: Theme.of(context).primaryColor,
                      contentPadding: EdgeInsets.all(14),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            width: 2, color: Colors.deepOrange.shade900),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  Form  -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                ],
              ),
            ),
          ),
        ),
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
                      /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => admin_drawer()));
                      setState(() {
                        _initDatabase(); // Call _initDatabase() to reload the data from the database and update the UI
                      });*/
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'ADD PROJECTS',
                        style: TextStyle(letterSpacing: 1),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
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
