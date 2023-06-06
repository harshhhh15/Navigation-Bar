import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/user_drawer.dart';

import 'ScheduleCreate.dart';
import 'learnhowtoschedule.dart';

class schedulepage extends StatefulWidget {
  const schedulepage({Key? key}) : super(key: key);

  @override
  State<schedulepage> createState() => _schedulepageState();
}

class _schedulepageState extends State<schedulepage> {
  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  late Database _database;
  List<Map<String, dynamic>> _formData = [];

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

  Future<void> _deleteData(int id) async {
    await _database.delete(
      'schedule_table',
      where: 'id = ?',
      whereArgs: [id],
    );

    final formData = await _database.query('schedule_table');
    setState(() {
      _formData = formData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
// ----------------------------------------------------------------------------------------------------------------------  App Bar   -------------------------------------------------------------------------------------------------------------------------------------------

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
          toolbarHeight: 74,
          leadingWidth: double.infinity,
          titleSpacing: 0,
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 18,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Schedule",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => user_drawer()));
                      },
                      icon: Icon(
                        Icons.home,
                        color: Colors.deepPurple,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),

// ----------------------------------------------------------------------------------------------------------------------  Tab Bar   -------------------------------------------------------------------------------------------------------------------------------------------

          bottom: TabBar(
            labelPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
            labelColor: Colors.white,
            indicatorPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(12), // Creates border
                color: Theme.of(context).primaryColor),
            unselectedLabelColor: Colors.deepPurple.shade400,
            tabs: [
              Tab(
                child: Text(
                  "My Shedule",
                  style: TextStyle(fontSize: 14, letterSpacing: 0.6),
                ),
              ),
              Tab(
                child: Text(
                  textAlign: TextAlign.center,
                  "Manage",
                  style: TextStyle(fontSize: 14, letterSpacing: 0.6),
                ),
              ),
              Tab(
                child: Text(
                  textAlign: TextAlign.center,
                  "Missed",
                  style: TextStyle(fontSize: 14, letterSpacing: 0.6),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
// ----------------------------------------------------------------------------------------------------------------------  Tab Bar View 1  -------------------------------------------------------------------------------------------------------------------------------------------

            Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            cursorColor: Theme.of(context).primaryColor,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).primaryColor,
                              ),
                              hintText: "Search",
                              filled: true,
                              focusColor: Theme.of(context).primaryColor,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // add your button press logic here
                            },
                            icon: Icon(Icons.add),
                            label: Text('Filter'),
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
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _formData.length,
                          itemBuilder: (context, index) {
                            final data = _formData[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 8),
                                  child: ListTile(
                                    title: Text(
                                      "SCHEDULE : " + data['id'].toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.api,
                                                size: 16,
                                                color: Colors.deepPurple[600],
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "Title : " + data['title'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.build_circle_outlined,
                                                size: 16,
                                                color: Colors.deepPurple[600],
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "Site : " + data['status'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.book_outlined,
                                                size: 16,
                                                color: Colors.deepPurple[600],
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "Templates : " +
                                                    data['templates'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.timer_sharp,
                                                size: 16,
                                                color: Colors.deepPurple[600],
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "How often : " +
                                                    data['howOften'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.person_2_outlined,
                                                size: 16,
                                                color: Colors.deepPurple[600],
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "Assignee : " +
                                                    data['assignee'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),

                                          /*Row(
                                            children: [
                                              Text("From:"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("To:"),
                                            ],
                                          ),*/
                                        ],
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 26,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Are you sure?'),
                                              content: const Text(
                                                  'This will delete all data.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    await _deleteData(
                                                        data['id']);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  )),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

// ----------------------------------------------------------------------------------------------------------------------  Tab Bar View 2  -------------------------------------------------------------------------------------------------------------------------------------------

            Container(
              height: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Container(
                            height: 300,
                            child: Image(
                                image:
                                    AssetImage("assets/images/schedule.png"))),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Automate your inspection reminders",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Create schedules to ensure your team members start and complete inspections within definedtimeframes.",
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
                              'Learn more',
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HowtoSchedulePage()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

// ----------------------------------------------------------------------------------------------------------------------  Tab Bar View 3  -------------------------------------------------------------------------------------------------------------------------------------------

            Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Missed Schedule',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'We apologize for the inconvenience.You have missed a scheduled task or event.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Please take note of the following:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    ListTile(
                      leading: Icon(Icons.warning),
                      title: Text(
                        'Importance',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        'The missed schedule may have had significance in your personal or professional life. It is important to evaluate the impact and determine if any actions need to be taken.',
                        style: TextStyle(height: 1.3),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    ListTile(
                      leading: Icon(Icons.calendar_today),
                      title: Text(
                        'Rescheduling',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        'If possible, consider rescheduling the missed task or event to ensure it is addressed in the future. Learn from the experience and make adjustments to prevent similar occurrences.',
                        style: TextStyle(height: 1.3),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    ListTile(
                      leading: Icon(Icons.priority_high),
                      title: Text(
                        'Prioritization',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        'Reflect on your current commitments and prioritize tasks to prevent further missed schedules. Effective time management and organization can help avoid such situations.',
                        style: TextStyle(height: 1.3),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'We encourage you to stay proactive and make necessary arrangements to prevent missed schedules in the future.',
                      style: TextStyle(fontSize: 16.0, height: 1.3),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'add',
          elevation: 0,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => schedulecreate()));
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
