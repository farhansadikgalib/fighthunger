import 'package:cloud_firestore/cloud_firestore.dart';

createUserProfile(userID, email, username, month, day, school){
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    return users.doc(userID).set({
        'email': email,
        'username': username,
        'birthMonth': month, 
        'birthDay': day,
        'school': school,
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
  }
  addUser();
}