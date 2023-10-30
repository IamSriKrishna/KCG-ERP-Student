import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kcgerp/Util/util.dart';
class PasswordService{
  //Change password Using Old Password
  Future<void> updatePassword(String currentPassword, String newPassword) async {
    final String apiUrl = '$uri/kcg/student/update-password';
    
    final Map<String, dynamic> requestBody = {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };

    final response = await http.put(
      Uri.parse(apiUrl),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Password updated successfully
      print('Password updated successfully');
    } else if (response.statusCode == 400) {
      // Current password is incorrect
      print('Current password is incorrect');
    } else {
      // Handle other errors, e.g., server errors
      print('Error: ${response.statusCode}');
    }
  }

  //Change password Using Old Password
  Future<void> changePassword(String newPassword) async {
    final String apiUrl = '$uri/kcg/student/change-password';

    final Map<String, dynamic> requestBody = {
      'newPassword': newPassword,
    };

    final response = await http.put(
      Uri.parse(apiUrl),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Password changed successfully
      print('Password changed successfully');
    } else {
      // Handle errors, e.g., server errors
      print('Error: ${response.statusCode}');
    }
  }
}