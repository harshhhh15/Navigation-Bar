import 'package:flutter/material.dart';

class aboutpageadmin extends StatefulWidget {
  @override
  _aboutpageadminState createState() => _aboutpageadminState();
}

class _aboutpageadminState extends State<aboutpageadmin> {
  final TextEditingController _appNameController =
      TextEditingController(text: 'Project Management App');
  final TextEditingController _versionController =
      TextEditingController(text: '1.0.0');
  final TextEditingController _companyNameController =
      TextEditingController(text: 'Your Company Name');
  final TextEditingController _emailController =
      TextEditingController(text: 'your@email.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
            )),
        title: Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _appNameController,
              decoration: InputDecoration(
                labelText: 'App Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _versionController,
              decoration: InputDecoration(
                labelText: 'Version',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _companyNameController,
              decoration: InputDecoration(
                labelText: 'Company Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'add',
        elevation: 0,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 10),
                  Text('Data saved Successfully.',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(10),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
