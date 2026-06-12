import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() => runApp(UserViewPackage(hotelId: 'hotelId'));


class UserViewPackage extends StatelessWidget {
  final String hotelId;

  const UserViewPackage({Key? key, required this.hotelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travelogue',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Packages Details"),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: UserViewDriversWidget(hotelId: hotelId), // Pass hotelId to UserViewDriversWidget
      ),
    );
  }
}

class UserViewDriversWidget extends StatefulWidget {
  final String hotelId;

  const UserViewDriversWidget({Key? key, required this.hotelId}) : super(key: key);

  @override
  State<UserViewDriversWidget> createState() => _UserViewDriversState();
}

class _UserViewDriversState extends State<UserViewDriversWidget> {
  List<Map<String, dynamic>> driverData = [];
  String baseUrl = ''; // Set your server's base URL here

  @override
  void initState() {
    super.initState();
    getData(widget.hotelId); // Pass hotelId to getData method
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
    String imageUrl = baseUrl + "/" + driverData[index]["photo"];

    return Card(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 10),
          Text(
            'Hotel Name: ${driverData[index]["hotel_name"]}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'Title: ${driverData[index]["title"]}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'Details: ${driverData[index]["description"]}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'Amount: ${driverData[index]["amount"]}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          // ElevatedButton(
          //   onPressed: () {
          //     // Add your logic here for the 'Details' button
          //   },
          //   child: const Text('Details'),
          // ),
        ],
      ),
    );
  }

  Future<void> getData(String hotelId) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String ip = sh.getString("ip") ?? '';
      baseUrl = ip; // Update the baseUrl with the IP address dynamically

      final response = await http.post(Uri.parse("$baseUrl/api/User_view_hotelpackeges"), body: {'hotel_id': hotelId});

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonDecode(response.body)['data']);

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
    } catch (error) {
      print(error);
    }
  }
}
