
import 'package:flutter/material.dart';
import 'package:kcgerp/Feature/Screen/MyProfile/EditProfile.dart';
import 'package:kcgerp/Feature/Screen/MyProfile/Widget/MyProfileTopScreen.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Util/FontStyle/RobotoBoldFont.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatelessWidget {
  static const route = '/MyProfile';
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final my = Provider.of<StudentProvider>(context).user;
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: Icon(null),
        backgroundColor: theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
        title: Row(
          children: [
            RobotoBoldFont(text: my.rollno),
            my.certified==true?
            Image.asset('asset/tick.png',height: MediaQuery.of(context).size.height * 0.02,)
            :Text('')
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.favorite_outlined,color: Colors.red,),
          )
        ],
      ),
      body: Column(
        children: [
          MyProfileTopScreen(
            name: my.name, 
            department: my.department, 
            dp: my.dp
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: Size(
                MediaQuery.of(context).size.width * 0.9, 
                MediaQuery.of(context).size.height * 0.04
              ),
              backgroundColor: themeColor.appThemeColor,
              foregroundColor: themeColor.themeColor
            ),
            onPressed: (){
              Navigator.pushNamed(context, EditProfile.route);
            }, 
            child: RobotoBoldFont(text: 'Edit My Profile',size: 12,)
          )
        ],
      ),
    );
  }
}