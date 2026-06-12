import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UserViewTravelImages extends StatelessWidget {
  final String travelogueId;

  const UserViewTravelImages({Key? key, required this.travelogueId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Travelogue',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Smart Travelogue"),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: UserViewDriversWidget(travelogueId: travelogueId),
      ),
    );
  }
}

class UserViewDriversWidget extends StatefulWidget {
  final String travelogueId;

  const UserViewDriversWidget({Key? key, required this.travelogueId}) : super(key: key);

  @override
  State<UserViewDriversWidget> createState() => _UserViewDriversState(travelogueId: travelogueId);
}

class _UserViewDriversState extends State<UserViewDriversWidget> {
  List<Map<String, dynamic>> driverData = [];
  String baseUrl = '';
  final String travelogueId;

  _UserViewDriversState({required this.travelogueId});

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: driverData.length,
        itemBuilder: (context, index) {
          return buildCard(index);
        },
      ),
    );
  }

  Widget buildCard(int index) {
    String imageUrl = baseUrl + "/" + driverData[index]["file_path"];

    return Card(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              String youtubeLink = driverData[index]["youtube_link"];
              if (youtubeLink.isNotEmpty) {
                if (!youtubeLink.startsWith('http://') &&
                    !youtubeLink.startsWith('https://')) {
                  youtubeLink = 'https://' + youtubeLink;
                }
                launch(youtubeLink);
              }
            },
            child: Row(
              children: [
                Icon(Icons.play_circle_outline),
                SizedBox(width: 5),
                Text(
                  'YouTube ',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible( // Use Flexible to allow text to wrap
                child: Text(
                  'Description: ${driverData[index]["description"]}',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> getData() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String ip = sh.getString("ip") ?? '';
      print("travelogueId");
      baseUrl = ip;

      if (travelogueId.isNotEmpty) {
        final response = await http.post(
          Uri.parse("$baseUrl/api/User_view_travel_images"),
          body: {'travelogueId': travelogueId},
        );

        if (response.statusCode == 200) {
          String status = jsonDecode(response.body)['status'];
          if (status == 'ok') {
            List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
              jsonDecode(response.body)['data'],
            );

            setState(() {
              driverData = data;
            });
          } else {
            Fluttertoast.showToast(
              msg: "Failed: No data",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        }
      } else {
        Fluttertoast.showToast(
          msg: "Failed: TravelogueId is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (error) {
      print(error);
    }
  }
}
