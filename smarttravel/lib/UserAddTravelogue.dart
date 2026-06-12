import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarttravel/Useruploadimgesvideos.dart';

void main() {
  runApp(MaterialApp(
    home: UserAddTravelogue(),
  ));
}

class UserAddTravelogue extends StatefulWidget {
  @override
  _UserAddTravelogueState createState() => _UserAddTravelogueState();
}

class _UserAddTravelogueState extends State<UserAddTravelogue> {
  TextEditingController placeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travelogue'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Travelogue',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: placeController,
                decoration: InputDecoration(
                  labelText: 'Place Name',
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
              ),
              SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'More About',
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
                  child: Text('Send Travelogue'),
                ),
              ),

              SizedBox(height: 10),
              const Divider(),
              SizedBox(height: 16),
              Center(
                child: Text(
                  'View Travelogue',
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
                    return Text('No Travelogue available');
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
      String url = "$ip/api/user_add_travelogue";
      final response = await http.post(
        Uri.parse(url),
        body: {
          'lid': lid,
          'place': placeController.text,
          'title': titleController.text,
          'description': descriptionController.text,
        },
      );

      if (response.statusCode == 200) {
        _showToast('Feedback sent successfully');
        setState(() {
          placeController.clear();
          titleController.clear();
          descriptionController.clear();
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserAddTravelogue()),
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
      String url = "$ip/api/user_view_travelogue";
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
    if (placeController.text.isEmpty ||
        titleController.text.isEmpty ||
        descriptionController.text.isEmpty) {
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
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  feedback['place_name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteTravelogue(feedback['travelogue_id'].toString());
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => UserAddTravelogue(),
                        ));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        String travelogueId = feedback['travelogue_id'].toString();
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => FileUploadScreen(travelogueId: travelogueId),
                        ));
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text('Title: ${feedback['title']}'),
            SizedBox(height: 8.0),
            Text('Description: ${feedback['description']}'),
            SizedBox(height: 4.0),
            Text('Date: ${feedback['date_time']}'),
          ],
        ),
      ),
    );
  }
}

Future<void> _deleteTravelogue(String travelogueId) async {
  SharedPreferences sh = await SharedPreferences.getInstance();
  String ip = sh.getString("ip") ?? '';
  String lid = sh.getString("lid") ?? '';

  try {
    String url = "$ip/api/deletetravelogue";
    final response = await http.post(Uri.parse(url), body: {
      'lid': lid,
      'travelogue_id': travelogueId,
    });

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Travelogue deleted successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Failed to delete travelogue",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  } catch (error) {
    print(error);
    Fluttertoast.showToast(
      msg: "Failed to delete travelogue",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }
}
