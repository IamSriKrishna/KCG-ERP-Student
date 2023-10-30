

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
import 'package:kcgerp/Util/LocalNotification.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:kcgerp/route.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();
  await SharedPreferences.getInstance();

  Get.put(LanguageController()); // Initialize the LanguageController

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
          return Scaffold(body: Center(child: CircularProgressIndicator()));
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
