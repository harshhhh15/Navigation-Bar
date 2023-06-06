import 'package:flutter/material.dart';

class HelpAndSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Help & Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                height: 210,
                child: Image.asset("assets/images/helpandsupport.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                'Contact Us',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('support@example.com'),
              onTap: () => _launchEmail(),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
              subtitle: Text('123-456-7890'),
              onTap: () => _launchPhone(),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat'),
              subtitle: Text('Start a chat'),
              onTap: () => _launchChat(),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                'FAQ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('How do I create a new task?'),
              onTap: () => _showAnswer(context,
                  'To create a new task, tap the plus button in the bottom right corner of the home screen. Fill out the task details and tap the save button to create the task.'),
            ),
            Divider(),
            ListTile(
              title: Text('How do I edit a task?'),
              onTap: () => _showAnswer(context,
                  'To edit a task, tap on the task in the home screen to view its details. Then, tap the edit button in the top right corner of the screen. Make your changes and tap the save button to update the task.'),
            ),
            Divider(),
            ListTile(
              title: Text('How do I delete a task?'),
              onTap: () => _showAnswer(context,
                  'To delete a task, swipe left on the task in the home screen to reveal the delete button. Tap the delete button to remove the task from your list.'),
            ),
            Divider(),
            ListTile(
              title: Text('How do I mark a task as complete?'),
              onTap: () => _showAnswer(context,
                  'To mark a task as complete, swipe right on the task in the home screen to reveal the complete button. Tap the complete button to mark the task as finished.'),
            ),
            Divider(),
            ListTile(
              title: Text('How do I view completed tasks?'),
              onTap: () => _showAnswer(context,
                  'To view completed tasks, tap on the filter button in the top right corner of the home screen. Then, select the "Completed" option from the filter menu to view your finished tasks.'),
            ),
            Divider(),
            ListTile(
              title: Text('How do I prioritize tasks?'),
              onTap: () => _showAnswer(context,
                  'To prioritize tasks, drag and drop the tasks in the home screen to reorder them. The tasks at the top of the list will be considered the most important.'),
            ),
            Divider(),
            ListTile(
              title: Text('How do I set reminders for tasks?'),
              onTap: () => _showAnswer(context,
                  'To set reminders for tasks, tap on the task in the home screen to view its details. Then, tap the reminder button and select a date and time for the reminder. You will receive a notification when it\'s time to complete the task.'),
            ),
            Divider(),
            ListTile(
              title: Text('How do I share a task with someone else?'),
              onTap: () => _showAnswer(context,
                  'To share a task with someone else, tap on the task in the home screen to view its details. Then, tap the share button and select the person or group you want to share the task with. They will receive a notification with the task details.'),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  void _launchEmail() {
    // implement email launch
  }

  void _launchPhone() {
    // implement phone launch
  }

  void _launchChat() {
    // implement chat launch
  }

  void _showAnswer(BuildContext context, String answer) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Answer'),
        content: Text(answer),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
