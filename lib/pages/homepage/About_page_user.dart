import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
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
        child: /*Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Management App',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 16.0),
            Text(
              'Version: 1.0.0',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 16.0),
            Text(
              'Developed by: Your Company Name',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 16.0),
            Text(
              'Contact us at: your@email.com',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        )*/
            ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                height: 210,
                child: Image.asset("assets/images/about_us.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                'About Us',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.app_shortcut),
              title: Text('Security Culture'),
              subtitle: Text('Project Management App'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text('Version'),
              subtitle: Text(' 1.0.0'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.code),
              title: Text('Developed by'),
              subtitle: Text('Security Culture Team'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.code),
              title: Text('contact us'),
              subtitle: Text('securityculture@gmail.com'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
