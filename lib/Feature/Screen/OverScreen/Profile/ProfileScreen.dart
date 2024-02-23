import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Profile/Widget/ProfBackground.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Profile/Widget/ProfileBottomWidget.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  final GlobalKey themeMode = GlobalKey();
  final GlobalKey myProfile = GlobalKey();
  final GlobalKey forgetPIN = GlobalKey();
  final GlobalKey language = GlobalKey();
  final GlobalKey signOut = GlobalKey();



    void initState() {
      checkShowcaseStatus();
      super.initState();
    }
    Future<void> checkShowcaseStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final showcaseShown = prefs.getBool('showcaseShown') ?? false;

    if (!showcaseShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([themeMode, myProfile,forgetPIN,language,signOut]);
      });

      await prefs.setBool('showcaseShown', true);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            ProBackground(theme: themeMode,),
            ProfileBottomWidget(
              myProfile: myProfile, 
              forgetPIN: forgetPIN, 
              language: language, 
              signOut: signOut
            )
          ],
        ),
      ),
    );
  }
}