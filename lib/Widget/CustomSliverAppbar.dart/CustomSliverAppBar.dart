import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Home/Widget/Additional/TopMainScreen.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Util/FontStyle/RobotoBoldFont.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class CustomSliverAppBar extends StatelessWidget {
  final String text;
  final IconData? icon1;
  final IconData? icon2;
  final IconData? leadingIcon;
  final double? leadingWidth;
  final void Function()? icon1OnTap;
  final void Function()? icon2OnTap;
  final void Function()? leadingOnTap;
  const CustomSliverAppBar({
    super.key,
    required this.text,
    this.icon1,
    this.icon1OnTap,
    this.icon2,
    this.icon2OnTap,
    this.leadingIcon,
    this.leadingOnTap,
    this.leadingWidth,
    });
Future<void> sendNotification() async {
  final String apiUrl = '$uri/send-notification'; // Replace with your API URL

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  Map<String, dynamic> requestBody = {
    'registrationToken': 'cdm6bOT7S9ehnWbSgy4osT:APA91bEpNcDQZlR-Q6wdtmswm1cdMkRoOgjeQmUPqp3sZ6N24iIoWdb8ZBjBQQZIn3F9mYRMHpOrNluUDxG03DuEZhJIRalkUwCQ-aTxX1Zqk2u97qmd-Zs0aUp1nIOlVk7AcC5v2xSP',
    'body': 'sent',
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Error sending notification: ${response.statusCode}');
      // You can handle the error response here
    }
  } catch (e) {
    print('Exception while sending notification: $e');
    // Handle the exception
  }
}
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return SliverAppBar(
      leadingWidth: leadingWidth,
        leading: GestureDetector(
          onTap: leadingOnTap,
          child: Icon(leadingIcon,color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,),
        ),
        backgroundColor:theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
        title: RobotoBoldFont(
          text: text, 
          textColor:theme.getDarkTheme?themeColor.backgroundColor: themeColor.appBarColor,
        ),
        elevation: 10,
        bottom: TopMainScreen(context: context,),
        actions: [
          GestureDetector(
            onTap: (){
              sendNotification();
            } ,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon2,
                color:theme.getDarkTheme?themeColor.backgroundColor:  themeColor.appBarColor,
                ),
            ),
          ),
          GestureDetector(
            onTap: icon1OnTap ,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon1,
                color: theme.getDarkTheme?themeColor.backgroundColor: themeColor.appBarColor,
                ),
            ),
          ),
        ],
      );
  }
}


class NotificationCustomSliverAppBar extends StatelessWidget {
  final String text;
  final IconData? icon1;
  final IconData? icon2;
  final IconData? leadingIcon;
  final double? leadingWidth;
  final void Function()? icon1OnTap;
  final void Function()? icon2OnTap;
  final void Function()? leadingOnTap;
  const NotificationCustomSliverAppBar({
    super.key,
    required this.text,
    this.icon1,
    this.icon1OnTap,
    this.icon2,
    this.icon2OnTap,
    this.leadingIcon,
    this.leadingOnTap,
    this.leadingWidth,
    });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return SliverAppBar(
      leadingWidth: leadingWidth,
        leading: GestureDetector(
          onTap: leadingOnTap,
          child: Icon(leadingIcon,color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,),
        ),
        backgroundColor:theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
        title: RobotoBoldFont(
          text: text, 
          textColor:theme.getDarkTheme?themeColor.backgroundColor: themeColor.appBarColor,
        ),
        elevation: 10,
        actions: [
          GestureDetector(
            onTap: icon2OnTap ,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon2,
                color:theme.getDarkTheme?themeColor.backgroundColor:  themeColor.appBarColor,
                ),
            ),
          ),
          GestureDetector(
            onTap: icon1OnTap ,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon1,
                color: theme.getDarkTheme?themeColor.backgroundColor: themeColor.appBarColor,
                ),
            ),
          ),
        ],
      );
  }
}