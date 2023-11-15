import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kcgerp/Constrains/ThemeStyle.dart';
import 'package:kcgerp/Feature/Screen/NoInternet.dart';
import 'package:kcgerp/Feature/Screen/OnBoard/OnboardScreen.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/OverScreen.dart';
import 'package:kcgerp/Feature/Service/Authservice.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Profile/Widget/LanguageContoller.dart';
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Provider/chat_provider.dart';
import 'package:kcgerp/Util/Additional/Loader.dart';
import 'package:kcgerp/Util/LocalNotification.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:kcgerp/route.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Firebase.initializeApp(
    options:FirebaseOptions(
      apiKey: 'AIzaSyCishefTquUez42NWNNToO61QKxIomFJkE', 
      appId: '1:879927221521:android:e890f086f7ad445eb1c0b0', 
      messagingSenderId: '879927221521', 
      projectId: 'campuslink-d1f2d'
    )
    );
  showFlutterNotification(message);
  print('Handling a background message ${message.senderId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) async{
  final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  RemoteNotification? notification = message.notification;
      const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, notification!.title, notification.body, notificationDetails, );

  isFlutterLocalNotificationsInitialized = true;
}
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyCishefTquUez42NWNNToO61QKxIomFJkE', 
      appId: '1:879927221521:android:e890f086f7ad445eb1c0b0', 
      messagingSenderId: '879927221521', 
      projectId: 'campuslink-d1f2d'
    )
  ):Firebase.initializeApp(); 
  await LocalNotifications.init();
  FirebaseMessaging.instance.getToken().then((value)async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('fcmToken', value!);
  });
  await SharedPreferences.getInstance();
  Get.put(LanguageController());

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
            ),
            ChangeNotifierProvider(
              create: (context) => ChatNotifier(),
            ),
          ],child: MyApp(), 
        )
    
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  
  String locale = ''; 
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    _requestNotificationPermission();
    
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    authService.getUserData(context);
    loadSelectedLanguage();
  }

Future<void> loadSelectedLanguage() async {
  final pref = GetStorage(); // Use GetStorage to retrieve the selected language subcode
  setState(() {
    locale = pref.read('locale') ?? 'en';
  });
}

Future<void> _requestNotificationPermission() async {
    await Permission.notification.request();
}
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
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
              } 
              else if(snapshot.connectionState == ConnectionState.none){
                return NoInternet();
              }
              else if (snapshot.hasError) {
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
