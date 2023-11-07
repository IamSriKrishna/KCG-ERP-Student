import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:provider/provider.dart';

class MesssagingHelper {

Future<Map<String, dynamic>?> sendMessage({
    required String content,
    required String chatId,
    required String receiver,
    required BuildContext context
  }) async {
    
    final student = Provider.of<StudentProvider>(context).user;
    if (content.isEmpty || chatId.isEmpty) {
      print("Invalid data passed into request");
      return null; 
    }

    final newMessage = {
      "sender": student.id, 
      "content": content,
      "receiver": receiver,
      "chat": chatId,
    };

    try {
      final response = await http.post(
        Uri.parse('$uri/send-message/'), // Replace with your API endpoint.
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': '${student.token}'
        },
        body: jsonEncode(newMessage),
      );

      if (response.statusCode == 200) {
        final message = jsonDecode(response.body);

        return message;
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null; 
      }
    } catch (error) {
      print("Error: $error");
      return null;
    }
  }

Future<List<dynamic>> getAllMessages(String chatId, int page,BuildContext context) async {
    try {
      final student = Provider.of<StudentProvider>(context).user;

      final Uri url = Uri.parse('$uri/get-message/$chatId');
      final Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': '${student.token}'
        };
      final Map<String, dynamic> requestData = {
        "chatId": chatId,
        "page": page.toString(),
      };

      final http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        final List<dynamic> messages = jsonDecode(response.body);

        // You can now handle the list of messages as needed.

        return messages;
      } else {
        // Handle the error response here.
        print("Request failed with status: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      // Handle the error here.
      print("Error: $error");
      return [];
    }
  }

}
