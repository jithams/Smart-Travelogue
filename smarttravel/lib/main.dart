
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarttravel/login.dart';

void main() {
  runApp(const Ambulance());
}

class Ambulance extends StatefulWidget {
  const Ambulance({super.key});

  @override
  State<Ambulance> createState() => _AmbulanceState();
}

class _AmbulanceState extends State<Ambulance> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ipset(),
    );
  }
}

class ipset extends StatefulWidget {
  const ipset({super.key});

  @override
  State<ipset> createState() => _ipsetstate();
}

class _ipsetstate extends State<ipset> {
  final TextEditingController ipController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    await setIp();
  }

  Future<void> setIp() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    ipController.text = sh.getString("ipa") ?? "192.168.29.144:5022";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Explore Travels"),
        ),
        body: SafeArea(
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
                        padding: const EdgeInsets.all(2),
                        child: TextFormField(
                          controller: ipController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "IP Address",
                            hintText: "Enter a valid IP address",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the IP';
                            }
                            return null; // Return null if the input is valid
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            String ipaddress = ipController.text.toString();
                            if (ipaddress.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Enter A valid Ip Address To login",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            } else {
                              String url = "http://" + ipController.text.toString();
                              SharedPreferences sh =
                              await SharedPreferences.getInstance();
                              sh.setString("ip", url);
                              sh.setString("ipa", ipaddress);
                              print("Entered IP Address: $ipaddress");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => login()),
                              );
                            }
                          },
                          child: const Icon(Icons.key),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.of(context).pop(true);
        return true;
      },
    );
  }
}
