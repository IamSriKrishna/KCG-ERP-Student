import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/OverScreen.dart';
import 'package:kcgerp/Util/FontStyle/RobotoRegularFont.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/SplashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(milliseconds: 2950),(){
      Navigator.pushReplacementNamed(context, OverScreen.route);
    });
  }
  @override

  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, -0.0),
            child: Image.asset('asset/Logo/kcg.png',height: MediaQuery.of(context).size.height * 0.3)),
          Align(
            alignment: Alignment(0, 0.6),
            child: Lottie.asset('asset/lottie/load.json',height: 150,)),
          Align(
            alignment: Alignment(0, 0.95),
            child: RobotoRegularFont(text: 'Developed By Sri Krishna & Krithick',size: 9,)),
        ],
      ),
    );
  }
}