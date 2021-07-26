import 'package:flutter/material.dart';
import 'package:news_app/helper/firebase_helper.dart';
import 'package:provider/provider.dart';
import 'login.dart';
class settingsUI extends StatefulWidget {
  @override
  _settingsUIState createState() => _settingsUIState();
}

class _settingsUIState extends State<settingsUI> {
  String loggedInUser="hello";

  Future<String> getLoggedInUserName()async {
    loggedInUser = await context.read<firebaseService>().loggedInUser();
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ), ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
      ),

      body: FutureBuilder(
        future: getLoggedInUserName(),
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.only(left: 16, top: 8, right: 16),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
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
                                  ))),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Colors.green,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  buildTextField("E-mail", "$loggedInUser", false),
                  buildTextField("Password", "********", true),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Update",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      ),
                      RaisedButton(
                          onPressed: ()async {
                            context.read<firebaseService>().signOut();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                          },
                        color: Colors.redAccent,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  // Divider(
                  //   indent: 90,
                  //   endIndent: 90,
                  //   thickness: 2,
                  //   color: Colors.black,
                  // ),
                  // SizedBox(height: 15,),
                  //
                  // Text(
                  //   "App Settings",
                  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  // ),
                  // SizedBox(
                  //   height: 40,
                  // ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
