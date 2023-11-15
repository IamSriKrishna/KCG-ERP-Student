import 'package:flutter/material.dart';
import 'package:kcgerp/Util/FontStyle/RobotoRegularFont.dart';

void showSnackBar({required BuildContext context,required String text}){
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      padding: const EdgeInsets.all(10),
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          )
      ),
      content:Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(25)
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 15,
              child: GestureDetector(
                onTap: () {
                ScaffoldMessenger.of(context).clearSnackBars();
                },
                child: Image.asset('asset/x.png',height: MediaQuery.of(context).size.height * 0.035,)
              )
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: RobotoRegularFont(
                text: text,
                textColor:Colors.white,
                ),
            ),
          ],
        ),
      )
      
    )
  );
}