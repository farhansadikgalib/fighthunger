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