
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/OverScreen.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const route = 'ChatScreen';
  const ChatScreen ({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _ChatScreen = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _student = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    final name = _student['name'];
    final dp = _student['dp'];
    final register = _student['registerno'];
    final dep = _student['dep'];
    final theme = Provider.of<DarkThemeProvider>(context);
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushNamedAndRemoveUntil(context, OverScreen.route, (route) => false);
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              floating: true,
              backgroundColor:theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
              leading: InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, OverScreen.route,(route)=>false);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: theme.getDarkTheme?themeColor.themeColor:themeColor.darkTheme
                ),
              ),
              title: Column(
                children: [
                  Text(
                    name,
                    style: GoogleFonts.merriweather(
                      fontSize: 18,
                      color: theme.getDarkTheme?themeColor.themeColor:themeColor.darkTheme
                    ),
                  ),
                  Text(
                    '$register(${dep})',
                    style: GoogleFonts.merriweather(
                      fontSize: 13,
                      color: theme.getDarkTheme?themeColor.themeColor:themeColor.darkTheme
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 10),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: dp,
                      width: MediaQuery.of(context).size.width * 0.1,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        bottomSheet: Container(
          color: theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 2.5),
            child: Container(
              decoration: BoxDecoration(
                color: theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: theme.getDarkTheme?themeColor.themeColor:themeColor.darkTheme
                )
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: _ChatScreen,
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Send Message',
                          border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        _ChatScreen.clear();
                      },
                    icon: Icon(
                      Icons.send,
                      color: theme.getDarkTheme?themeColor.themeColor:themeColor.darkTheme,
                    )
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}