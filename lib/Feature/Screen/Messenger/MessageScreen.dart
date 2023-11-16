import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Feature/Screen/Messenger/ChatScreen.dart';
import 'package:kcgerp/Feature/Service/Chat/ChatService.dart';
import 'package:kcgerp/Feature/Service/NotificationService.dart';
import 'package:kcgerp/Model/Chat/get_chat.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Provider/StudenProvider.dart';
import 'package:kcgerp/Provider/chat_provider.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/Widget/Additional/reusableText.dart';
import 'package:kcgerp/Widget/CupertinoWidgets/CustomCupertinoModalpop.dart';
import 'package:kcgerp/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';
class MessageScreen extends StatefulWidget {
  static const route = '/MessageScreen';
  final void Function()? icon1OnTap;
  const MessageScreen({super.key,this.icon1OnTap});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final NotificationService _fcmNotification = NotificationService();
  @override
  
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    final student = Provider.of<StudentProvider>(context).user;
    ScreenUtil.init(context); // Initialize ScreenUtil
    return WillPopScope(
      onWillPop: () async{
        widget.icon1OnTap!();
        return false;
      },
      child: Scaffold(    
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                CustomCupertinoModalPop(context: context, content: S.current.development);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.info_outlined),
              ),
            )
          ],
          title: Text('Messenger'),
          backgroundColor:theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
          leading: IconButton(onPressed: widget.icon1OnTap, icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Consumer<ChatNotifier>(
          builder: (context, chatNotifier, child) {
            chatNotifier.getChats();
            chatNotifier.getPrefs();
            return FutureBuilder<List<GetChats>>(
                future: chatNotifier.chats,
                builder: (context, snapshot) {
                  if(snapshot.data==null){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (snapshot.hasError) {
                    return ReusableText(
                        text: "Error ${snapshot.error}",
                        style:GoogleFonts.merriweather());
                  } else if (snapshot.data!.isEmpty) {
                    return Center(
                      child: const Text(
                        "To send a message to the student\ngo to Search🔍as there are no chats available.",
                        textAlign: TextAlign.center,
                        )
                      );
                  } else {
                    final chats = snapshot.data;
                    return ListView.builder(
                        itemCount: chats!.length,
                        itemBuilder: (context, index) {
                          
                          final chat = chats[index];
                          var user = chat.users
                              .where((user) => user.id != chatNotifier.userId);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: InkWell(
                              onLongPress: () async{
                                CustomCupertinoModalPopDeleteChat(
                                  context: context,
                                  ok: ()async{
                                    _fcmNotification.sendNotificationtoOne(
                                      user.first.fcmtoken, 
                                      '${student.name} Deleted your chat:('
                                    );
                                    await ChatHelper.deleteChat(chat.id,context);
                                  }
                                );
                              },
                              onTap: () {
                                _fcmNotification.sendNotificationtoOne(
                                      user.first.fcmtoken, 
                                      '${student.name} Want to Say Something :)'
                                );
                                Get.to(() => ChatScreen(
                                    id: chat.id,
                                    studentid: user.first.id,
                                    fcmtoken: user.first.fcmtoken,
                                    certified: user.first.certified,
                                    department: user.first.department,
                                    rollno: user.first.rollno,
                                    title: user.first.name,
                                    profile: user.first.dp,
                                    user: [chat.users[0].id, chat.users[1].id]));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: ListTile(
                                  leading: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: user.first.dp,
                                      width: MediaQuery.of(context).size.width * 0.135,
                                      height: MediaQuery.of(context).size.height * 0.065,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    user.first.name,
                                    style: GoogleFonts.merriweather(),
                                  ),
                                  subtitle: Text(user.first.rollno),
                                  trailing: Text(chatNotifier.msgTime(chat.updatedAt.toString())),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                });
          },
        ),
      ),
    );
  }
}
