import 'package:flutter/material.dart';
import 'package:kcgerp/Feature/Service/Chat/ChatService.dart';
import 'package:kcgerp/Provider/DarkThemeProvider.dart';
import 'package:kcgerp/Util/FontStyle/RobotoBoldFont.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  static const route = '/MessageScreen';
  final void Function()? icon1OnTap;
  const MessageScreen({super.key,this.icon1OnTap});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return WillPopScope(
      onWillPop: () async{
        widget.icon1OnTap!();
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar( 
              leading: InkWell(
                onTap: widget.icon1OnTap,
                child: Icon(
                  Icons.arrow_back,
                  color: theme.getDarkTheme?themeColor.backgroundColor: themeColor.appBarColor,
                ),
              ),
              floating: true,
              backgroundColor:theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
              title: RobotoBoldFont(
                text: "Messenger",
                textColor:theme.getDarkTheme?themeColor.backgroundColor: themeColor.appBarColor,
              ),
            ),
            SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.108,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.5),
                  color: Color.fromARGB(255, 207, 207, 207).withOpacity(0.5),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search,
                        color: theme.getDarkTheme
                            ? themeColor.backgroundColor
                            : themeColor.appBarColor),
                    hintText: 'Search',
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder<List<dynamic>>(
            future: ChatHelper.getChats(context), // Call getChats method
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return SliverToBoxAdapter(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data == null) {
                return SliverToBoxAdapter(child: Text('No chat data available.'));
              } else {
                List<dynamic>? chatData = snapshot.data as List<dynamic>?;

                return SliverList.builder(
                  itemCount: chatData!.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> chatItem = chatData[index] as Map<String, dynamic>;
                    return ListTile(
                      title: Text(chatItem['name'] ?? 'No title'),
                      subtitle: Text(chatItem['message'] ?? 'No message'),
                    );
                  },
                );
              }
            },
          )
          ],
        ),
      ),
    );
  }
}