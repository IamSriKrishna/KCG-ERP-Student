
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Feature/Screen/MyProfile/EditProfile.dart';
import 'package:kcgerp/Feature/Screen/MyProfile/Widget/MyProfileTopScreen.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Util/FontStyle/RobotoBoldFont.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatelessWidget {
  static const route = '/MyProfile';
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final my = Provider.of<StudentProvider>(context).user;
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            leadingWidth: MediaQuery.of(context).size.width * 0.45,
            leading: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:5.0),
                  child: RobotoBoldFont(text: my.rollno,size: 20,),
                ),
                my.certified==true?
                Image.asset('asset/tick.png',height: MediaQuery.of(context).size.height * 0.02,)
                :Text('')
              ],
            ),
            backgroundColor: theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.favorite_outlined,color: Colors.red,),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: MyProfileTopScreen(
              name: my.name, 
              department: my.department, 
              dp: my.dp
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5.5,
                      fixedSize: Size(
                        MediaQuery.of(context).size.width * 0.35, 
                        MediaQuery.of(context).size.height * 0.03
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.5)
                      ),
                      backgroundColor: themeColor.appThemeColor,
                      foregroundColor: themeColor.themeColor
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, EditProfile.route);
                    }, 
                    child: RobotoBoldFont(text: 'Edit My Profile',size: 12,)
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5.5,
                      fixedSize: Size(
                        MediaQuery.of(context).size.width * 0.35, 
                        MediaQuery.of(context).size.height * 0.03
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.5)
                      ),
                      backgroundColor: themeColor.appThemeColor,
                      foregroundColor: themeColor.themeColor
                    ),
                    onPressed: (){
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )
                        ),
                        context: context, 
                        builder:(context) => Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Center(
                            child: Text(
                              S.current.development,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.sansita(),
                            ),
                          ),
                        ),
                      );
                    }, 
                    child: RobotoBoldFont(text: 'Academic',size: 12,)
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Column(
                children: [
                  Icon(Icons.grid_view),
                  Divider(
                    endIndent: MediaQuery.of(context).size.width * 0.05,
                    indent: MediaQuery.of(context).size.width * 0.05,
                    thickness: 1.45,
                    color:theme.getDarkTheme? themeColor.appThemeColor2.withOpacity(0.5):Colors.black12,
                  ),
                ],
              ),
            ),
          ),
          SliverGrid.builder(
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1
            ), 
            itemBuilder:(context, index) {
              return Container(
                color:theme.getDarkTheme?Colors.white12: Colors.black12,
              );
            },
          )
        ],
      )
    );
  }
}


