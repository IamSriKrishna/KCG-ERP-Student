import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProfileDetails extends StatelessWidget {
  final String title;
  final String hint;
  final double left;
  const CustomProfileDetails({
    super.key,
    required this.title,
    required this.hint,
    required this.left
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.merriweatherSans(
            fontSize: 15.5
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left:left),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: hint
              ),
            ),
          ),
        )
      ],
    );
  }
}