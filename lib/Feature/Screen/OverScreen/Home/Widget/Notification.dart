import 'package:flutter/material.dart';
import 'package:kcgerp/Widget/CustomSliverAppbar.dart/CustomSliverAppBar.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';

class NotificationScreen extends StatelessWidget {
  final void Function() icon1OnTap;
  const NotificationScreen({super.key,required this.icon1OnTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder:(context, innerBoxIsScrolled) {
          return [
            NotificationCustomSliverAppBar(
              leadingOnTap: icon1OnTap,
              leadingIcon: Icons.arrow_back_ios,
              text: S.current.notification
              )
          ];
        }, 
        body: const Column(
          children: [],
        ),
      ),
    );
  }
}