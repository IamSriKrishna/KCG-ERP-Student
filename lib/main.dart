

import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kcgerp/Constrains/ThemeStyle.dart';
import 'package:kcgerp/Feature/Screen/OnBoard/OnboardScreen.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/OverScreen.dart';
import 'package:kcgerp/Feature/Service/Authservice.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Profile/Widget/LanguageContoller.dart';
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Util/Additional/Loader.dart';
import 'package:kcgerp/Util/LocalNotification.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:kcgerp/route.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyCishefTquUez42NWNNToO61QKxIomFJkE', 
      appId: '1:879927221521:android:c46c67a6f1ea8b6eb1c0b0', 
      messagingSenderId: '879927221521', 
      projectId: 'campuslink-d1f2d'
    )
  ):Firebase.initializeApp(); 
  await LocalNotifications.init();
  FirebaseMessaging.instance.getToken().then((value)async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('fcmToken', value!);
  print('main file la print agudhu:$value');
  });
  await SharedPreferences.getInstance();
  Get.put(LanguageController()); // Initialize the LanguageController

  FirebaseMessaging.onBackgroundMessage((message) => 
    firebaseMessaginBackgroundHandler(message)
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) =>  runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => DarkThemeProvider(),
              child: MyApp(),
            ),
            ChangeNotifierProvider(
              create: (context) => StudentProvider(),
            )
          ],child: MyApp(), 
        )
    
  ));
}

Future<void> firebaseMessaginBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
  print('FirebaseMessageing:$message');
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String locale = ''; 
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true
    );
    _firebaseMessaging.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true
    );
    authService.getUserData(context);
    loadSelectedLanguage();
  }

Future<void> loadSelectedLanguage() async {
  final pref = GetStorage(); // Use GetStorage to retrieve the selected language subcode
  setState(() {
    locale = pref.read('locale') ?? 'en';
  });
}


  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
      builder: (context, darkThemeProvider, child) {
        return GetMaterialApp(
          localizationsDelegates: [
            S.delegate, 
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          locale: Get.find<LanguageController>().getLocale(),
          supportedLocales: S.delegate.supportedLocales,
          theme:  Styles().themeData(darkThemeProvider.getDarkTheme, context),
          debugShowCheckedModeBanner: false,
          home:FutureBuilder(
            future: authService.getUserData(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(body: Center(child: Loader()));
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final student = Provider.of<StudentProvider>(context).user;
                if (student.token.isNotEmpty) {
                  return OverScreen();
                } else {
                  return OnBoardScreen();
                }
              }
            },
          ),
          onGenerateRoute: (settings) => onGenerator(settings,locale),
        );
      },
    );
  }
}
