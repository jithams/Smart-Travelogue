import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: FeedbackPage(),
  ));
}

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController complaintController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Feedback',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Feedback',
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
              ),
              SizedBox(height: 10),
              TextField(
                controller: complaintController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black87,
                    onPrimary: Colors.white, // Set text color to white
                  ),
                  onPressed: () async {
                    if (_validateFields()) {
                      await _sendFeedback();
                    }
                  },
                  child: Text('Send Feedback'),
                ),

              ),
              SizedBox(height: 10),
              const Divider(),
              SizedBox(height: 16),
              Center(
                child: Text(
                  'View Feedback',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              FutureBuilder(
                future: _fetchFeedback(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData &&
                      snapshot.requireData['status'] == 'ok') {
                    List<dynamic> feedbackList = snapshot.requireData['data'];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var feedback in feedbackList)
                          FeedbackCard(feedback: feedback),
                      ],
                    );
                  } else {
                    return Text('No feedback available');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendFeedback() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String ip = sh.getString("ip") ?? '';
    String lid = sh.getString("lid") ?? '';

    try {
      String url = "$ip/api/usersendfeedback";
      final response = await http.post(
        Uri.parse(url),
        body: {
          'lid': lid,
          'feedback': complaintController.text,
          'description': descriptionController.text,
        },
      );

      if (response.statusCode == 200) {
        _showToast('Feedback sent successfully');
        setState(() {
          complaintController.clear();
          descriptionController.clear();
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FeedbackPage()),
        );
      } else {
        _showToast('Failed to send feedback');
      }
    } catch (error) {
      print(error);
      _showToast('Error sending feedback');
    }
  }

  Future<Map<String, dynamic>> _fetchFeedback() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String ip = sh.getString("ip") ?? '';
    String lid = sh.getString("lid") ?? '';

    try {
      String url = "$ip/api/userviewfeedback";
      final response = await http.post(Uri.parse(url), body: {
        'lid': lid,
      });

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'status': 'failed', 'data': '0.0'};
      }
    } catch (error) {
      print(error);
      return {'status': 'failed', 'data': '0.0'};
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  bool _validateFields() {
    if (descriptionController.text.isEmpty ||
        complaintController.text.isEmpty) {
      _showToast('Please fill in all fields');
      return false;
    }
    return true;
  }
}

class FeedbackCard extends StatelessWidget {
  final Map<String, dynamic> feedback;

  FeedbackCard({required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0, // Add elevation for shadow
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Add margin
      child: Container(
        width: double.infinity, // Set width to match the parent
        padding: EdgeInsets.all(16.0), // Add padding for content spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              feedback['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0), // Add vertical spacing
            Text('Description: ${feedback['description']}'),
            SizedBox(height: 4.0), // Add vertical spacing
            Text('Date: ${feedback['date_time']}'),
          ],
        ),
      ),
    );
  }
}
