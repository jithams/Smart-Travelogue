import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarttravel/Useruploadimgesvideos.dart';
import 'package:smarttravel/user%20home.dart';

void main() {
  runApp(MaterialApp(
    home: UserAddBagdetails(),
  ));
}

class UserAddBagdetails extends StatefulWidget {
  @override
  _UserAddTravelogueState createState() => _UserAddTravelogueState();
}

class _UserAddTravelogueState extends State<UserAddBagdetails> {
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
                'Add Bag Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: placeController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
              ),
              SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Weight',
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
                  child: Text('Add Bag'),
                ),
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
      String url = "$ip/api/UserAddBagdetails";
      final response = await http.post(
        Uri.parse(url),
        body: {
          'lid': lid,
          'weight': placeController.text,
          'title': titleController.text,
          'details': descriptionController.text,
        },
      );

      if (response.statusCode == 200) {
        _showToast('Bag details added  successfully');
        setState(() {
          placeController.clear();
          titleController.clear();
          descriptionController.clear();
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserViewDetailsApp()),
        );
      } else {
        _showToast('Failed to send bag adding');
      }
    } catch (error) {
      print(error);
      _showToast('Error sending adding');
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

