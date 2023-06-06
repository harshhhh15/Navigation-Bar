import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

class ReferScreen extends StatefulWidget {
  @override
  _ReferScreenState createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

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
              color: Colors.white,
            )),
        title: Text('Refer Our Application'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Refer our application to your friends',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Your Email Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              height: 56,
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14))),
                onPressed: () async {
                  final name = _nameController.text;
                  final email = _emailController.text;

                  final smtpServer =
                      gmail('secure.culture.help@gmail.com', '2415@Harsh');
                  final message = Message()
                    ..from = Address(
                        'secure.culture.help@gmail.com', 'Security Culture')
                    ..recipients.add(email)
                    ..subject = '$name has invited you to try our app!'
                    ..text = 'Hey there,\n\n'
                        '$name has invited you to try our app. '
                        'Download it here: https://your-app.com\n\n'
                        'Thanks for your support!'
                    ..html = '<p>Hey there,</p>'
                        '<p>$name has invited you to try our app. '
                        'Download it <a href="https://your-app.com">here</a>.</p>'
                        '<p>Thanks for your support!</p>';

                  try {
                    await send(message, smtpServer);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Referral Sent'),
                        content: Text('Your referral email has been sent.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text(
                            'An error occurred while sending the referral email.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Send Referral'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
