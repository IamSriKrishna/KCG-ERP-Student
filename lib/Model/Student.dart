import 'dart:convert';

class Student {
  final String id;
  final String name;
  final bool certified;
  final String rollno;
  final String password;
  final int credit;
  final String fcmtoken;
  final String department;
  final String token;
  final String dp;
  final String Studentclass;
  final String year;
  final List<dynamic> followers;
  final List<dynamic> following;
  Student({
    required this.id,
    required this.name,
    required this.fcmtoken,
    required this.certified,
    required this.rollno,
    required this.password,
    required this.department,
    required this.credit,
    required this.token,
    required this.dp,
    required this.year,
    required this.Studentclass,
    required this.followers,
    required this.following
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'certified':certified,
      'rollno': rollno,
      'password': password,
      'credit': credit,
      'fcmtoken':fcmtoken,
      "department":department,
      'dp':dp,
      'year':year,
      'Studentclass':Studentclass,
      'following':following,
      'followers':followers,
      'token': token,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      certified:map['certified']??false,
      rollno: map['rollno'] ?? '',
      fcmtoken:map['fcmtoken'] ?? '',
      password: map['password'] ?? '',
      dp:map["dp"]??'',
      year:map['year']??'',
      followers:map['followers']??[],
      following:map['following']??[],
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
    bool? certified,
    String? department,
    String? dp,
    String? fcmtoken,
    String? Studentclass,
    String? year,
    List<dynamic>? following,
    List<dynamic>? followers,
    int? credit,
    String? token,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      certified:certified??this.certified,
      dp:dp?? this.dp,
      fcmtoken:fcmtoken??this.fcmtoken,
      followers: followers??this.followers,
      following: following??this.following,
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