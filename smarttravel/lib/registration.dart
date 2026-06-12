  import 'dart:convert';
  import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
  import 'package:http/http.dart' as http;
  import 'package:shared_preferences/shared_preferences.dart';
  import 'package:smarttravel/login.dart';
  
  class Registration extends StatefulWidget {
    const Registration({Key? key}) : super(key: key);
  
    @override
    _RegistrationState createState() => _RegistrationState();
  }
  
  class _RegistrationState extends State<Registration> {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController lastController = TextEditingController();
    final TextEditingController placeController = TextEditingController();
    final TextEditingController postController = TextEditingController();
    final TextEditingController pinController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>(); // Add a global key for the form
  
    OutlineInputBorder outlineBorder() {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.cyan),
      );
    }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor:
            Colors.transparent, // Set background color to transparent
        appBar: AppBar(
          title: Text("Smart Travel"),
          backgroundColor: Colors.green, // Change the app bar color
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/whi.png"), // Set background image
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Registration",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Change the title color
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 20), // Add spacing between title and fields
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              Colors.transparent, // Set fill color to transparent
                          border: outlineBorder(),
                          hintText: "First Name",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your First Name';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10), // Add spacing between fields
                      TextFormField(
                        controller: lastController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                          Colors.transparent, // Set fill color to transparent
                          border: outlineBorder(),
                          hintText: "Last Name",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Last Name';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10), // Add spacing between fields
                      TextFormField(
                        controller: placeController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              Colors.transparent, // Set fill color to transparent
                          border: outlineBorder(),
                          hintText: "Place",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your place';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: postController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              Colors.transparent, // Set fill color to transparent
                          border: outlineBorder(),
                          hintText: "Address",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Address';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: pinController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              Colors.transparent, // Set fill color to transparent
                          border: outlineBorder(),
                          hintText: "Pin",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your pin';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              Colors.transparent, // Set fill color to transparent
                          border: outlineBorder(),
                          hintText: "Phone",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              Colors.transparent, // Set fill color to transparent
                          border: outlineBorder(),
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              Colors.transparent, // Set fill color to transparent
                          border: outlineBorder(),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20), // Add spacing before the button
                      ElevatedButton.icon(
                        onPressed: () async {
                          String u_fname=nameController .text .toString();
                          String u_lname=lastController .text .toString();
                          String u_phone=phoneController .text .toString();
                          String u_address=postController .text .toString();
                          String u_place=placeController .text .toString();
                          String u_pin=pinController .text .toString();
                          String u_email=emailController .text .toString();
                          String passw=passwordController .text .toString();

                          if(u_fname.length==0)
                          {
                            Fluttertoast.showToast(
                                msg: "enter Your First name",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );

                          }
                          else if(u_place.length==0)
                          {
                            Fluttertoast.showToast(
                                msg: "enter Your Place name",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );

                          }
                          else if(u_email.length==0)
                          {
                            Fluttertoast.showToast(
                                msg: "enter Your Valid Email",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );
                          }

                          else if(passw.length==0)
                          {
                            Fluttertoast.showToast(
                                msg: "enter YourValid Password",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );

                          }
                          else {
                            try {
                              SharedPreferences sh = await SharedPreferences
                                  .getInstance();
                              String ip = sh.getString("ip").toString();
                              String url = ip + "/api/user_registration";
                              final response = await http.post(
                                  Uri.parse(url), body: {
                                'fname': u_fname,
                                'lname': u_lname,
                                'phone': u_phone,
                                'address': u_address,
                                'place': u_place,
                                'pin': u_pin,
                                'email': u_email,
                                'passw': passw,
                              });
                              if (response.statusCode == 200) {
                                String status =
                                jsonDecode(response.body)['status'];
                                if (status == 'success') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => login(),
                                    ),
                                  );
                                  Fluttertoast.showToast(
                                      msg: "Registration has bees sucessfull",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.black,
                                      fontSize: 16.0
                                  );
                                } else if (status == 'duplicate') {
                                  Fluttertoast.showToast(
                                      msg: "Email Or Password Already exist",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.black,
                                      fontSize: 16.0
                                  );
                                }
                              } else {
                                // Handle other response status codes if needed
                              }
                            }
                            catch (a) {
                              print(a);
                            }
                          }
                        },
                        icon: Icon(Icons.send),
                        label: Text('Submit'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          // Change the button color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
