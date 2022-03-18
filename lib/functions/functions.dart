abstract class RetrievalObject{
  getName();
  getTime();
  getLocation();
  getDay();    
} 

class MergedUser {
  String? birthDay;
  String? birthMonth;
  String? email;
  String? uid;
  var school;

  MergedUser();

  MergedUser.fromMap(Map<String, dynamic> data) {
    birthDay = data['birthDay'];
    birthMonth = data['birthMonth'];
    email = data['email'];
    uid = data['uid'];
    school = data['school'];
  }

  Map<String, dynamic> toMap() {
    return {
      'birthDay': birthDay,
      'birthMonth': birthMonth,
      'email': email,
      'uid': uid,
      'school': school
    };
  }

  operator [](String s) => toMap()[s];
}

class School extends RetrievalObject {
  String? uid;
  var users;

  School(var schools, var users, String uid) {
    this.uid = uid;
    this.users = this._mergeUsers(users, schools);
  }

  _mergeUsers(users, schools) {
    List temp_users = [];

    for (int i = 0; i < users.length; i++) {
      MergedUser u = MergedUser();
      u.birthDay = users[i]["birthDay"];
      u.birthMonth = users[i]["birthMonth"];
      u.email = users[i]["email"];
      u.uid = users[i]["uid"];

      for (var school in schools) {
        if(users[i]["school"] == school["school"]) {
          u.school = school;
        }
      }
      
      temp_users.add(u);
    }
    
    return temp_users;
  }

  String _convertNum(number){
    int hour = (number/60).floor();
    int minute = number-(hour*60);
    String minuteStr = minute.toString();
    if(minute == 0){
      minuteStr = "00";
    }
    if(hour>12){
      return (hour-12).toString()+":"+minuteStr+"PM";
    }
    else{
      return hour.toString()+":"+minuteStr+"AM";
    }
  }

  @override
  getName() {
    for(var user in users){
      if(user["uid"] == uid){
       return user["school"]["school"];
      }
    }

    return "error";
  }


  @override
  getTime() {
    String? schoolVal = null;
    int index = 0;

    for(var user in users){
      if(user["uid"] == uid){
        var school = user["school"];
        return _convertNum(school["meetingsStart"]) + "-" + _convertNum(school["meetingsEnd"]);
      }
    }

    schoolCount(var user, int index){
      if(user["uid"] == uid){
        schoolVal=user["school"];
        return null;
      }
      return schoolCount(users[index],index+1);
    }

    return "error";
  }

  @override
  getLocation() {
    for(var user in users){
      if(user["uid"] == uid){
        return user["school"]["location"];
      }
    }

    return "error";
  }

  @override
  getDay() {    
    for(var user in users){
      if(user["uid"] == uid){
        return user["school"]["meetingDay"];
      }
    }

    return "error";
  }
}



