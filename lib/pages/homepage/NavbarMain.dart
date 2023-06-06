import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:trynav/pages/Inspectionpage/InspectionMain.dart';
import 'package:trynav/pages/IssuePage/IssueMain.dart';

import '../ActionPage/ActionMain.dart';
import '../SchedulePage/ScheduleMain.dart';
import 'HomeMain.dart';

class mainnavbar extends StatefulWidget {
  const mainnavbar({Key? key}) : super(key: key);

  @override
  State<mainnavbar> createState() => _mainnavbarState();
}

class _mainnavbarState extends State<mainnavbar> {
  int current_index = 0;
  final List<Widget> pages = [
    homepage(),
    inspectionpage(),
    issuepage(),
    actionpage(),
    schedulepage()
  ];

  void OnTapped(int index) {
    setState(() {
      current_index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: pages[current_index],
      bottomNavigationBar: CurvedNavigationBar(
          // animationCurve: Curves.easeOut,
          animationDuration: Duration(milliseconds: 240),
          height: 66,
          buttonBackgroundColor: Colors.deepPurple.shade500,
          backgroundColor: Colors.transparent,
          color: Theme.of(context).primaryColor,
          onTap: OnTapped,
          items: <Widget>[
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.assignment_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            Icon(
              Icons.sell_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.schedule,
              color: Colors.white,
            ),
          ]),
    );
  }
}
