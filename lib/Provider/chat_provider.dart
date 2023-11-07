import 'package:flutter/material.dart';
import 'package:kcgerp/Feature/Service/Chat/ChatService.dart';

class ChatNotifier extends ChangeNotifier {
  Future<List<dynamic>>? chats;
  List<String> _online = [];
  bool _typing = false;

  bool get typing => _typing;

  set typingStatus(bool newState) {
    _typing = newState;
    notifyListeners();
  }

  List<String> get online => _online;

  set onlineUsers(List<String> newList) {
    _online = newList;
    notifyListeners();
  }

  String? userId;

  getChats(BuildContext context) {
    chats = ChatHelper.getChats(context);
  }

  
  // String msgTime(String timestamp) {
  //   DateTime now = DateTime.now().toUtc();
  //   DateTime messageTimeUtc = DateTime.parse(timestamp).toUtc();
  //   DateTime messageTimeBeijing =
  //       messageTimeUtc.toLocal().add(const Duration(hours: 15));
  //   if (now.year == messageTimeBeijing.year &&
  //       now.month == messageTimeBeijing.month &&
  //       now.day == messageTimeBeijing.day) {
  //     return DateFormat.jm().format(messageTimeBeijing);
  //   } else if (now.year == messageTimeBeijing.year &&
  //       now.month == messageTimeBeijing.month &&
  //       now.day - messageTimeBeijing.day == 1 ) {
  //     return "Yesterday";
  //   } else {
  //     return DateFormat.yMEd().format(messageTimeBeijing);
  //   }
  // }
}
