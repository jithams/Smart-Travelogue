import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smarttravel/FeedbackPage.dart';
import 'package:smarttravel/UserAddBagdetails.dart';
import 'package:smarttravel/UserAddTravelogue.dart';
import 'package:smarttravel/UserViewImagesnadvideos.dart';
import 'package:smarttravel/UserViewTravelogues.dart';
import 'package:smarttravel/User_Viewbag_details.dart';
import 'package:smarttravel/Useruploadimgesvideos.dart';
import 'package:smarttravel/ViewNotifications.dart';
import 'package:smarttravel/login.dart';
import 'package:smarttravel/user_view_travel_images.dart';
import 'package:smarttravel/userviewhotels.dart';
import 'package:smarttravel/userviewpackages.dart';

void main() => runApp(const UserViewDetailsApp());

class UserViewDetailsApp extends StatelessWidget {
  const UserViewDetailsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Shopping',
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
          title: const Text(
            "New Place Details",
            style: TextStyle(color: Colors.white), // Set text color to white
          ),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _navigateToHomeView();
            },
            color: Colors.white, // Set icon color to white
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildRoundButton('Add Travelogue', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserAddTravelogue()),
                          );

                        }),
                        buildRoundButton('Travelogues ', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserViewTravelogue()),
                          );


                        }),

                        buildRoundButton('Hotels', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserViewHotels()),
                          );

                        }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildRoundButton('Feedback', () {
                          // Add your button 1 logic here
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FeedbackPage()),
                          );
                        }),
                        buildRoundButton('Notifications', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NotificationPage()),
                          );
                        }),

                        buildRoundButton('Sign Out', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => login()),
                          );
                        }),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              performSearch(value);
                            },
                            decoration: InputDecoration(
                              labelText: 'Search by Location or Driver Name',
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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: 'View Qr',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Bag Details',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              if (_currentIndex == 0) {
                // Navigate to MyUserViewqrImages
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyUserViewqrImages(),
                  ),
                );
              } else if (_currentIndex == 1) {
                // Navigate to UserAddBagdetails
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserAddBagdetails(),
                  ),
                );
              }
            });
          },
        ),


      ),
    );
  }

  Widget buildCard(int index) {
    String imageUrl = baseUrl + "/" + driverData[index]["place_image"];

    return GestureDetector(
      onTap: () {
        showDetailsPopup(driverData[index]);
      },
      child: Card(
        child: Stack(
          children: [
            Column(
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
                  '${driverData[index]["type_name"]}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: IconButton(
                icon: Icon(
                  driverData[index]["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                  color: driverData[index]["isFavorite"] ? Colors.red : null,
                ),
                onPressed: () {
                  toggleFavorite(index, driverData[index]["place_id"].toString());
                },
              ),
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
    Text('Type: ${driverDetails["type_name"]}'),
    Text('Place Name: ${driverDetails["title"]}'),
    Text('Place: ${driverDetails["description"]}'),
    Text('Latitude: ${driverDetails["latitude"]}'),
    Text('Longitude: ${driverDetails["longitude"]}'),
    ],
    ),
    ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
        },
    );
  }

  void toggleFavorite(int index, String placeId) {
    bool isCurrentlyFavorite = driverData[index]["isFavorite"];
    setState(() {
      driverData[index]["isFavorite"] = !isCurrentlyFavorite;
    });

    if (!isCurrentlyFavorite) {
      addToFavorites(index, placeId);
    } else {
      removeFromFavorites(index, placeId);
    }
  }

  Future<void> addToFavorites(int index, String placeId) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String lid = sh.getString("lid") ?? '';
      String userId = sh.getString("user_id") ?? ''; // Add this line to get the user_id
      String baseUrl = sh.getString("ip") ?? '';

      final response = await http.post(Uri.parse("$baseUrl/api/useradd_to_fever"), body: {
        'lid': lid,
        'user_id': userId, // Add user_id to the request body
        'place_id': placeId,
      });

      print('Add to favorites response status code: ${response.statusCode}');
      print('Add to favorites response body: ${response.body}');

      if (response.statusCode == 200) {
        // Place is not in favorites, update the UI accordingly
        setState(() {
          // Update the isFavorite status
          driverData[index]["isFavorite"] = true;
        });

        // Store the favorite place ID in SharedPreferences
        List<String> favoritePlaces = sh.getStringList("favoritePlaces") ?? [];
        favoritePlaces.add(placeId);
        sh.setStringList("favoritePlaces", favoritePlaces);
      } else {
        // Handle the failure case
        // You might want to revert the state change here
      }
    } catch (error) {
      print('Error in addToFavorites: $error');
      // Handle the error case
      // You might want to revert the state change here
    }
  }

  Future<void> removeFromFavorites(int index, String placeId) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String lid = sh.getString("lid") ?? '';
      String userId = sh.getString("user_id") ?? '';
      String baseUrl = sh.getString("ip") ?? '';

      final response = await http.post(Uri.parse("$baseUrl/api/userremove_from_fever"), body: {
        'lid': lid,
        'user_id': userId,
        'place_id': placeId,
      });

      print('Remove from favorites response status code: ${response.statusCode}');
      print('Remove from favorites response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['status'] == 'checked_state') {
          // Place is still in favorites, you might want to handle this case
        } else {
          // Place is removed from favorites, update the UI accordingly
          setState(() {
            driverData[index]["isFavorite"] = false;
          });

          // Remove the favorite place ID from SharedPreferences
          List<String> favoritePlaces = sh.getStringList("favoritePlaces") ?? [];
          favoritePlaces.remove(placeId);
          sh.setStringList("favoritePlaces", favoritePlaces);
        }
      } else {
        // Handle the failure case
      }
    } catch (error) {
      print('Error in removeFromFavorites: $error');
    }
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

      // Fetch favorite places from interest table
      List<String> favoritePlaceIds = await getFavoritePlaceIds(lid);

      final response = await http.post(Uri.parse("$baseUrl/api/User_view_places"), body: {'lid': lid});

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
            driver["isFavorite"] = favoritePlaceIds.contains(driver["place_id"]); // Set isFavorite based on favoritePlaceIds
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

  Future<List<String>> getFavoritePlaceIds(String userId) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String ip = sh.getString("ip") ?? '';

      final response = await http.post(Uri.parse("$ip/api/get_favorite_places"), body: {'user_id': userId});

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonDecode(response.body));

        return data.map((favorite) => favorite["place_id"].toString()).toList();
      } else {
        print('Error in getFavoritePlaceIds: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error in getFavoritePlaceIds: $error');
      return [];
    }
  }

  void saveSelectedDriverId(int driverId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedDriverId', driverId);
  }

  void _navigateToHomeView() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewDetailsApp()));
  }

  void performSearch(String query) {
    List<Map<String, dynamic>> filteredData = originalDriverData.where((driver) {
      String fullName = '${driver["type_name"]} ${driver["title"]}'.toLowerCase();
      return fullName.contains(query.toLowerCase()) || driver["title"].toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      driverData = filteredData;
    });
  }
}
Widget buildRoundButton(String label, VoidCallback onPressed) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.black, // Set the button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white, // Set the text color to white
        ),
      ),
    ),
  );
}

