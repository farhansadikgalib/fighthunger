import 'dart:io';

import 'package:fighthunger/database/database.dart';
import 'package:fighthunger/main.dart';
import 'package:fighthunger/models/signup.dart';
import 'package:fighthunger/models/user.dart';
import 'package:fighthunger/screens/homeContainer.dart';
import 'package:fighthunger/screens/home_page.dart';
import 'package:fighthunger/style/global.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../database/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
  
}

class _LogInPageState extends State<SignUpPage> {
  //Controllers for e-mail and password textfields.
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController birthMonth = TextEditingController();
  final TextEditingController birthDay = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _signUpBanner(),
          Container(
            width: MediaQuery.of(context).size.width*.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      fillColor: whiteFontColor,
                      filled: true,
                      labelStyle: basicBlackBold,
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: birthMonth,
                    decoration: InputDecoration(
                      labelText: "Birthday Month",
                      fillColor: whiteFontColor,
                      filled: true,
                      labelStyle: basicBlackBold,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: birthDay,
                    decoration: InputDecoration(
                      labelText: "Birthday Day",
                      fillColor: whiteFontColor,
                      filled: true,
                      labelStyle: basicBlackBold,
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: schoolController,
                    decoration: InputDecoration(
                      labelText: "School",
                      fillColor: whiteFontColor,
                      filled: true,
                      labelStyle: basicBlackBold,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(magenta),
                    textStyle: MaterialStateProperty.all(basicMediumWhite),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12))
                  ),
                  onPressed: () async {
                    context.read<AuthenticationProvider>().signUp(
                      email: SignUpForm.email,
                      password: SignUpForm.password,
                    );
                    User? user = await FirebaseAuth.instance.currentUser;
                    createUserProfile(user!.uid, SignUpForm.email, usernameController.text.trim(), birthMonth.text.trim(), birthDay.text.trim(), schoolController.text.trim());
                    FirebaseAuthUser.user = context.watch<User>();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePageContainer()),
                    );

                  },
                  child: Text("Sign Up"),
                ),
              
              ],
            )
          )
        ]
      ),
    );
  
  }
  _signUpBanner(){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        color: magenta,
      ),
      margin: EdgeInsets.symmetric(vertical:100),
      padding: EdgeInsets.symmetric(vertical:20),
      child: Text("SIGN-UP", style: pageBanner, textAlign: TextAlign.center,),
    );
  }

}