import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

class UserViewImagesVideos extends StatelessWidget {
  final String travelogueId;

  const UserViewImagesVideos({Key? key, required this.travelogueId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travelogue',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Travelogue"),
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
  String baseUrl = ''; // Set your server's base URL here
  final String travelogueId;

  _UserViewDriversState({required this.travelogueId});

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    for (Map<String, dynamic> data in driverData) {
      VideoPlayerController? videoPlayerController = data['controller'];
      ChewieController? chewieController = data['chewieController'];

      videoPlayerController?.dispose();
      chewieController?.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return driverData.isNotEmpty
        ? ListView.builder(
      itemCount: driverData.length,
      itemBuilder: (context, index) {
        return buildCard(index);
      },
    )
        : Center(
      child: Text('No data available'),
    );
  }

  Widget buildCard(int index) {
    if (driverData[index]["file_path"] == null ||
        driverData[index]["file_path"].isEmpty) {
      return Card(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text('Invalid video URL'),
          ],
        ),
      );
    }

    String videoUrl = baseUrl + driverData[index]["file_path"];
    print("Original Video URL: $videoUrl");

    VideoPlayerController videoPlayerController =
    VideoPlayerController.network(videoUrl);

    ChewieController chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: false,
      errorBuilder: (context, errorMessage) {
        print("Chewie error: $errorMessage");
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );

    driverData[index]['controller'] = videoPlayerController;
    driverData[index]['chewieController'] = chewieController;

    return Card(
      child: Column(
        children: [
          Container(
            height: 200,
            child: Chewie(controller: chewieController),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              String youtubeLink = driverData[index]["youtube_link"];
              if (youtubeLink.isNotEmpty) {
                if (!youtubeLink.startsWith('http://') && !youtubeLink.startsWith('https://')) {
                  youtubeLink = 'https://' + youtubeLink;
                }
                launch(youtubeLink);
              }
            },
            child: Row(
              children: [
                Icon(Icons.play_circle_outline), // Add YouTube icon
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
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> getData() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String ip = sh.getString("ip") ?? '';
      // baseUrl = ip;
      baseUrl = ip + '/';

      final response = await http.post(
        Uri.parse("$baseUrl/api/user_view_images_videos"),
        body: {'travelogueId': travelogueId},
      );

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(jsonDecode(response.body)['data']);

          setState(() {
            driverData = data;
          });
        } else {
          showErrorToast("Failed: ${jsonDecode(response.body)['message']}");
        }
      } else {
        showErrorToast(
            "Failed to load data. Server returned ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
      showErrorToast("Error fetching data");
    }
  }

  void showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

extension NumericCheck on String {
  bool isNumeric() {
    return double.tryParse(this) != null;
  }
}
