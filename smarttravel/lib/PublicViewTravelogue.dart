
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarttravel/PublicViewImages.dart';
import 'package:smarttravel/PublicViewtravelVideos.dart';
import 'package:smarttravel/UserViewImagesnadvideos.dart';
import 'package:smarttravel/user_view_travel_images.dart';

void main() {
  runApp(MaterialApp(
    home: PublicViewOthersTravelogue(),
  ));
}

class PublicViewOthersTravelogue extends StatefulWidget {
  @override
  _UserAddTravelogueState createState() => _UserAddTravelogueState();
}

class _UserAddTravelogueState extends State<PublicViewOthersTravelogue> {
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

  Future<Map<String, dynamic>> _fetchFeedback() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String ip = sh.getString("ip") ?? '';
    String lid = sh.getString("lid") ?? '';

    try {
      String url = "$ip/api/PublicViewOthersTravelogue";
      final response = await http.post(Uri.parse(url), body: {
        'lid': lid,
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> feedback = jsonDecode(response.body);
        String travelogueId = feedback['travelogue_id'].toString();
        sh.setString('travelogueId', travelogueId);
        return feedback;
      } else {
        return {'status': 'failed', 'data': '0.0'};
      }
    } catch (error) {
      print(error);
      return {'status': 'failed', 'data': '0.0'};
    }
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
                  feedback['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        String travelogueId = feedback['travelogue_id'].toString();
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => PublicviewTravelImages(travelogueId: travelogueId),
                        ));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.videocam),
                      onPressed: () {
                        String travelogueId = feedback['travelogue_id'].toString();
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => PublicviewTravelVideos(travelogueId: travelogueId),
                        ));
                      },
                    ),
                  ],
                ),
              ],
            ),
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