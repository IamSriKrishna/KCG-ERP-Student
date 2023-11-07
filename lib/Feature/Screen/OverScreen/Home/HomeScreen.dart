import 'package:flutter/material.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Home/Widget/MainScreen.dart';
import 'package:kcgerp/Feature/Screen/Messenger/MessageScreen.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/HomeScreen';
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
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          ShowCaseWidget(
            builder: Builder(builder:(context) => MainScreen(
                icon1OnTap: () {
                  _controller.nextPage(duration:const  Duration(
                    milliseconds: 250
                  ), curve: Curves.ease);
                },
              ),)
          ),
          MessageScreen(
            icon1OnTap: () async{
              await _controller.previousPage(duration:const  Duration(
                milliseconds: 250
              ), curve: Curves.ease);
            },)
        ],
      ),
    );
  }
}