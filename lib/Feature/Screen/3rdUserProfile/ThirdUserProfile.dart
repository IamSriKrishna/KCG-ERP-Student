import 'package:flutter/material.dart';
import 'package:kcgerp/Feature/Screen/3rdUserProfile/Widget/ThirdUserProfileTopScreen.dart';
import 'package:kcgerp/Feature/Screen/3rdUserProfile/Widget/profileButton.dart';
import 'package:kcgerp/Feature/Service/Chat/ChatService.dart';
import 'package:kcgerp/Feature/Service/FollowerORFollowing.dart';
import 'package:kcgerp/Feature/Service/NotificationService.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Util/FontStyle/RobotoBoldFont.dart';
import 'package:kcgerp/Util/showsnackbar.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/Widget/CupertinoWidgets/CustomCupertinoModalpop.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';

class ThirdUserProfile extends StatefulWidget {
  final String rollno;
  final String name;
  final String department;
  final bool certified;
  final String dp;
  final String id;
  final String fcmtoken;
  final String current_student_id;
  static const route = '/ThirdUserProfile';
  const ThirdUserProfile({
    super.key,
    required this.name,
    required this.department,
    required this.rollno,
    required this.dp,
    required this.certified,
    required this.id,
    required this.fcmtoken,
    required this.current_student_id
  });

  @override
  State<ThirdUserProfile> createState() => _ThirdUserProfileState();
}

class _ThirdUserProfileState extends State<ThirdUserProfile> {
  NotificationService _notificationService = NotificationService();
  FollowersOrFollowing _followersOrFollowing = FollowersOrFollowing();
  bool _isfollowing = false;
  @override

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
                  child: RobotoBoldFont(text: widget.rollno,size: 20,),
                ),
                widget.certified==true?
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
            child: ThirdUserProfileTopScreen(
            name:widget.name, 
            department:widget.department, 
            dp:widget.dp,
            thirdUserid: widget.id,
          ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  profileButton(
                    backgroundColor:
                    _isfollowing==true?themeColor.appThemeColor:
                          my.following.contains(widget.id)?themeColor.appThemeColor:themeColor.appThemeColor2, 
                    foregroundColor: themeColor.themeColor, 
                    onPressed: (){
                      if(my.following.contains(widget.id)||_isfollowing==true){
                        print('unfollow');
                      }else{
                        setState(() {
                          _isfollowing=true;
                        });
                        _followersOrFollowing.addFollowing(widget.id);
                        _followersOrFollowing.addFollowerbyThirdUser(widget.id);
                        _notificationService.sendNotifications(
                            context: context, 
                            toAllFaculty: [widget.fcmtoken],
                            body: '${my.name} Started Following You :)'
                          );
                      }
                    }, 
                    text: _isfollowing==true?'Following':
                          my.following.contains(widget.id)?'following':'follow'
                  ),
                  profileButton(
                    backgroundColor: Colors.grey, 
                    foregroundColor: Colors.black, 
                    onPressed: ()async{
                      await ChatHelper.apply(widget.id.toString());
                      _notificationService.sendNotifications(
                          context: context, 
                          toAllFaculty: [widget.fcmtoken],
                          body: '${my.name}\nWants to say Something :)'
                        );
                        showSnackBar(context: context, text: 'Go to messenger to chat with ${widget.name}');
                    }, 
                    text: 'Add To Messenger'
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
                    thickness: 2,
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
              return InkWell(
                onTap: () {
                  CustomCupertinoModalPop(context: context, content: S.current.development);
                },
                child: Container(
                  color:theme.getDarkTheme?Colors.white12: Colors.black12,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

/**Column(
        children: [

          
        ],
      ) */