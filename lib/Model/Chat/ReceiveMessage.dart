
import 'dart:convert';
List<ReceiveMessage> receiveMessagefromMap(String str) => List<ReceiveMessage>.from(json.decode(str).map((x) => ReceiveMessage.fromMap(x)));

class ReceiveMessage {
    final String id;
    final Sender sender;
    final String content;
    final String receiver;
    final Chat chat;
    final List<dynamic> readBy;
    final DateTime createdAt;
    final DateTime updatedAt;

    ReceiveMessage({
        required this.id,
        required this.sender,
        required this.content,
        required this.receiver,
        required this.chat,
        required this.readBy,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ReceiveMessage.fromJson(String str) => ReceiveMessage.fromMap(json.decode(str));



    factory ReceiveMessage.fromMap(Map<String, dynamic> json) => ReceiveMessage(
        id: json["_id"],
        sender: Sender.fromMap(json["sender"]),
        content: json["content"],
        receiver: json["receiver"],
        chat: Chat.fromMap(json["chat"]),
        readBy: List<dynamic>.from(json["readBy"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    // Map<String, dynamic> toJson() => {
    //     "_id": id,
    //     "sender": sender.toJson(),
    //     "content": content,
    //     "receiver": receiver,
    //     "chat": chat.toJson(),
    //     "readBy": List<dynamic>.from(readBy.map((x) => x)),
    //     "createdAt": createdAt.toIso8601String(),
    //     "updatedAt": updatedAt.toIso8601String(),
    // };
}

class Chat {
    final String id;
    final String chatName;
    final bool isGroupChat;
    final List<Sender> users;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String latestMessage;

    Chat({
        required this.id,
        required this.chatName,
        required this.isGroupChat,
        required this.users,
        required this.createdAt,
        required this.updatedAt,
        required this.latestMessage,
    });

    factory Chat.fromJson(String str) => Chat.fromMap(json.decode(str));


    factory Chat.fromMap(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        chatName: json["chatName"],
        isGroupChat: json["isGroupChat"],
        users: List<Sender>.from(json["users"].map((x) => Sender.fromMap(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        latestMessage: json["latestMessage"],
    );

    // Map<String, dynamic> toJson() => {
    //     "_id": id,
    //     "chatName": chatName,
    //     "isGroupChat": isGroupChat,
    //     "users": List<dynamic>.from(users.map((x) => x.toJson())),
    //     "createdAt": createdAt.toIso8601String(),
    //     "updatedAt": updatedAt.toIso8601String(),
    //     "latestMessage": latestMessage,
    // };
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


    factory Sender.fromMap(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        name: json["name"],
        rollno: json["rollno"],
        dp: json["dp"],
    );

    // Map<String, dynamic> toJson() => {
    //     "_id": id,
    //     "name": name,
    //     "rollno": rollno,
    //     "dp": dp,
    // };
}
