import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trynav/pages/StartingPages/splashscreen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.deepPurple,
    // Status bar brightness (optional)
    statusBarIconBrightness: Brightness.light,
    // For Android (dark icons)
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.deepPurple,
    // navigation bar color
    systemNavigationBarIconBrightness:
        Brightness.dark, // color of navigation controls
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
        colorScheme: ColorScheme.light(primary: Colors.deepPurple),
      ),
      routes: {
        '/': (context) => splashscreen(),
      },
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
