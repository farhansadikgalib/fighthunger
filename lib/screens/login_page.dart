import 'package:fighthunger/models/signup.dart';
import 'package:fighthunger/screens/sign_up.dart';
import 'package:fighthunger/style/global.dart';

import 'authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  //Controllers for e-mail and password textfields.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  //Handling signup and signin
  bool signUp = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              color: magenta,
            ),
            margin: EdgeInsets.symmetric(vertical:100),
            padding: EdgeInsets.symmetric(vertical:20),
            child: Text(signUp ? "SIGN-UP" : "LOG-IN", style: pageBanner, textAlign: TextAlign.center,),
          ),
          Container(
            width: MediaQuery.of(context).size.width*.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      fillColor: whiteFontColor,
                      filled: true,
                      labelStyle: basicBlackBold,
                    ),
                  ),
                ),
                
                //password textfield
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      fillColor: whiteFontColor,
                      filled: true,
                      labelStyle: basicBlackBold,
                    ),
                  ),
                ),
                
                //Sign in / Sign up button
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(magenta),
                    textStyle: MaterialStateProperty.all(basicMediumWhite),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12))
                  ),
                  onPressed: () {
                    if (signUp) {
                      //Provider sign up method 
                      // print(context.read<AuthenticationProvider>().signUp(
                      //       email: emailController.text.trim(),
                      //       password: passwordController.text.trim(),
                      //     ));
                      SignUpForm.email = emailController.text.trim();
                      SignUpForm.password = passwordController.text.trim();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    } else {
                    //Provider sign in method
                      context.read<AuthenticationProvider>().signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                    }
                  },
                  child: signUp ? Text("Sign Up") : Text("Sign In"),
                ),
                
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(darkGrey),
                    textStyle: MaterialStateProperty.all(basicMediumWhite),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12))
                  ),
                  onPressed: () {
                    setState(() {
                      signUp = !signUp;
                    });
                  },
                  child: signUp ? Text("Have an account? Sign In") : Text("Create an account"),
                )
              
              ],
            )
          )
        ]
      ),
    );
  
  }

}