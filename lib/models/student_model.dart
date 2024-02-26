class Student {
  String id;
  String usn;
  String name;
  String email;
  String phone;
  String profile;
  String parentEmail;
  String dept;
  String sem;
  Map subjects;
  String facultyName;
  String facultyEmail;
  String facultyPhone;
  int alliedAP;
  int communityAP;
  Map result;

  Student({
    // personal
    required this.id,
    required this.usn,
    required this.name,
    required this.email,
    required this.phone,
    required this.profile,
    required this.parentEmail,
    // college
    required this.dept,
    required this.sem,
    required this.subjects,
    // faculty advisor
    required this.facultyName,
    required this.facultyEmail,
    required this.facultyPhone,
    required this.alliedAP,
    required this.communityAP,
    // result
    required this.result,
  });
}

const data = {
  "2BA20CS999": {
    // personal
    'id': "",
    'usn': "2BA20CS999",
    'name': "_",
    'email': "_",
    'phone': "_",
    'profile': '',
    'parentEmail': "_",
    // college
    'dept': "_",
    'sem': 1,
    'subjects': {
      'name': "_",
      'code': "_",
      'credits': 0,
      'total': 0.0,
      'marks': {'cie1': 0.0, 'cie2': 0.0, 'ass': 0.0},
    },
    // faculty
    'facultyName': "_",
    'facultyEmail': "_",
    'facultyPhone': "_",
    'alliedAP': 0,
    'communityAP': 0,
    //
    'result': {
      'cgpa': 0.0,
      'semwise': {
        '1': {
          'sem': 1,
          'sgpa': 0.0,
          'subwise': {
            'subcode': {
              'name': "_",
              'code': "_",
              'grade': "calc",
              'credits': 0,
              'total': 0.0,
              'marks': {'cie1': 0.0, 'cie2': 0.0, 'ass': 0.0},
            },
          },
        },
      },
    },
  },
};
