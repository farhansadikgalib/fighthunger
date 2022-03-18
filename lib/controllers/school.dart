import 'package:fighthunger/models/MergedUser.dart';
import 'package:fighthunger/models/RetrievalObject.dart';

class School extends RetrievalObject {
  String? uid;
  var users;

  School(var schools, var users, String uid) {
    this.uid = uid;
    this.users = this._mergeUsers(users, schools);
  }

  dynamic? _getSchool(name,schools, {int idx = 0}) {
    if (idx > schools.length - 1) return null;
    if (schools[idx]["school"] == name) return schools[idx];
    return _getSchool(name, schools, idx: idx + 1);
  }

  MergedUser? _getUser(uid, {int idx = 0}) {
    if(idx > users.length - 1) return null;
    if (users[idx]["uid"] == uid) return users[idx];
    return _getUser(uid, idx: idx + 1);
  }

  _mergeUsers(users, schools) {
    List temp_users = [];

    for (int i = 0; i < users.length; i++) {
      MergedUser u = MergedUser();
      u.birthDay = users[i]["birthDay"];
      u.birthMonth = users[i]["birthMonth"];
      u.email = users[i]["email"];
      u.uid = users[i]["uid"];
      u.school = _getSchool(users[i]["school"], schools);
      
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
    return _getUser(uid)?["school"]["school"] ?? "error";
  }


  @override
  getTime() {
    var school = _getUser(uid)?["school"] ?? "error";
    if(school == "error") return school;

    return _convertNum(school["meetingsStart"]) + "-" + _convertNum(school["meetingsEnd"]);
  }

  @override
  getLocation() {
    return _getUser(uid)?["school"]["location"] ?? "error";
  }

  @override
  getDay() {   
    return _getUser(uid)?["school"]["meetingDay"] ?? "error";
  }
}



