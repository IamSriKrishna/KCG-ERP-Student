import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kcgerp/CleanWidget/Signup/TopWidget.dart';
import 'package:kcgerp/Feature/Screen/Auth/Login.dart';
import 'package:kcgerp/Feature/Service/Authservice.dart';
import 'package:kcgerp/Util/FontStyle/RobotoBoldFont.dart';
import 'package:kcgerp/Util/showsnackbar.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/Widget/AuthBottomNavigatorWidget/AuthBottomNavigatorWidget.dart';
import 'package:kcgerp/Widget/CupertinoWidgets/CustomCupertinoModalpop.dart';
import 'package:kcgerp/Widget/TextField/CustomTextField.dart';
import 'package:kcgerp/Widget/TextField/CustomTextFieldPassword.dart';

class SignUp extends StatefulWidget {
  static const route = '/SignUp';
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  
  String selectedDepartment = 'Computer Science Department';
  String Studentclass = 'Third Year';
  TextEditingController name = TextEditingController();
  TextEditingController rollNo = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthService _authService = AuthService();

  File? _image;
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } 
  }
  void signup(){
    if(selectedDepartment.isEmpty||name.text.isEmpty||rollNo.text.isEmpty||password.text.isEmpty||_image == null){
      if(selectedDepartment.isEmpty){
        CustomCupertinoModalPop(context: context, content: 'Department Is Missing');
      }
      else if(name.text.isEmpty){
        CustomCupertinoModalPop(context: context, content: 'Name Is Missing');
      }
      else if(rollNo.text.isEmpty){
        CustomCupertinoModalPop(context: context, content: 'Register Number Is Missing');
      }
      else if(password.text.isEmpty){
        CustomCupertinoModalPop(context: context, content: 'Password Is Missing');
      }
      else if(_image == null){
        CustomCupertinoModalPop(context: context, content: 'Image Is Missing');
      }
      else{
        CustomCupertinoModalPop(context: context, content: 'Kindly FIll all the form');
      }
      //CustomCupertinoModalPop(context: context, content: 'Kindly FIll all the form');
    }
    else{
      _authService.signUp(
      department:selectedDepartment,
      context: context, 
      image: _image!,
      year:Studentclass,
      rollNo: rollNo.text, 
      password: password.text, 
      name: name.text
    );
    Navigator.pushNamed(context, Login.route).then((value) => showSnackBar(
      context:context,
      text:'Account created! Login with the same credentials!',
    ));
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SignUpTopWidget(),
          Padding(
            padding: EdgeInsets.only(top:230),
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
              child: Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          color:  _image == null?Color.fromARGB(77, 167, 163, 163):Colors.transparent,
                          shape: BoxShape.circle,
                          image: _image == null ?null:DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: FileImage(_image!)
                            )
                        ),
                        child: _image == null
                            ? Icon(Icons.add_a_photo)
                            : null
                      ),
                    ),
                    CustomTextField(
                      controller: name, 
                      hintText: 'Name', 
                      labelText: 'Name'
                    ),
                    CustomTextField(
                      controller: rollNo, 
                      hintText: 'Register Number', 
                      labelText: 'Register Number',
                      textCapitalization: TextCapitalization.characters,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 8),
                          child: FittedBox(
                            child: DropdownButton<String>(
                              icon: Icon(
                                Icons.arrow_drop_down_circle_sharp,
                                color: Colors.grey,
                                ),
                              underline: Container(),
                              dropdownColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              borderRadius: BorderRadius.circular(15),
                              value: selectedDepartment,
                              items: <String>[
                                'Computer Science Department', 
                                'Civil Engineering', 
                                'Electronics and Communication Engineering', 
                                'Electrical and Electronics Engineering'
                                ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.merriweather(
                                      color: Colors.black54
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedDepartment = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const  EdgeInsets.symmetric(horizontal:8.0,vertical: 5),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down_circle_sharp,
                              color: Colors.grey,
                              size: 18.5,
                            ),
                            underline: Container(),
                            dropdownColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            borderRadius: BorderRadius.circular(15),
                            value: Studentclass,
                            items: <String>[
                              'First Year', 
                              'Second Year', 
                              'Third Year', 
                              'Fourth Year',
                              ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: GoogleFonts.merriweather(
                                    fontSize: 14,
                                    color: Colors.black54
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                Studentclass = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    CustomTextFieldPassword(
                      password: password
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
                          signup();
                        }, 
                        child: RobotoBoldFont(text: 'SignUp')
                      ),
                    ),
                    AuthBottomNavigatorWidget(
                      prefixText: 'Ready to Embark on Your Journey?', 
                      sufixText: 'Login In', 
                      onTap: (){
                        Navigator.pushNamed(context, Login.route);
                      }
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}