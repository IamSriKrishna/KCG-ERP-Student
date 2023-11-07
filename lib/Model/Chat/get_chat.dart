import 'package:kcgerp/Model/Student.dart';
import 'dart:convert';

class GetChat {
    final String id;
    final String chatName;
    final bool isGroupChat;
    final List<Student> users;
    final DateTime createdAt;
    final DateTime updatedAt;
    final LatestMessage latestMessage;

    GetChat({
        required this.id,
        required this.chatName,
        required this.isGroupChat,
        required this.users,
        required this.createdAt,
        required this.updatedAt,
        required this.latestMessage,
    });

    factory GetChat.fromJson(String str) => GetChat.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetChat.fromMap(Map<String, dynamic> json) => GetChat(
        id: json["_id"],
        chatName: json["chatName"],
        isGroupChat: json["isGroupChat"],
        users: List<Student>.from(json["users"].map((x) => Student.fromMap(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        latestMessage: LatestMessage.fromMap(json["latestMessage"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "chatName": chatName,
        "isGroupChat": isGroupChat,
        "users": List<dynamic>.from(users.map((x) => x.toMap())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "latestMessage": latestMessage.toMap(),
    };
}

class LatestMessage {
    final String id;
    final Sender sender;
    final String content;
    final String receiver;
    final String chat;

    LatestMessage({
        required this.id,
        required this.sender,
        required this.content,
        required this.receiver,
        required this.chat,
    });

    factory LatestMessage.fromJson(String str) => LatestMessage.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LatestMessage.fromMap(Map<String, dynamic> json) => LatestMessage(
        id: json["_id"],
        sender: Sender.fromMap(json["sender"]),
        content: json["content"],
        receiver: json["receiver"],
        chat: json["chat"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "sender": sender.toMap(),
        "content": content,
        "receiver": receiver,
        "chat": chat,
    };
}

class Sender {
    final String id;
    final String name;
    final String rollno;
    final String dp;

    Sender({
        required this.id,
        required this.name,
        required this.rollno,
        required this.dp,
    });

    factory Sender.fromJson(String str) => Sender.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Sender.fromMap(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        name: json["name"],
        rollno: json["rollno"],
        dp: json["dp"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "rollno": rollno,
        "dp": dp,
    };
}
