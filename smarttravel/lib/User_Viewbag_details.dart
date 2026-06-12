import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyUserViewqrImages extends StatelessWidget {
  const MyUserViewqrImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Travel',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Qr Details"),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: UserViewDriversWidget(),
      ),
    );
  }
}

class UserViewDriversWidget extends StatefulWidget {
  const UserViewDriversWidget({Key? key}) : super(key: key);

  @override
  State<UserViewDriversWidget> createState() => _UserViewDriversState();
}

class _UserViewDriversState extends State<UserViewDriversWidget> {
  List<Map<String, dynamic>> driverData = [];
  late String baseUrl;

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
    String imageUrl = baseUrl + "/" + driverData[index]["qr_code"];

    return Card(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible( // Use Flexible to allow text to wrap
                child: Text(
                  'Description: ${driverData[index]["weight"]}',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  deleteData(driverData[index]["bag_id"].toString());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> deleteData(String bag_id) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String ip = sh.getString("ip") ?? '';
      String lid = sh.getString("lid") ?? '';
      baseUrl = ip;

      final response = await http.post(
        Uri.parse("$baseUrl/api/myuser_delete_qr"),
        body: {'bag_id': bag_id},
      );

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          getData(); // Reload the data after deletion
        } else {
          Fluttertoast.showToast(
            msg: "Failed to delete data",
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

  Future<void> getData() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String ip = sh.getString("ip") ?? '';
      String lid = sh.getString("lid") ?? '';
      baseUrl = ip;

      final response = await http.post(
        Uri.parse("$baseUrl/api/myUser_view_qr"),
        body: {'lid':lid},
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
      } else {
        Fluttertoast.showToast(
          msg: "Failed to fetch data",
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
