import 'package:flutter/material.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Home/Widget/MainScreen.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Home/Widget/Notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          MainScreen(
            icon1OnTap: () {
              _controller.nextPage(duration:const  Duration(
                milliseconds: 250
              ), curve: Curves.linear);
            },
          ),
          NotificationScreen(
            icon1OnTap: () {
              _controller.previousPage(duration:const  Duration(
                milliseconds: 250
              ), curve: Curves.linear);
            },)
        ],
      ),
    );
  }
}