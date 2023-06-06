import 'package:flutter/material.dart';
import 'package:trynav/pages/user_drawer.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String _feedbackText = '';
  int _rating = 0;

  void _submitFeedback() {
    // TODO: Implement feedback submission logic
    print('Feedback submitted: $_rating stars, $_feedbackText');
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Feedback Submitted'),
          content: Text('Thank you for your feedback!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Reset feedback form
                setState(() {
                  _feedbackText = '';
                  _rating = 0;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => user_drawer()));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
        title: Text('Feedback'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please rate our app and provide any feedback or suggestions you may have:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.blueGrey[800],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = 1;
                    });
                  },
                  icon: Icon(
                    _rating >= 1 ? Icons.star : Icons.star_border,
                    size: 40,
                    color: Colors.amber,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = 2;
                    });
                  },
                  icon: Icon(
                    _rating >= 2 ? Icons.star : Icons.star_border,
                    size: 40,
                    color: Colors.amber,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = 3;
                    });
                  },
                  icon: Icon(
                    _rating >= 3 ? Icons.star : Icons.star_border,
                    size: 40,
                    color: Colors.amber,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = 4;
                    });
                  },
                  icon: Icon(
                    _rating >= 4 ? Icons.star : Icons.star_border,
                    size: 40,
                    color: Colors.amber,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = 5;
                    });
                  },
                  icon: Icon(
                    _rating >= 5 ? Icons.star : Icons.star_border,
                    size: 40,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter your feedback or suggestions here',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _feedbackText = value;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: ElevatedButton(
                    onPressed: _rating > 0 && _feedbackText.isNotEmpty
                        ? _submitFeedback
                        : null,
                    child: Text('Submit Feedback'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
