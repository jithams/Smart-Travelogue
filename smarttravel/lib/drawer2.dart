
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class UserDrawer extends StatelessWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.cyan,
            ),
            child: Text(
              "MedEvac",
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ),
          ListTile(
            leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.ambulance,
                  size: 30,
                          )),
            title: const Text("View Ambulance",style: TextStyle(fontSize: 20),),
            // onTap: () {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => LocationFetchScreen()));
            // },
          ),
          ListTile(
            leading: IconButton(onPressed: () {}, icon: const Icon(Icons.info,size: 30,)),
            title: const Text("Send Feedback",style: TextStyle(fontSize: 20),),
            // onTap: () {
            //    Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => FeedbackPage()));
            // },
          ),
        ],
      ),
    );
  }
}
