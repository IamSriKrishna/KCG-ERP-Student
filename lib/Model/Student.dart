import 'dart:convert';

class Student {
  final String id;
  final String name;
  final String rollno;
  final String password;
  final int credit;
  final String fcmtoken;
  final String department;
  final String token;
  final String dp;
  final String Studentclass;
  final String year;
  Student({
    required this.id,
    required this.name,
    required this.fcmtoken,
    required this.rollno,
    required this.password,
    required this.department,
    required this.credit,
    required this.token,
    required this.dp,
    required this.year,
    required this.Studentclass
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rollno': rollno,
      'password': password,
      'credit': credit,
      'fcmtoken':fcmtoken,
      "department":department,
      'dp':dp,
      'year':year,
      'Studentclass':Studentclass,
      'token': token,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      rollno: map['rollno'] ?? '',
      fcmtoken:map['fcmtoken'] ?? '',
      password: map['password'] ?? '',
      dp:map["dp"]??'',
      year:map['year']??'',
      Studentclass:map['Studentclass']??'',
      department:map['department']?? '',
      credit: map['credit'] ?? 0,
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) => Student.fromMap(json.decode(source));

  Student copyWith({
    String? id,
    String? name,
    String? rollno,
    String? password,
    String? department,
    String? dp,
    String? fcmtoken,
    String? Studentclass,
    String? year,
    int? credit,
    String? token,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      dp:dp?? this.dp,
      fcmtoken:fcmtoken??this.fcmtoken,
      year:year??this.year,
      Studentclass:Studentclass??this.Studentclass,
      department: department??this.department,
      rollno: rollno ?? this.rollno,
      password: password ?? this.password,
      credit: credit ?? this.credit,
      token: token ?? this.token,
    );
  }
}