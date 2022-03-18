class Schools {
  // String id;
  String? school;
  String? location;
  int? meetingStart;
  int? meetingEnd;

  Schools();

  Schools.fromMap(Map<String, dynamic> data) {
    // id = data['id'];
    school = data['school'];
    location = data['location'];
    meetingStart = data['meetingStart'];
    meetingEnd = data['meetingEnd'];
  }

  Map<String, dynamic> toMap() {
    return {
      'school': school,
      'location': location,
      'meetingStart': meetingStart,
      'meetingEnd': meetingEnd
    };
  }
}