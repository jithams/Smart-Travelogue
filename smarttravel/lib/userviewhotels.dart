import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smarttravel/userviewpackages.dart';

void main() => runApp(const UserViewHotels());

class UserViewHotels extends StatelessWidget {
  const UserViewHotels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travelogue',
      home: const UserViewDriversWidget(),
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
  List<Map<String, dynamic>> originalDriverData = [];
  String baseUrl = ''; // Set your server's base URL here
  int _currentIndex = 0;
  int selectedDriverId = -1;
  TextEditingController searchController = TextEditingController();
  Position? userLocation;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  double calculateDistance(double userLat, double userLon, double driverLat, double driverLon) {
    double distanceInMeters = Geolocator.distanceBetween(userLat, userLon, driverLat, driverLon);
    double distanceInKm = distanceInMeters / 1000.0;
    return distanceInKm;
  }

  Future<void> getLocation() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          userLocation = position;
          isLoading = false;
          getData();
        });
      } catch (e) {
        print(e);
        setState(() {
          isLoading = false;
        });
      }
    } else {
      print('Location permission denied');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navigateToHomeView();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hotel Details"),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _navigateToHomeView();
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.grey, width: 1.0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          performSearch(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'Search by Location or Hotel Name',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();
                              setState(() {
                                driverData = List.from(originalDriverData);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        String searchQuery = searchController.text;
                        performSearch(searchQuery);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: driverData.length,
                itemBuilder: (context, index) {
                  return buildCard(index);
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_back),
              label: 'Back',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget buildCard(int index) {
    String imageUrl = baseUrl + "/" + driverData[index]["photo"];

    return GestureDetector(
      onTap: () {
        showDetailsPopup(driverData[index]);
      },
      child: Card(
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${driverData[index]["hotel_name"]}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  void showDetailsPopup(Map<String, dynamic> driverDetails) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('More Details'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Hotel Name: ${driverDetails["hotel_name"]}'),
                Text('Place Name: ${driverDetails["place"]}'),
                Text('About: ${driverDetails["about"]}'),
                Text('Phone: ${driverDetails["phone"]}'),
                Text('Email: ${driverDetails["email"]}'),
                SizedBox(height: 20), // Add some space between the details and the button
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
                TextButton(
                  onPressed: () {
                    int hotelId = driverDetails["hotel_id"] as int; // Convert to int
                    Fluttertoast.showToast(
                      msg: "Selected Hotel ID: $hotelId",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserViewPackage(hotelId: hotelId.toString())),
                    );
                  },
                  child: Text('Package'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }




  Future<void> getData() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String ip = sh.getString("ip") ?? '';
      String lid = sh.getString("lid") ?? '';
      baseUrl = ip;

      if (userLocation == null) {
        print('User location is null');
        return;
      }

      final response = await http.post(Uri.parse("$baseUrl/api/User_view_hotels"), body: {'lid': lid});

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonDecode(response.body)['data']);

          data.forEach((driver) {
            double driverLatitude = double.parse(driver["latitude"]);
            double driverLongitude = double.parse(driver["longitude"]);
            double distance = calculateDistance(
                userLocation!.latitude, userLocation!.longitude, driverLatitude, driverLongitude);
            driver["distance"] = distance;
          });

          data.sort((a, b) => (a["distance"] as num).compareTo(b["distance"] as num));

          setState(() {
            driverData = data;
            originalDriverData = List.from(data);
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
      print('Error in getData: $error');
    }
  }

  void _navigateToHomeView() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewHotels()));
  }

  void performSearch(String query) {
    List<Map<String, dynamic>> filteredData = originalDriverData.where((driver) {
      String fullName = '${driver["hotel_name"]} ${driver["place"]}'.toLowerCase();
      return fullName.contains(query.toLowerCase()) || driver["hotel_name"].toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      driverData = filteredData;
    });
  }

}

void saveSelectedDriverId(int hotelId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('selectedHotelId', hotelId);
  print("Saved Hotel ID: $hotelId");
}



