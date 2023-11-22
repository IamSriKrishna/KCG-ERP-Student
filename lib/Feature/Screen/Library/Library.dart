import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Feature/Screen/Library/LibraryExpand/LibraryExpand.dart';
import 'package:kcgerp/Feature/Screen/Library/Widget/LibraryCustomSliverList.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:provider/provider.dart';

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
            title: Text(
              'Library.',
              style: GoogleFonts.luxuriousRoman(
                fontSize: 25
              ),
            ),
          ),
          SliverList.builder(
            itemCount: 22,
            itemBuilder:(context, index) {
              return LibraryCustomSliverList(
                onTap: () {
                  Get.to(()=>LibraryExpand(
                    Screentitle: 'Engineering',
                  )
                  );
                },
                no_of_authors: 18, 
                no_of_Books: 24, 
                subject: 'Engineering'
              );
          },)
        ],
      ),
    );
  }
}