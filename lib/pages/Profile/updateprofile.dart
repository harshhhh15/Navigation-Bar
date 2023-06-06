import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicturePage extends StatefulWidget {
  @override
  _ProfilePicturePageState createState() => _ProfilePicturePageState();
}

class _ProfilePicturePageState extends State<ProfilePicturePage> {
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);

    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultImage = AssetImage("assets/images/default_profile_pic.png");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
            )),
        title: Text("Set Profile Picture"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 64,
              backgroundImage: _image != null
                  ? FileImage(_image!)
                  : defaultImage as ImageProvider<Object>,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _getImage(ImageSource.camera),
              child: Text("Take a Photo"),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _getImage(ImageSource.gallery),
              child: Text("Choose from Gallery"),
            ),
          ],
        ),
      ),
    );
  }
}
