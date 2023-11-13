
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Util/Additional/Page.dart';
import 'package:kcgerp/Util/CustomBottomBavigation/CustomCurvedNavigation.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
class OverScreen extends StatefulWidget {
  static const route = '/OverScreen';
  const OverScreen({super.key});

  @override
  State<OverScreen> createState() => _OverScreenState();
}

class _OverScreenState extends State<OverScreen> {

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;


  getConnectivity() => subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            // Check if the widget is still mounted before showing the dialog
            if (mounted) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          }
        },
      );
  @override
  void initState() {
    super.initState();
    getConnectivity();
  }
  int _currentIndex = 0;
 @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return  Scaffold(
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
    );
  }
  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}