import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/firebase_helper.dart';
import 'package:news_app/views/login.dart';
import 'package:provider/provider.dart';


class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
   String loggedInUser="hello";

   Future<String> getLoggedInUserName()async {
     loggedInUser = await context.read<firebaseService>().loggedInUser();
   }
  @override
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {},
        ),
      ),
      body: FutureBuilder(
        future: getLoggedInUserName(),
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Expanded(
                child: ListView(
                  children: [
                    Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 15,
                    ),
          Center(
          child: Stack(
          children: [
          Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
          border: Border.all(
          width: 4,
          color: Theme.of(context).scaffoldBackgroundColor),
          boxShadow: [
          BoxShadow(
          spreadRadius: 2,
          blurRadius: 10,
          color: Colors.black.withOpacity(0.1),
          offset: Offset(0, 10))
          ],
          shape: BoxShape.circle,
          image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              "https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg",
          )
          )
          ),
          ),]
          )
              ),
                    RaisedButton(onPressed: ()async {
                      context.read<firebaseService>().signOut();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                    },
                    child: Text("LOGOUT"),),
                    Padding(
                      padding: const EdgeInsets.all(.0),
                      child: Card(color: Colors.blue,
                       child: Text("$loggedInUser"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}