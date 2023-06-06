import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/Inspectionpage/turnoverpage.dart';

class actionaddnotepage extends StatefulWidget {
  actionaddnotepage({Key? key}) : super(key: key);

  @override
  State<actionaddnotepage> createState() => _actionaddnotepageState();
}

class _actionaddnotepageState extends State<actionaddnotepage> {
  final _notekey = GlobalKey<FormState>();
  final _note_controller = TextEditingController();

  late Database _note_database;
  List<Map<String, dynamic>> _note_formData = [];

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

  Future<void> _saveData() async {
    if (_notekey.currentState!.validate()) {
      final note = _note_controller.text;

      await _note_database.insert(
        '_note_table',
        {
          'note': note,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      _note_controller.clear();

      final formData = await _note_database.query('_note_table');
      setState(() {
        _note_formData = formData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Theme.of(context).primaryColor,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        toolbarHeight: 70,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => turnoverpage()));
            },
            icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).primaryColor)),
        centerTitle: true,
        title: Text(
          "Add Note",
          style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => turnoverpage()));
              },
              style: TextButton.styleFrom(primary: Colors.deepPurple),
              child: Text(
                "Done",
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).primaryColor),
              ))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                Form(
                  key: _notekey,
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Write Here",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter some Value";
                                    }
                                    return null;
                                  },
                                  controller: _note_controller,
                                  minLines: 10,
                                  maxLines: null,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  decoration: InputDecoration(
                                    hintText: "Add note",
                                    focusColor: Theme.of(context).primaryColor,
                                    contentPadding: EdgeInsets.all(14),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Colors.deepOrange.shade900),
                                    ),
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
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            child: Text(
                              'Save note',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            primary: Theme.of(context).primaryColor,
                            side:
                                BorderSide(color: Colors.transparent, width: 0),
                            textStyle: const TextStyle(
                              fontSize: 25,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                          ),
                          onPressed: () async {
                            if (_notekey.currentState!.validate()) {
                              return _saveData();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _note_formData.length,
                        itemBuilder: (context, index) {
                          final data = _note_formData[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 1,
                              child: ListTile(
                                leading: Text(data['id'].toString()),
                                title: Text(data['note']),
                                subtitle: Text(data.toString()),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            String newNote = data['note'];
                                            return AlertDialog(
                                              title: Text('Edit Note'),
                                              content: TextField(
                                                controller:
                                                    TextEditingController()
                                                      ..text = data['note'],
                                                onChanged: (value) =>
                                                    newNote = value,
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Cancel'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    _updateNote(
                                                        data['id'], newNote);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Save'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await _deleteData(data['id'])
                                            .then((value) {
                                          setState(() {
                                            // Remove the deleted item from the state to trigger a rebuild of the ListView
                                            _note_formData.removeAt(index);
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
                          );
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
