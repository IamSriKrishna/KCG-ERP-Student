import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kcgerp/Feature/Service/FollowerORFollowing.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Util/FontStyle/RobotoBoldFont.dart';
import 'package:kcgerp/Util/FontStyle/RobotoRegularFont.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:provider/provider.dart';

class MyProfileTopScreen extends StatefulWidget {
  final String department;
  final String name;
  final String dp;
  const MyProfileTopScreen({
    super.key,
    required this.name,
    required this.department,
    required this.dp
  });

  @override
  State<MyProfileTopScreen> createState() => _MyProfileTopScreenState();
}

class _MyProfileTopScreenState extends State<MyProfileTopScreen> {
  FollowersOrFollowing _followersOrFollowing = FollowersOrFollowing();
  int _followersCount = 0;
  int _followingCount = 0;
  
  Timer? timer;
  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
    _getFollowersCount();
    _getFollowingCount();
    });
  }

  Future<void> _getFollowersCount() async {
    try {
      int followers = await _followersOrFollowing.getMyFollowersCount();
      setState(() {
        _followersCount = followers;
      });
    } catch (e) {
      print("Error getting followers count: $e");
      // Handle error accordingly
    }
  }

  Future<void> _getFollowingCount() async {
    try {
      int following = await _followersOrFollowing.getMyFollowingCount();
      setState(() {
        _followingCount = following;
      });
    } catch (e) {
      print("Error getting following count: $e");
    }
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.height * 0.15,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.115,
            width: double.infinity,
            //color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //profile Picture
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: widget.dp,
                    width: MediaQuery.of(context).size.width * 0.215,
                    height: MediaQuery.of(context).size.height * 0.1,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: 
                    (context, url, progress) => Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color:theme.getDarkTheme?themeColor.themeColor: themeColor.darkTheme,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.67,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$_followersCount'),
                          RobotoBoldFont(text: 'Followers')
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$_followingCount'),
                          RobotoBoldFont(text: 'Following')
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                //Student Name
                RobotoBoldFont(text: widget.name),
                //Student Department
                RobotoRegularFont(
                  text: '(${widget.department})',
                  fontWeight: FontWeight.w100,
                  size: 10,
                )
              ],
            )
          )
        ],
      ),
    );
  }
}