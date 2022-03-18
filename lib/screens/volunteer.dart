import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fighthunger/style/global.dart';
import '../database/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';



class Volunteer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('volunteer').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }
        List volunteer = snapshot.data!.docs.toList();
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
                    color: lightGrey
                  ),
                  child: Text("Volunteer Opputunities",style:basicLargeBlack, textAlign: TextAlign.center,),
                ),
                
                
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: volunteer.length,
                  itemBuilder: (context, index){
                    return Container(
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
                            decoration: BoxDecoration(
                              color: verySoftPink,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                            ),
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(volunteer[index]["name"], style: basicBlackBold,),
                                Row(
                                  children: [
                                    Container(

                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(volunteer[index]["description"], style: basicBlackBold,),
                          ElevatedButton(
                            onPressed: () async{
                              await launch(volunteer[index]["action"], forceSafariVC: false);
                            }, 
                            child: Container(
                              child: Text("More"),
                            )
                          )
                          // Text("Fridays", style: basicBlackBold),
                          // Text("3:00PM-4:00PM", style: basicBlackBold),
                          // Text("Room 1214", style: basicBlackBold), 
                        ],
                      )
                    );
                  })
                                          
                
              ],
            ),
          ),
        );
      }
    );
  }
}