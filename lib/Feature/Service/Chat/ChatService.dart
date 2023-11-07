import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:provider/provider.dart';

class ChatHelper {

static Future<dynamic> createChat(BuildContext context) async {
  try {
    final String apiUrl = "$uri/create-chat/";
    
    final studentProvider = Provider.of<StudentProvider>(context);
    final student = studentProvider.user;

    // Check if the token is expired and refresh it if necessary
    if (studentProvider.user.token.isEmpty) {
        print("TOken Null");
    }

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': student.token,
      },
      body: jsonEncode({"userId": student.id}),
    );

    if (response.statusCode == 200) {
      // Successful response
      print(response.body);
      return jsonDecode(response.body);
    } else {
      // Handle error responses
      print("Failed to access chat: ${response.statusCode}");
    }
  } catch (e) {
    // Handle exceptions
    print("Error accessing chat: $e");
  }
}


    static Future<List<dynamic>> getChats(BuildContext context) async {
    final String apiUrl = "$uri/get-chat/"; // Replace with your actual API endpoint

    try {
    final student = Provider.of<StudentProvider>(context).user;
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': '${student.token}'
        }
      );

      if (response.statusCode == 200) {
        // Successful response
        final List<dynamic> chatData = jsonDecode(response.body);
        return chatData;
      } else {
        // Handle error responses
        throw Exception("Failed to get chats: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exceptions
      throw Exception("Error getting chats: $e");
    }
  }
}
