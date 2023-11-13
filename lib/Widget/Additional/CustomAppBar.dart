import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/Widget/Additional/reusableText.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.text, required this.child, this.actions});

  final Widget? text;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    
    final theme = Provider.of<DarkThemeProvider>(context);
    return AppBar(
      iconTheme: const IconThemeData(),
      backgroundColor:theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
      elevation: 0,
      scrolledUnderElevation: 10,
      automaticallyImplyLeading: false,
      leadingWidth: 70.w,
      leading: child,
      actions: actions,
      centerTitle: true,
      title: text);
  
  }
}
