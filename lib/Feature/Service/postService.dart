// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kcgerp/Model/post.dart';
import 'package:kcgerp/Util/Additional/error_handling.dart';
import 'package:kcgerp/Util/Additional/snackbar.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:http/http.dart' as http;
class AddPostService{
  Future<List<Post>> DisplayAllForm(
  {
    required BuildContext context,
  }
  )async{
    List<Post> form = [];
    try {
      
      http.Response res = await http.get(
        Uri.parse('$uri/post/getAllPostData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            form.add(
              Post.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return form;
  }
}