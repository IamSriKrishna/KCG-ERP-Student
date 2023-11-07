
import 'package:flutter/material.dart';
import 'package:kcgerp/Model/Student.dart';

class StudentProvider extends ChangeNotifier {
  Student _user = Student(
      id: '',
      name: '',
      fcmtoken: '',
      certified:false,
      rollno: '',
      password: '',
      year: '',
      Studentclass: '',
      credit: 0,
      department: '',
      dp: '',
      token: '',
  );

  Student get user => _user;
  
  void setUser(String user) {
    _user = Student.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(Student user) {
    _user = user;
    notifyListeners();
  }

  
  void signOut() {
    _user = Student(
      id: '',
      name: '',
      fcmtoken: '',
      certified:false,
      rollno: '',
      password: '',
      year: '',
      Studentclass: '',
      credit: 0,
      department: '',
      dp: '',
      token: '',
    );
    
    notifyListeners();
  }
}