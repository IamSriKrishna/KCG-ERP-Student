import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:provider/provider.dart';
class NotificationService{
  void sendNotifications({
    required BuildContext context,
    required List<String> toAllFaculty
  }) async {
    final student = Provider.of<StudentProvider>(context).user;
    final Map<String, dynamic> requestData = {
      "registrationTokens": toAllFaculty,
      "body": "Form Request Recieved from ${student.name}", 
    };

    final response = await http.post(
      Uri.parse('$uri/send-notification-toAll'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      print('Successfully sent');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to send notifications"),
        ),
      );
    }
  }
}