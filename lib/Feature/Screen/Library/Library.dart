import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:provider/provider.dart';

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
        title: Text(
          'Library.',
          style: GoogleFonts.luxuriousRoman(
            fontSize: 25
          ),
        ),
      ),
    );
  }
}