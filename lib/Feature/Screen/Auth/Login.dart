import 'package:flutter/material.dart';
import 'package:kcgerp/Feature/Screen/Auth/SignUp.dart';
import 'package:kcgerp/Feature/Screen/Auth/widget/LoginWidget.dart';
import 'package:kcgerp/Feature/Service/Authservice.dart';
import 'package:kcgerp/Util/FontStyle/RobotoBoldFont.dart';
import 'package:kcgerp/Util/FontStyle/RobotoRegularFont.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/Widget/AuthBottomNavigatorWidget/AuthBottomNavigatorWidget.dart';
import 'package:kcgerp/Widget/TextField/CustomTextField.dart';
import 'package:kcgerp/Widget/TextField/CustomTextFieldPassword.dart';

class Login extends StatefulWidget {
  static const route = '/Login';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _rollNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final AuthService _authService = AuthService();
  void signIn(){
    _authService.signInUser(context: context, rollno: _rollNumber.text, password: _password.text);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LoginWidget(),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.415),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:20.0,left:10),
                    child: RobotoBoldFont(
                      text: 'Login Now!',
                      size: 25,
                      textColor: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:10),
                    child: RobotoRegularFont(
                      text: 'Join the Student Hub',
                      size: 19,
                      fontWeight: FontWeight.w100,
                      textColor: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CustomTextField(
                    hintText: 'Register Number',
                    labelText: 'Register Number',
                    keyboardType: TextInputType.number,
                    controller: _rollNumber,
                    textCapitalization: TextCapitalization.characters,
                  ),
                  CustomTextFieldPassword(password: _password,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:60.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor.appThemeColor2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: (){
                        signIn();
                      }, 
                      child: RobotoBoldFont(text: 'Login')
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar:AuthBottomNavigatorWidget(
      //             prefixText: 'Ready to Begin Your Journey?', 
      //             sufixText: 'Sign Up', 
      //             onTap: (){
      //       Navigator.pushNamed(context, SignUp.route);
      //             }
      //           ) ,
    );
  }
}