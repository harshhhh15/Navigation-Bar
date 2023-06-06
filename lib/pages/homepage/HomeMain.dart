import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trynav/pages/IssuePage/IssueMain.dart';
import 'package:trynav/pages/SchedulePage/ScheduleMain.dart';

import '../ActionPage/ActionMain.dart';
import '../SchedulePage/learnhowtoschedule.dart';
import 'LearnMoreIssue.dart';
import 'LearnMorePage.dart';
import 'notification.dart';

class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

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
        toolbarHeight: 100,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        final controller = ZoomDrawer.of(context);
                        controller?.toggle();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoNotificationsPage()));
                      },
                      icon: Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Home",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
      body: bodypart(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      floatingActionButton: FloatingActionButton(
        tooltip: 'add',
        elevation: 0,
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.transparent,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 18),
                                          primary: Colors.white,
                                          onPrimary: Colors.purple.shade100,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20)))),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    schedulepage()));
                                      },
                                      child: Text(
                                        "Create Schedule",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                            color:
                                                Theme.of(context).primaryColor),
                                      )),
                                ),
                                Divider(
                                  height: 5,
                                  thickness: 1,
                                  color: Colors.grey.shade200,
                                ),
                                Container(
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.transparent,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 18),
                                        primary: Colors.white,
                                        onPrimary: Colors.purple.shade100,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    actionpage()));
                                      },
                                      child: Text(
                                        "Create action",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                            color:
                                                Theme.of(context).primaryColor),
                                      )),
                                ),
                                Divider(
                                  height: 5,
                                  thickness: 1,
                                  color: Colors.grey.shade200,
                                ),
                                Container(
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.transparent,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 18),
                                          primary: Colors.white,
                                          onPrimary: Colors.purple.shade100,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20)))),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    issuepage()));
                                      },
                                      child: Text(
                                        "Report issue",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                            color:
                                                Theme.of(context).primaryColor),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    primary: Colors.white,
                                    onPrimary: Colors.purple.shade100,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context).primaryColor),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              });
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

class bodypart extends StatefulWidget {
  const bodypart({Key? key}) : super(key: key);

  @override
  State<bodypart> createState() => _bodypartState();
}

class _bodypartState extends State<bodypart> {
  late Database _invitation_database;
  List<Map<String, dynamic>> _invitation_formData = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final path = await getDatabasesPath();
    _invitation_database = await openDatabase(
      join(path, 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE _invitation_table(id INTEGER PRIMARY KEY, email TEXT)',
        );
      },
      version: 1,
    );

    final formData = await _invitation_database.query('_invitation_table');
    setState(() {
      _invitation_formData = formData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            /* Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Team",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  Text(
                    "8 free seats remaining",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                height: 90,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        children: [
                          Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.transparent,
                                  primary: Theme.of(context).primaryColor,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Icon(
                                  Icons.person_add_alt_1_rounded,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Wrap(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20))),
                                                        width: double.maxFinite,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      18.0),
                                                          child: Center(
                                                            child: Text(
                                                              "Invite New Team Members",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Divider(
                                                        height: 5,
                                                        thickness: 1,
                                                        color: Colors
                                                            .grey.shade200,
                                                      ),
                                                      Container(
                                                        width: double.maxFinite,
                                                        child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shadowColor: Colors
                                                                  .transparent,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          18),
                                                              primary:
                                                                  Colors.white,
                                                              onPrimary: Colors
                                                                  .purple
                                                                  .shade100,
                                                            ),
                                                            onPressed: () {
                                                              // Navigator.push(
                                                              //     context,
                                                              //     MaterialPageRoute(
                                                              //         builder:
                                                              //             (context) =>
                                                              //                 actionpage()));
                                                            },
                                                            child: Text(
                                                              "Invite via SMS",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                            )),
                                                      ),
                                                      Divider(
                                                        height: 5,
                                                        thickness: 1,
                                                        color: Colors
                                                            .grey.shade200,
                                                      ),
                                                      Container(
                                                        width: double.maxFinite,
                                                        child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                shadowColor: Colors
                                                                    .transparent,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            18),
                                                                primary: Colors
                                                                    .white,
                                                                onPrimary: Colors
                                                                    .purple
                                                                    .shade100,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.only(
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                20),
                                                                        bottomRight:
                                                                            Radius.circular(20)))),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              invitewithemail()));
                                                            },
                                                            child: Text(
                                                              "Invite via Email",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 18),
                                                          primary: Colors.white,
                                                          onPrimary: Colors
                                                              .purple.shade100,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20))),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Invite",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                letterSpacing: 1,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: _invitation_formData.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map data = _invitation_formData[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.transparent,
                                          primary: Colors.white,
                                          onPrimary:
                                              Theme.of(context).primaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                      onPressed: () {},
                                      child: Text(
                                        data['email'].toUpperCase()[0],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Schedule",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 20, top: 16, bottom: 14, left: 75),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Create schedules to ensure your team members start and complete inspections within defined timeframes. ",
                                  style: TextStyle(fontSize: 15, height: 1.8),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 2),
                                    child: Text(
                                      'Learn how to schedule',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    primary: Colors.transparent,
                                    onPrimary: Theme.of(context).primaryColor,
                                    side: BorderSide(
                                        color: Colors.grey, width: 1),
                                    textStyle: const TextStyle(
                                      fontSize: 25,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HowtoSchedulePage()));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 20,
                          top: 20,
                          child: CircleAvatar(
                            backgroundColor: Colors.purple.shade50,
                            radius: 20,
                            child: Icon(
                              Icons.date_range_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Actions",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 20, top: 16, bottom: 14, left: 75),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Assign tasks or follow - ups to the right person or team to get the job done",
                                  style: TextStyle(fontSize: 15, height: 1.8),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 13, horizontal: 2),
                                        child: Text(
                                          'Create action',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.transparent,
                                        primary: Colors.transparent,
                                        onPrimary:
                                            Theme.of(context).primaryColor,
                                        side: BorderSide(
                                            color: Colors.grey, width: 1),
                                        textStyle: const TextStyle(
                                          fontSize: 25,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    actionpage()));
                                      },
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    ElevatedButton(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 13, horizontal: 2),
                                        child: Text(
                                          'Learn More',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.transparent,
                                        primary: Colors.transparent,
                                        onPrimary:
                                            Theme.of(context).primaryColor,
                                        side: BorderSide(
                                            color: Colors.transparent,
                                            width: 0),
                                        textStyle: const TextStyle(
                                          fontSize: 25,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LearnMorePageActions()));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 20,
                          top: 20,
                          child: CircleAvatar(
                            backgroundColor: Colors.purple.shade50,
                            radius: 20,
                            child: Icon(
                              Icons.sell_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Issues",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 20, top: 16, bottom: 14, left: 75),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Capture issues and instantly notify the right people",
                                  style: TextStyle(fontSize: 15, height: 1.8),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 13, horizontal: 2),
                                        child: Text(
                                          'Report issue',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.transparent,
                                        primary: Colors.transparent,
                                        onPrimary:
                                            Theme.of(context).primaryColor,
                                        side: BorderSide(
                                            color: Colors.grey, width: 1),
                                        textStyle: const TextStyle(
                                          fontSize: 25,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    issuepage()));
                                      },
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    ElevatedButton(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 13, horizontal: 2),
                                        child: Text(
                                          'Learn More',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.transparent,
                                        primary: Colors.transparent,
                                        onPrimary:
                                            Theme.of(context).primaryColor,
                                        side: BorderSide(
                                            color: Colors.transparent,
                                            width: 0),
                                        textStyle: const TextStyle(
                                          fontSize: 25,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LearnMorePageIssue()));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 20,
                          top: 20,
                          child: CircleAvatar(
                            backgroundColor: Colors.purple.shade50,
                            radius: 20,
                            child: Icon(
                              Icons.error_outline_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
