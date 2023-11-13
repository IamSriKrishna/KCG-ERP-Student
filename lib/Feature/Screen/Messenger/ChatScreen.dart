import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kcgerp/Feature/Screen/Messenger/messageTExtField.dart';
import 'package:kcgerp/Feature/Service/Chat/MessageService.dart';
import 'package:kcgerp/Model/Chat/ReceiveMessage.dart';
import 'package:kcgerp/Model/Chat/sendMessage.dart';
import 'package:kcgerp/Provider/chat_provider.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:kcgerp/Widget/Additional/CustomAppBar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
class ChatScreen extends StatefulWidget {
  static const route = '/ChatScreen';
  const ChatScreen(
      {super.key,
      required this.title,
      required this.id,
      required this.profile,
      required this.user});

  final String title;
  final String id;
  final String profile;
  final List<String> user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Timer? timer;
  int offset = 1;
  IO.Socket? socket;
  Future<List<ReceivedMessge>>? msgList;
  List<ReceivedMessge> messages = [];
  TextEditingController messageController = TextEditingController();
  String receiver = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    getMessages(offset);
    connect();
    timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      getMessages(offset);
      connect();
    });
    joinChat();
    handleNext();
    super.initState();
  }
  @override
  void dispose() {
    timer?.cancel();
    FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    super.dispose();
  }
  void getMessages(int offset) {
    msgList = MesssagingHelper.getMessages(widget.id, offset);
    setState(() {
      
    });
  }

  void handleNext() {
    _scrollController.addListener(() async {
      if (_scrollController.hasClients) {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          if (messages.length >= 12) {
            //getMessages(offset++);
          }
        }
      }
    });
  }

  void connect() {
    var chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
    socket =
        IO.io(uri, <String, dynamic>{
      "transports": ['websocket'],
      "autoConnect": false,
    });
    socket!.emit("setup", chatNotifier.userId);
    socket!.connect();
    socket!.onConnect((_) {
      
      socket!.on('online-users', (userId) {
        chatNotifier.online
            .replaceRange(0, chatNotifier.online.length, [userId]);
            chatNotifier.online == true;
      });

      socket!.on('typing', (status) {
        chatNotifier.typingStatus = true;
      });

      socket!.on('stop typing', (status) {
        chatNotifier.typingStatus = false;
      });

      socket!.on('message received', (newMessageReceived) {
        sendStopTypingEvent(widget.id);
        ReceivedMessge receivedMessge =
            ReceivedMessge.fromJson(newMessageReceived);

        if (receivedMessge.sender.id != chatNotifier.userId) {
          setState(() {
            messages.insert(0, receivedMessge);
          });
        }
      });
    });
    
    setState(() {
      
    });
  }

  void sendMessage(String content, String chatId, String receiver) {
    SendMessage model =
        SendMessage(content: content, chatId: chatId, receiver: receiver);

    MesssagingHelper.sendMessage(model).then((response) {
      var emmission = response[2];
      socket!.emit('new message', emmission);
      sendStopTypingEvent(widget.id);
      setState(() {
        messageController.clear();
        messages.insert(0, response[1]);
      });
    });
  }

  void sendTypingEvent(String status) {
    socket!.emit('typing', status);
  }

  void sendStopTypingEvent(String status) {
    socket!.emit('stop typing', status);
  }

  void joinChat() {
    socket!.emit('join chat', widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatNotifier>(
      builder: (context, chatNotifier, child) {
        receiver = widget.user.firstWhere((id) => id != chatNotifier.userId);
        return WillPopScope(
          onWillPop: () async{
            Navigator.pop(context);
            return false;
          },
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.h),
                child: CustomAppBar(
                  text: !chatNotifier.typing ? Text(widget.title) : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Typing",
                        style: GoogleFonts.merriweather(
                          color: Color.fromARGB(255, 100, 238, 100)
                        ),
                        ),
                      Lottie.asset(
                        'asset/lottie/type.json',
                        height: MediaQuery.of(context).size.height * 0.06
                      )
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.profile),
                          ),
                          Positioned(
                              right: 3,
                              child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor:chatNotifier.online.contains(receiver)
                                          ? Colors.green
                                          : const Color.fromARGB(255, 160, 11, 0)))
                        ],
                      ),
                    )
                  ],
                  child: Padding(
                    padding: EdgeInsets.all(12.0.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(MaterialCommunityIcons.arrow_left),
                    ),
                  ),
                ),
              ),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.5),
                  child: Column(
                    children: [
                      Expanded(
                        child: FutureBuilder<List<ReceivedMessge>>(
                            future: msgList,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }else if(snapshot.data==null){
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } 
                              else if (snapshot.data!.isEmpty) {
                                return const Text("You do not have message");
                              } else {
                                final msgList = snapshot.data;
                                messages =  msgList!;
                                return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                    itemCount: messages.length,
                                    reverse: true,
                                    controller: _scrollController,
                                    itemBuilder: (context, index) {
                                      final data = messages[index];
                                      return Padding(
                                        padding:
                                            EdgeInsets.only(top: 1, bottom: 12.h),
                                        child: ChatBubble(
                                          clipper: ChatBubbleClipper5(
                                            type: data.sender.id ==
                                                  chatNotifier.userId
                                              ? BubbleType.sendBubble:BubbleType.receiverBubble
                                          ),
                                          alignment: data.sender.id ==
                                                  chatNotifier.userId
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          margin: EdgeInsets.only(top: 2),
                                          backGroundColor:data.sender.id !=
                                                  chatNotifier.userId?
                                                  Color(0xffE7E7ED):Color.fromARGB(255, 102, 149, 196),
                                          child: Container(
                                            constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                                            ),
                                            child: Text(
                                              data.content,
                                              style: GoogleFonts.quicksand(color: data.sender.id ==
                                                  chatNotifier.userId?Colors.white:Colors.black),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.all(6.h),
                        alignment: Alignment.bottomCenter,
                        child: MessaginTextField(
                            onSubmitted: (_) {
                              messageController.clear();
                                sendMessage(messageController.text, widget.id, receiver);
                            },
                            sufixIcon: IconButton(
                              onPressed: () {
                                sendMessage(messageController.text, widget.id, receiver);
                              },
                              icon: Icon(
                                Icons.send,
                                size: 24,
                                color: Colors.lightBlue,
                              ),
                            ),
                            onTapOutside: (_) {
                              sendStopTypingEvent(widget.id);
                            },
                            onChanged: (_) {
                              sendTypingEvent(widget.id);
                            },
                            onEditingComplete: () {
                              
                              messageController.clear();
                              sendMessage(messageController.text, widget.id, receiver);
                            },
                            messageController: messageController),
                      )
                    ],
                  ),
                ),
              ),
              
              ),
        );
      },
    );
  }
}
