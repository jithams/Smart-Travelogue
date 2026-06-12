import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_icons/flutter_icons.dart'; // Import flutter_icons package
import 'package:smarttravel/PublicViewTravelogue.dart';
import 'package:smarttravel/QRScanPage.dart';
import 'package:smarttravel/main.dart';
import 'package:smarttravel/registration.dart';
import 'package:smarttravel/user%20home.dart';

class login extends StatefulWidget {
  const login({Key? key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: WillPopScope(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Stack(
              children: <Widget>[
                // Background image
                Image.asset(
                  'assets/whi.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.blue),
                            ),
                            hintText: "Username",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                String uname= usernameController.text.toString();
                                String password= passwordController.text.toString();
                                if(uname.length==0) {
                                  Fluttertoast.showToast(
                                      msg: "Enter The Valid Username",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }
                                else if(password.length==0) {
                                  Fluttertoast.showToast(
                                      msg: "Enter The Valid Password",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }
                                else {
                                  try {
                                    SharedPreferences sh = await SharedPreferences
                                        .getInstance();
                                    String ip = sh.getString("ip").toString();
                                    String url = ip + "/api/login";
                                    final response = await http.post(Uri.parse(url),
                                        body: {
                                          'uname': uname,
                                          'password': password,
                                        });
                                    if (response.statusCode == 200) {
                                      String status = jsonDecode(response.body)['status'];
                                      if (status == 'success') {
                                        String type = jsonDecode(response.body)['type'];
                                        String lid = jsonDecode(response.body)['lid']
                                            .toString();
                                        sh.setString("lid", lid);
                                        if (type == 'user') {
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => UserViewDriversWidget(),));
                                        }
                                        Fluttertoast.showToast(
                                            msg: "Login Has Been successfull",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }
                                    }
                                    else {
                                      Fluttertoast.showToast(
                                          msg: "Invalid Username or Password",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.red,
                                          fontSize: 16.0
                                      );
                                    }
                                  }
                                  catch (a) {
                                    print(a);
                                  }
                                }
                              },
                              child: Text("Login"),
                            ),
                            SizedBox(height: 16.0),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Registration(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person_add), // New user icon
                                  SizedBox(width: 8.0),
                                  Text(
                                    "Sign Up",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => QRViewExample()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                primary: Colors.blue, // Change color as needed
                              ),
                              child: Text(
                                "Scan QR Code",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            )

                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PublicViewOthersTravelogue()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.explore),
                            SizedBox(width: 8.0),
                            Text(
                              "Explore the Travel",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ipset()));
          return true;
        },
      ),
    );
  }
}
