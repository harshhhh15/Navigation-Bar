import 'dart:async';
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/Inspectionpage/showaddedmedia.dart';

import 'TryAddNote.dart';

// ----------------------------------------------------------------------------------------------------------------------  START -------------------------------------------------------------------------------------------------------------------------------------------

class turnoverpage extends StatefulWidget {
  const turnoverpage({Key? key}) : super(key: key);

  @override
  State<turnoverpage> createState() => _turnoverpageState();
}

class _turnoverpageState extends State<turnoverpage> {
  // -------------------------------------------------------------------------------------------------------------------  Location mate-------------------------------------------------------------------------------------------------------------------------------------------
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  String? _currentAddress;
  Position? _currentPosition;

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

  // -------------------------------------------------------------------------------------------------------------  Note na database -------------------------------------------------------------------------------------------------------------------------------------------

  late Database _note_database;
  List _note_formData = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final path = await getDatabasesPath();
    _note_database = await openDatabase(
      join(path, 'my_database10.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE _note_table(id INTEGER PRIMARY KEY, note TEXT)',
        );
      },
      version: 1,
    );

    final formData = await _note_database.query('_note_table');
    setState(() {
      _note_formData = formData;
    });
  }

  Future<void> _updateNote(int id, String note) async {
    await _note_database.update(
      '_note_table',
      {'note': note},
      where: 'id = ?',
      whereArgs: [id],
    );
    final formData = await _note_database.query('_note_table');
    setState(() {
      _note_formData = formData;
    });
  }

  Future<void> _deleteData(int id) async {
    await _note_database.delete(
      '_note_table',
      where: 'id = ?',
      whereArgs: [id],
    );

    final formData = await _note_database.query('_note_table');
    setState(() {
      _note_formData = formData;
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
// ----------------------------------------------------------------------------------------------------------------------   BUILD START   -------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  bool _isShow = false;

// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();
    _controller.text = 'LAT: ${_currentPosition?.latitude ?? ""}\n' +
        'LNG: ${_currentPosition?.longitude ?? ""}\n' +
        'ADDRESS: ${_currentAddress ?? ""}';

    return Scaffold(
// --------------------------------------------------------------------------------------------------------------   APPBAR   -------------------------------------------------------------------------------------------------------------------------------------------

      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).primaryColor,
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leadingWidth: 90,
        toolbarHeight: 70,
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(primary: Colors.deepPurple),
            child: Text(
              "Close",
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).primaryColor),
            )),
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.normal),
        title: Container(
          height: 35,
          width: 100,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Title Page",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  Text(
                    "Page 1/2",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {},
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.black26,
                    size: 14,
                  ))
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {},
              splashColor: Colors.deepPurple.shade100,
              icon: Icon(
                Icons.more_horiz,
                color: Theme.of(context).primaryColor,
                size: 38,
              ),
            ),
          )
        ],
      ),

// --------------------------------------------------------------------------------------------------------------   BODY   -------------------------------------------------------------------------------------------------------------------------------------------

      body: Container(
        color: Colors.purple.shade50,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 1, left: 16, right: 16, bottom: 1),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 10),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
// --------------------------------------------------------------------------------------------------------------   DETAILS   -------------------------------------------------------------------------------------------------------------------------------------------
                          Text(
                            "Details",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            cursorColor: Theme.of(context).primaryColor,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.handyman_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                              hintText: "Title",
                              focusColor: Theme.of(context).primaryColor,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: true,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _note_formData.length,
                                itemBuilder: (context, index) {
                                  final data = _note_formData[index];
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      addnotepage()));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.deepPurple),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                          ),
                                          child: ListTile(
                                            leading: Text(
                                              data['id'].toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.deepPurple),
                                            ),
                                            title: Text(
                                              data['note'],
                                              style: TextStyle(
                                                  color: Colors.deepPurple),
                                            ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        String newNote =
                                                            data['note'];
                                                        return AlertDialog(
                                                          title:
                                                              Text('Edit Note'),
                                                          content: TextField(
                                                            controller:
                                                                TextEditingController()
                                                                  ..text = data[
                                                                      'note'],
                                                            onChanged:
                                                                (value) =>
                                                                    newNote =
                                                                        value,
                                                          ),
                                                          actions: [
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                  'Cancel'),
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                _updateNote(
                                                                    data['id'],
                                                                    newNote);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text('Save'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () async {
                                                    await _deleteData(
                                                            data['id'])
                                                        .then((value) {
                                                      setState(() {
                                                        // Remove the deleted item from the state to trigger a rebuild of the ListView
                                                        _note_formData
                                                            .removeAt(index);
                                                      });
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.redAccent,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                },
                              ),
                            ),
                            replacement: SizedBox.shrink(),
                          ),
                          FutureBuilder<List<String>>(
                            future:
                                DatabaseHelperphotos.instance.getAllPhotos(),
                            builder: (BuildContext context, snapshot) {
                              final imagePaths = snapshot.data;
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                // Display a ListView of images if the data is not empty
                                return Container(
                                  height: 100,
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: imagePaths!.length,
                                    itemBuilder: (context, index) {
                                      final file = File(imagePaths[index]);
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 4),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        showaddedpic(
                                                            thumbnail: file)));
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Image.file(
                                                file,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                // Display a message if the data is empty
                                return SizedBox.shrink();
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    if (_note_formData.isNotEmpty) {
                                      setState(
                                        () {
                                          _isShow = !_isShow;
                                        },
                                      );
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  addnotepage()));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  addnotepage()));
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                      primary: Colors.deepPurple),
                                  child: Text(
                                    "Add Note",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Theme.of(context).primaryColor),
                                  )),
                              TextButton.icon(
                                onPressed: () {
                                  _pickImage();
                                },
                                label: Text(
                                  "Media",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context).primaryColor),
                                ),
                                style: TextButton.styleFrom(
                                    primary: Colors.deepPurple),
                                icon: Icon(
                                  Icons.collections,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                label: Text(
                                  "Action",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context).primaryColor),
                                ),
                                style: TextButton.styleFrom(
                                    primary: Colors.deepPurple),
                                icon: Icon(
                                  Icons.library_add_check,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

// --------------------------------------------------------------------------------------------------------------   CONDUCTED ON   -------------------------------------------------------------------------------------------------------------------------------------------

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 10),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Conducted on",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.deepPurple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
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
                              dateLabelText: 'Date',
                              onChanged: (val) => print(val),
                              validator: (val) {
                                print(val);
                                return null;
                              },
                              onSaved: (val) => print(val),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                addnotepage()));
                                  },
                                  style: TextButton.styleFrom(
                                      primary: Colors.deepPurple),
                                  child: Text(
                                    "Add Note",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Theme.of(context).primaryColor),
                                  )),
                              TextButton.icon(
                                onPressed: () {},
                                label: Text(
                                  "Media",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context).primaryColor),
                                ),
                                style: TextButton.styleFrom(
                                    primary: Colors.deepPurple),
                                icon: Icon(
                                  Icons.collections,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                label: Text(
                                  "Action",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context).primaryColor),
                                ),
                                style: TextButton.styleFrom(
                                    primary: Colors.deepPurple),
                                icon: Icon(
                                  Icons.library_add_check,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
// --------------------------------------------------------------------------------------------------------------   PREPARED BY   -------------------------------------------------------------------------------------------------------------------------------------------

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 10),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Prepared by",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            maxLines: null,
                            cursorColor: Theme.of(context).primaryColor,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.handyman_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                              hintText: "Carl Pineaha",
                              focusColor: Theme.of(context).primaryColor,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      primary: Colors.deepPurple),
                                  child: Text(
                                    "Add Note",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Theme.of(context).primaryColor),
                                  )),
                              TextButton.icon(
                                onPressed: () {},
                                label: Text(
                                  "Media",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context).primaryColor),
                                ),
                                style: TextButton.styleFrom(
                                    primary: Colors.deepPurple),
                                icon: Icon(
                                  Icons.collections,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                label: Text(
                                  "Action",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context).primaryColor),
                                ),
                                style: TextButton.styleFrom(
                                    primary: Colors.deepPurple),
                                icon: Icon(
                                  Icons.library_add_check,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

// --------------------------------------------------------------------------------------------------------------   LOCATION   -------------------------------------------------------------------------------------------------------------------------------------------

                Stack(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 20, bottom: 10),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Location",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 56),
                                child: TextFormField(
                                  // controller: TextEditingController(text: "C"),
                                  controller: _controller,
                                  // initialValue:
                                  //     'ADDRESS: ${_currentAddress ?? ""}',
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
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                          primary: Colors.deepPurple),
                                      child: Text(
                                        "Add Note",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color:
                                                Theme.of(context).primaryColor),
                                      )),
                                  TextButton.icon(
                                    onPressed: () {},
                                    label: Text(
                                      "Media",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    style: TextButton.styleFrom(
                                        primary: Colors.deepPurple),
                                    icon: Icon(
                                      Icons.collections,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {},
                                    label: Text(
                                      "Action",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    style: TextButton.styleFrom(
                                        primary: Colors.deepPurple),
                                    icon: Icon(
                                      Icons.library_add_check,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 56,
                      child: Container(
                        width: 50,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                                primary: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: _getCurrentPosition,
                            child: Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 30,
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                /* Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _note_formData.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = _note_formData[index];
                  return Dismissible(
                    key: Key(item.id.toString()), // Assumes that the ID of each item is unique and of type int.
                    onDismissed: (direction) async {
                      await databaseHelper.deleteData(item.id); // Deletes the item from the local database.
                      setState(() {
                        items.removeAt(index); // Removes the item from the list.
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Item dismissed')));
                    },
                    background: Container(color: Colors.red),
                    child: ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.subtitle),
                    ),
                  );
                },
              ),
            ),
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = items[index];
                      return Dismissible(
                        key: Key(item),
                        onDismissed: (direction) {
                          setState(() {
                            items.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$item dismissed')));
                        },
                        background: Container(
                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        child: ListTile(
                          title: Text('$item'),
                        ),
                      );
                    },
                  ),
                ),*/
                /*Text('LAT: ${_currentPosition?.latitude ?? ""}'),
                Text('LNG: ${_currentPosition?.longitude ?? ""}'),
                Text('ADDRESS: ${_currentAddress ?? ""}'),*/
              ],
            ),
          ),
        ),
      ),

// --------------------------------------------------------------------------------------------------------------   NAVIGATION BAR   -------------------------------------------------------------------------------------------------------------------------------------------

      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 35,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "Page 2/2",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

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

// --------------------------------------------------------------------------------------------------------------   BLANK   -------------------------------------------------------------------------------------------------------------------------------------------
