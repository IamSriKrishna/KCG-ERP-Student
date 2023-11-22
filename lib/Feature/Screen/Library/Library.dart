import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
      body: CustomScrollView(
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
            itemCount: 3,
            itemBuilder:(context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 5),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.22,
                  width: double.infinity,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    color: theme.getDarkTheme?themeColor.darkTheme.withOpacity(0.15):themeColor.themeColor.withOpacity(0.2),
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.width * 0.32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage('https://www.readm.org/uploads/chapter_files/cover/tbn/1587296988_198x0.jpg')
                            )
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.045,
                                  width: double.infinity,
                                  child: Text(
                                    'Engineering',
                                    maxLines: 2,
                                    style: GoogleFonts.luxuriousRoman(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0,top: 8),
                                child: Text(
                                  '16 Authors',
                                  style: GoogleFonts.luxuriousRoman(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300
                                  ),
                                ),
                              ),
                              Gap(20),
                              Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${24}',
                                        style: GoogleFonts.luxuriousRoman(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        ' Books',
                                        style: GoogleFonts.luxuriousRoman(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                  ),
              );
          },)
        ],
      ),
    );
  }
}