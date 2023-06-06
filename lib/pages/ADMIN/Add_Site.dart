import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/ADMIN/Admin_Drawer.dart';
import 'package:trynav/pages/Inspectionpage/showaddedmedia.dart';

class Add_Sites extends StatefulWidget {
  const Add_Sites({Key? key}) : super(key: key);

  @override
  State<Add_Sites> createState() => _Add_SitesState();
}

// ----------------------------------------------------------------------------------------------------------  Image DATABASE -------------------------------------------------------------------------------------------------------------------------------------------

class DatabaseHelperphotos {
  static final _databaseName = 'my_database9.db';
  static final _databaseVersion = 1;
  static final table = 'my_table';
  static final columnId = '_id';
  static final columnImagePath = 'image_path';

  // make this a singleton class
  DatabaseHelperphotos._privateConstructor();

  static final DatabaseHelperphotos instance =
      DatabaseHelperphotos._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // open the database
  _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnImagePath TEXT NOT NULL
          )
          ''');
  }

  // helper method to insert a photo
  Future<int> insertPhoto(String imagePath) async {
    final db = await database;
    return await db.insert(table, {columnImagePath: imagePath});
  }

  // helper method to retrieve all photos
  Future<List<String>> getAllPhotos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) => maps[i][columnImagePath]);
  }
}
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  START  -------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class _Add_SitesState extends State<Add_Sites> {
  final _fKey = GlobalKey<FormState>();
  final _SiteTitleController = TextEditingController();
  final _SitedescriptionsController = TextEditingController();
  final _SiteOwnerController = TextEditingController();
  final _locationcontroller = TextEditingController();

  String? _selectedStatus;
  List<String> _values = ['In Process', 'Complete'];

  String? _selectedPriority;
  List<String> _valuesPriority = ['Low', 'Medium', 'Hign'];

  String? _currentAddress;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _initDatabaseforsite();
  }

  late Database _sitedatabase;
  List<Map<String, dynamic>> _siteformData = [];

  late Database action_database;
  List action_data_storage = [];

  Future<void> _saveData(BuildContext context) async {
    if (_fKey.currentState!.validate()) {
      final title = _SiteTitleController.text;
      final description = _SitedescriptionsController.text;
      final siteowner = _SiteOwnerController.text;
      final status = _selectedStatus;
      final priority = _selectedPriority;
      final location = _locationcontroller.text;

      await _sitedatabase.insert(
        'my_table',
        {
          'title': title,
          'description': description,
          'siteowner': siteowner,
          'status': status,
          'priority': priority,
          'location': location,
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => admin_drawer()));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

      _SiteTitleController.clear();
      _SitedescriptionsController.clear();
      _SiteOwnerController.clear();
      _locationcontroller.clear();
      _selectedStatus = null;
      _selectedPriority = null;

      final formData = await _sitedatabase.query('my_table');
      setState(() {
        _siteformData = formData;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('Data saved Successfully.',
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

// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
          content: Text(
              'To continue, turn on device location, which uses location services')));

      AlertDialog(
        title: const Text('Add optional parameters'),
        content: Text(
            "To continue, turn on device location, which uses google's location services"),
        actions: <Widget>[
          TextButton(
            child: const Text('No, thanks'),
            onPressed: () {
              Navigator.of(context as BuildContext).pop();
            },
          ),
          TextButton(child: const Text('OK'), onPressed: () {}),
        ],
      );
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
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
    /*  _controller.text = ' ${_currentAddress ?? ""}';*/

    return SafeArea(
      child: Scaffold(
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  AppBar -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
          elevation: 0,
          toolbarHeight: 110,
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
                      "Add Sites",
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
          child: Column(
            children: [
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  FORM -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                child: Form(
                  key: _fKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: _SiteTitleController,
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
                            hintText: "Add Title",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black26)),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: _SitedescriptionsController,
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
                          hintText: "Add Description",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Site Owner';
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                        controller: _SiteOwnerController,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.person_outline,
                            ),
                            border: InputBorder.none,
                            hintText: "Add site owner",
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
                                labelText: 'Select Site',
                                border: OutlineInputBorder(),
                              ),
                              value: _selectedStatus,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please select Site";
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
                                shadowColor: Colors.transparent,
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
                        "Site Priority",
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
                          labelText: 'Select Priority',
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
                        height: 17,
                      ),
                      Text(
                        "Location",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: _locationcontroller,
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
                            hintText: "Add Location",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black26)),
                      ),

                      /*Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [

                                  TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please add Location';
                                    }
                                    return null;
                                  },
                                  controller: _controller,
                                  maxLines: null,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  decoration: InputDecoration(
                                    hintText: "Please Enter Address",
                                    focusColor: Theme.of(context).primaryColor,
                                    contentPadding: EdgeInsets.all(14),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    padding: EdgeInsets.zero,
                                    primary: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: _getCurrentPosition,
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          ),
                        ],
                      ),*/
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Add Images",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                      ),
                      SizedBox(
                        height: 17,
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
                    ],
                  ),
                ),
              ),

// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------  Image Slider  -------------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
                                builder: (context) =>
                                    showaddedpic(thumbnail: File(photoPath)),
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
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
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
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'ADD SITES',
                        style: TextStyle(letterSpacing: 1),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
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
