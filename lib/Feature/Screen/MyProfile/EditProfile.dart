import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Util/FontStyle/RobotoBoldFont.dart';
import 'package:kcgerp/Util/FontStyle/RobotoRegularFont.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  static const route = '/EditProfile';
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final my = Provider.of<StudentProvider>(context).user;
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(top:16.0,left: 10),
            child: RobotoRegularFont(
              text: S.current.cancel,
              size: 14,
              textColor: theme.getDarkTheme?themeColor.themeColor:themeColor.appThemeColor,
            ),
          ),
        ),
        backgroundColor: theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top:16.0,right: 10),
              child: RobotoRegularFont(
                text: 'Done',
                size: 14,
                textColor: Colors.blue,
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: my.dp,
                  width: MediaQuery.of(context).size.width * 0.215,
                  height: MediaQuery.of(context).size.height * 0.1,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: 
                  (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color:theme.getDarkTheme?themeColor.themeColor: themeColor.appThemeColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: RobotoBoldFont(
                text: 'Change Profile Picture',
                textColor: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }
}