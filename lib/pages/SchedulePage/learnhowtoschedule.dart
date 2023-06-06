import 'package:flutter/material.dart';

class HowtoSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Importance of Schedule'),
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
            SizedBox(height: 16.0),
            Text(
              'Having a well-structured schedule is crucial for several reasons:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 14.0),
            ListTile(
              leading: Icon(Icons.timer),
              title: Text(
                'Time Management',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                'A schedule helps you manage your time effectively by allocating specific time slots for different activities. It enables you to prioritize tasks and ensures that you devote enough time to each one.',
                style: TextStyle(height: 1.3),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text(
                'Productivity',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                'When you have a schedule in place, you can focus on one task at a time, avoiding distractions. This leads to increased productivity as you can complete tasks more efficiently.',
                style: TextStyle(height: 1.3),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text(
                'Goal Setting',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                'A schedule allows you to set clear goals and objectives. By breaking down your goals into smaller tasks and allocating time for each, you can make progress towards achieving them.',
                style: TextStyle(height: 1.3),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ListTile(
              leading: Icon(Icons.mood),
              title: Text(
                'Stress Reduction',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                'With a well-planned schedule, you can reduce stress and avoid last-minute rush or missed deadlines. Knowing what needs to be done and when gives you a sense of control over your time.',
                style: TextStyle(height: 1.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
