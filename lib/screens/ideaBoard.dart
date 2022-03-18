import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fighthunger/database/database.dart';
import 'package:fighthunger/style/global.dart';
import '../database/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';



class Ideas extends StatelessWidget {

  final TextEditingController ideaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('ideas').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }
        List ideas = snapshot.data!.docs.toList();
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
                  child: Text("Idea Board",style:basicLargeBlack, textAlign: TextAlign.center,),
                ),
                
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  height: 400,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: softPink,
                    borderRadius: BorderRadius.circular(40)
                  ),
                  child: Column(
                    children:[
                      Container(
                        margin: EdgeInsets.all(30),
                        child: TextField(
                          controller: ideaController,
                          decoration: InputDecoration(
                            labelText: "Idea(Unique)",
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
                        onPressed: () {
                          addIdea(ideaController.text.trim());
                        },
                        child: Text("Submit"),
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: ideas.length,
                          itemBuilder: (context, index){
                            return Container(
                              child: Text(ideas[index]["title"]),
                              padding: EdgeInsets.all(7),
                              margin: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: verySoftPink,
                                boxShadow: const [
                                  BoxShadow(color: Colors.purple, spreadRadius: 2),
                                ],
                              ),
                            );
                          })
                      ),
                    ]
                  )
                )
                                          
                
              ],
            ),
          ),
        );
      }
    );
  }
}