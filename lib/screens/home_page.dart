import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fighthunger/database/database.dart';
import 'package:fighthunger/functions/functions.dart';
import 'package:fighthunger/models/user.dart';
import 'package:fighthunger/style/global.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../database/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        // for(var u in snapshot.data!.docs){
        //   // print(item.id);
        // }
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }
        List users = snapshot.data!.docs.toList();
        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('schools').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            for(var item in snapshot.data!.docs){
              print(item.id);
            }
            if(!snapshot.hasData){
              return CircularProgressIndicator();
            }
            print(FirebaseAuthUser.user.uid);
            List schools = snapshot.data!.docs.toList();
            School school = new School(schools, users, FirebaseAuthUser.user.uid);
            return Scaffold(
              backgroundColor: lightBlue,
              body: Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        // color: Color(0xFF0d653b)
                      ),
                      child: Text("Welcome to",style:TextStyle(fontSize: 30), textAlign: TextAlign.center,),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: green
                      ),
                      child: Text(school.getName(),style:basicLargeWhite, textAlign: TextAlign.center,),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: lightGrey
                      ),
                      child: Text("Fighting Hunger Club",style:basicLargeBlack, textAlign: TextAlign.center,),
                    ),
                    
                    
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: softPink,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  // margin: EdgeInsets.symmetric(),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: verySoftPink,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                        ),
                                        padding: EdgeInsets.all(10),
                                        width: MediaQuery.of(context).size.width-40,
                                        // width: double.infinity,
                                        child: Text("Meetings", style: basicBlackBold,),
                                      ),
                                  
                                    ]
                                  )
                                ),
                                SizedBox(height: 40),
                                Text(school.getDay(), style: basicBlackBold),
                                Text(school.getTime(), style: basicBlackBold),
                                Text(school.getLocation(), style: basicBlackBold), 
                              ]
                            )
                          )
                        ],
                      )
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        FirebaseAuth.instance.signOut();
                      }, 
                      child: Text("Sign Out")
                    ),
                    
                    
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
}