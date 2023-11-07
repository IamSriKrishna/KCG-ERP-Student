
import 'dart:convert';

class CreateChat {
    final String userId;

    CreateChat({
        required this.userId,
    });

    factory CreateChat.fromJson(String str) => CreateChat.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CreateChat.fromMap(Map<String, dynamic> json) => CreateChat(
        userId: json["userId"],
    );

    Map<String, dynamic> toMap() => {
        "userId": userId,
    };
}
