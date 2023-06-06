import 'package:flutter/material.dart';

class LearnMorePageIssue extends StatelessWidget {
  const LearnMorePageIssue({Key? key}) : super(key: key);

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
        title: Text(
          'Learn More About Creating Issues',
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What is an issue?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'An issue is a problem or task that needs to be addressed. Creating an issue helps to keep track of the work that needs to be done, assign the task to the relevant person, and track the progress of the task.',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            SizedBox(height: 20),
            Text(
              'How to create an issue:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Follow these simple steps to create an issue:',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            SizedBox(height: 20),
            _buildStep('Step 1: Select the project',
                'Choose the project for which you want to create an issue. If you have multiple projects, make sure you select the correct one.'),
            SizedBox(height: 20),
            _buildStep('Step 2: Click on "Create Issue"',
                'Once you have selected the project, click on the "Create Issue" button. This will open up a form where you can enter the details of the issue.'),
            SizedBox(height: 20),
            _buildStep('Step 3: Enter the details of the issue',
                'In the form, enter the title, description, priority, and assignee of the issue. Make sure you provide as much detail as possible to ensure that the assignee understands the issue and can work on it effectively.'),
            SizedBox(height: 20),
            _buildStep('Step 4: Click on "Create"',
                'Once you have entered all the details, click on the "Create" button to create the issue. The issue will be added to the project and assigned to the relevant person.'),
            SizedBox(height: 20),
            Text(
              'That\'s it!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Now you know how to create issues in the task management application. Happy task management!',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(fontSize: 18, color: Colors.black45),
        ),
      ],
    );
  }
}
