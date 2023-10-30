import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void CustomCupertinoModalPop({
  required BuildContext context,
  required String content
  }){
  showCupertinoModalPopup(
    context: context, 
    builder:(context) => CupertinoAlertDialog(
      title: Text(
        'Warning!',
        style: GoogleFonts.merriweather()
      ),
      content: Text(
        content,
        style: GoogleFonts.merriweather()
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
        child: Text(
          'OK',
          style: GoogleFonts.merriweather(),
        )
      )
      ],
    ),
  );
}