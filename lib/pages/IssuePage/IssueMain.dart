import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../user_settings.dart';
import 'IssueCreate.dart';
import 'IssueDisplay.dart';
import 'customizecategoriespage.dart';

class issuepage extends StatefulWidget {
  const issuepage({Key? key}) : super(key: key);

  @override
  State<issuepage> createState() => _issuepageState();
}

class _issuepageState extends State<issuepage> {
  @override
  void initState() {
    super.initState();
  }

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
        backgroundColor: Colors.deepPurple,
        shadowColor: Colors.transparent,
        toolbarHeight: 70,
        leadingWidth: double.infinity,
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
                      "Issue",
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
                    /* TextButton.icon(
                      onPressed: () {},
                      label: Text(
                        'Workflow',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.settings,
                          size: 25.0,
                          color: Colors.white,
                        ),
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
        height: double.infinity,
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
                          Image(image: AssetImage("assets/images/issue.png"))),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Raise issues anywhere",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 26),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "Capture the critical details as they happen for better issue investigation and analysis",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      primary: Theme.of(context).primaryColor,
                      side: BorderSide(color: Colors.transparent, width: 0),
                      textStyle: const TextStyle(
                        fontSize: 25,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1 / 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Report issues',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40))),
                        context: context,
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return Container(
                            height: 420,
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "What type of issue?",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      ListTile(
                                        title: Text('Observation'),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => createissue(
                                                  issueType: 'Observation'),
                                            ),
                                          );
                                        },
                                      ),
                                      ListTile(
                                        title: Text('Maintenance'),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => createissue(
                                                  issueType: 'Maintenance'),
                                            ),
                                          );
                                        },
                                      ),
                                      ListTile(
                                        title: Text('Incident'),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => createissue(
                                                  issueType: 'Incident'),
                                            ),
                                          );
                                        },
                                      ),
                                      ListTile(
                                        title: Text('Near Miss'),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => createissue(
                                                  issueType: 'Near Miss'),
                                            ),
                                          );
                                        },
                                      ),
                                      ListTile(
                                        title: Text('Hazard'),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => createissue(
                                                  issueType: 'Hazard'),
                                            ),
                                          );
                                        },
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          'Customize categories',
                                          style: TextStyle(
                                              color: Colors.deepPurple),
                                        )),
                                        titleAlignment:
                                            ListTileTitleAlignment.center,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CustomizeCategoriesPage(),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        primary: Theme.of(context).primaryColor,
                        side: BorderSide(color: Colors.transparent, width: 0),
                        textStyle: const TextStyle(
                          fontSize: 25,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 2),
                        child: Text(
                          'View Issues',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => issuepagescreen2()));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
