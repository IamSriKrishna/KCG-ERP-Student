
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Util/Additional/Page.dart';
import 'package:kcgerp/Util/CustomBottomBavigation/CustomCurvedNavigation.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';

class OverScreen extends StatefulWidget {
  static const route = '/OverScreen';
  const OverScreen({super.key});

  @override
  State<OverScreen> createState() => _OverScreenState();
}

class _OverScreenState extends State<OverScreen> {

  
  @override
  void initState() {
    super.initState();
  }
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return  WillPopScope(
      onWillPop: ()async {
        await showCupertinoModalPopup<void>(
          context: context, 
          builder:(context) => CupertinoAlertDialog(
            title: Text(
              S.current.warning,
              style: GoogleFonts.merriweather()
            ),
            content: Text(
              S.current.wanttoexitcampuslink,
              style: GoogleFonts.merriweather()
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
              child: Text(
                S.current.no,
                style: GoogleFonts.merriweather(),
              )
            ),
            
              TextButton(
                onPressed: (){
                  SystemNavigator.pop();
                }, 
              child: Text(
                S.current.yes,
                style: GoogleFonts.merriweather(),
              )
            ),
            ],
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: theme.getDarkTheme?themeColor.darkTheme: themeColor.backgroundColor,
        body: page[_currentIndex],
        bottomNavigationBar: CustomCurvedNavigation(
          backgroundColor:screenBackGroundColor[_currentIndex],
          onTabChange: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          index: _currentIndex,
        ),
      ),
    );
  }
}