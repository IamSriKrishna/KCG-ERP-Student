import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:provider/provider.dart';
class NotificationService{
  sendNotificationtoOne(String registrationToken, String body) async {
  final String url = "$uri/send-notification"; 
  final Map<String, dynamic> requestBody = {
    'registrationToken': registrationToken,
    'body': body,
  };

  final headers = {
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("Notification sent successfully");
    } else {
      print("Failed to send notification: ${response.statusCode}");
    }
  } catch (e) {
    print("Error sending notification: $e");
  }
}
  void sendNotifications({
    required BuildContext context,
    required List<String> toAllFaculty,
    required String body,
  }) async {
    final student = Provider.of<StudentProvider>(context,listen: false).user;
    final Map<String, dynamic> requestData = {
      "registrationTokens": toAllFaculty,
      "body": body, 
    };

    final response = await http.post(
      Uri.parse('$uri/send-notification-toAll'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      //print('Successfully sent');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to send notifications"),
        ),
      );
    }
  }
}