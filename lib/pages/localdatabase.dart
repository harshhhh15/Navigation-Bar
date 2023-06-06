import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class errorpage extends StatefulWidget {
  const errorpage({Key? key}) : super(key: key);

  @override
  State<errorpage> createState() => _errorpageState();
}

class _errorpageState extends State<errorpage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionsController = TextEditingController();

  late Database _database;
  List _formData = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final path = await getDatabasesPath();
    _database = await openDatabase(
      join(path, 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE my_table(id INTEGER PRIMARY KEY, name TEXT, descriptions TEXT)',
        );
      },
      version: 1,
    );
    final formData = await _database.query('my_table');
    setState(() {
      _formData = formData;
    });
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;

      final descriptions = _descriptionsController.text;

      await _database.insert(
        'my_table',
        {
          'name': name,
          'descriptions': descriptions,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      _nameController.clear();
      _descriptionsController.clear();

      final formData = await _database.query('my_table');
      setState(() {
        _formData = formData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.grey,
                        )),
                    Text(
                      "Observation",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).primaryColor),
                    ),
                    TextButton(
                        onPressed: _saveData,
                        style: TextButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              color: Colors.black26),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Form(
                key: _formKey,
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
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 20),
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Add title",
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
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 16),
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Add description",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black26)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  label: Text(
                    "Media",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).primaryColor),
                  ),
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  icon: Icon(
                    Icons.image_sharp,
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
                      primary: Theme.of(context).primaryColor),
                  icon: Icon(
                    Icons.local_attraction,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: _formData.length,
                  itemBuilder: (context, index) {
                    final data = _formData[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  data['descriptions'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black26),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
