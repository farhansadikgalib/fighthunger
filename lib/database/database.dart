import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fighthunger/models/schools.dart';

createUserProfile(userID, email, username, month, day, school){
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    return users.doc(userID).set({
        'email': email,
        'username': username,
        'birthMonth': month, 
        'birthDay': day,
        'school': school,
        'uid': userID,
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
  }
  addUser();
}

getSchools(school) async{
  // UserID user = Provider.of<UserID>(context);
  // String userId = user.uid;
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('schools')
      // .where("userId", isEqualTo: userId)
      .get();

  List<Schools> _schoolsList = [];

  snapshot.docs.forEach((document) {
    Schools schools = Schools.fromMap(document.data());
    _schoolsList.add(schools);
    print(document.data());
  });
  return _schoolsList;

}

addIdea(String idea){
  CollectionReference ideas = FirebaseFirestore.instance.collection('ideas');
  ideas
    .add({
      'title': idea, 
    })
    .then((value) => print("Idea Added"))
    .catchError((error) => print("Failed to add user: $error"));
  
}