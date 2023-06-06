import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class showaddedpic extends StatelessWidget {
  final File thumbnail;

  const showaddedpic({Key? key, required this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Theme.of(context).primaryColor,
            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          toolbarHeight: 70,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor)),
          centerTitle: true,
          title: Text(
            "Added Image",
            style:
                TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(primary: Colors.deepPurple),
                child: Text(
                  "Done",
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Container(
                padding: EdgeInsets.all(6),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Image.file(
                  thumbnail as File,
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }
}
