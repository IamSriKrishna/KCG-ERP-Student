
import 'dart:convert';

class SendMessage {
    final String content;
    final String chatId;
    final String receiver;

    SendMessage({
        required this.content,
        required this.chatId,
        required this.receiver,
    });

    factory SendMessage.fromJson(String str) => SendMessage.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SendMessage.fromMap(Map<String, dynamic> json) => SendMessage(
        content: json["content"],
        chatId: json["chatId"],
        receiver: json["receiver"],
    );

    Map<String, dynamic> toMap() => {
        "content": content,
        "chatId": chatId,
        "receiver": receiver,
    };
}
