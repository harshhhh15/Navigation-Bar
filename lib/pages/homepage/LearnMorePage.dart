import 'package:flutter/material.dart';

class LearnMorePageActions extends StatefulWidget {
  const LearnMorePageActions({Key? key}) : super(key: key);

  @override
  _LearnMorePageActionsState createState() => _LearnMorePageActionsState();
}

class _LearnMorePageActionsState extends State<LearnMorePageActions> {
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
        centerTitle: true,
        title: Text('Learn More about Action'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task Management Application',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'This is a task management application built with Flutter. It allows users to create and manage tasks, set due dates and priorities, and track progress.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                'Features:',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16.0),
              _buildFeature('Create, edit, and delete tasks'),
              _buildFeature('Set due dates and priorities for tasks'),
              _buildFeature('Mark tasks as complete'),
              _buildFeature('View completed tasks'),
              SizedBox(height: 32.0),
              Text(
                'Technologies used:',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16.0),
              _buildTech('Flutter'),
              _buildTech('Dart'),
              _buildTech('Firebase (for authentication and data storage)'),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Report Issue'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(String feature) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check,
          color: Colors.green,
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Text(
            feature,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTech(String tech) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.code,
          color: Colors.blue,
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Text(
            tech,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }
}
