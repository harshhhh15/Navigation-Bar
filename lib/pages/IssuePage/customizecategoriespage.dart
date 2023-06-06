import 'package:flutter/material.dart';

class CustomizeCategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customize Categories'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customize Categories',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'We apologize for the inconvenience, but the option to customize categories is not available at the moment.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Why Customize Categories?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8.0),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                'Personalization',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                'By customizing categories, you can organize your content according to your preferences and needs. It allows you to tailor the app to match your specific interests and priorities.',
                style: TextStyle(height: 1.3),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            ListTile(
              leading: Icon(Icons.speed),
              title: Text(
                'Efficiency',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                'Having customized categories enables you to quickly access the content you use most frequently. It streamlines your user experience and saves time searching for specific items.',
                style: TextStyle(height: 1.3),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            ListTile(
              leading: Icon(Icons.sync),
              title: Text(
                'Flexibility',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                'With the ability to customize categories, you can adapt the app to accommodate changes in your workflow or interests. It allows you to stay organized and focused on what matters to you.',
                style: TextStyle(height: 1.3),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'We value your feedback and are continuously working to enhance the app. Stay tuned for future updates that may include the customization feature.',
              style: TextStyle(fontSize: 16.0, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}
