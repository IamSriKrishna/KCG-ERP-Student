import 'package:flutter/material.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Home/Widget/Additional/PostCard.dart';
import 'package:kcgerp/Widget/CustomSliverAppbar.dart/CustomSliverAppBar.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';

class MainScreen extends StatelessWidget {
  final void Function() icon1OnTap;
  const MainScreen({super.key,required this.icon1OnTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder:(context, innerBoxIsScrolled) {
          return [
            CustomSliverAppBar(
              leadingWidth: 0,
              text: S.current.myClass,
              icon1: Icons.notifications_active_outlined,
              icon1OnTap: icon1OnTap,
              icon2: Icons.search,
              ),
          ];
          
        }, 
        body:ListView.builder(
          itemCount: 1,
                itemBuilder:(context, index) => PostCard(),
              ),
      ),
    );
  }
}