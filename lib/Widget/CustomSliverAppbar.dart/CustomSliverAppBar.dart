import 'package:flutter/material.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Home/Widget/Additional/TopMainScreen.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Util/FontStyle/RobotoBoldFont.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:provider/provider.dart';

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