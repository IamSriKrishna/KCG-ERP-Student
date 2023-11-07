
import 'dart:convert';

class InitialChat {
    final String id;

    InitialChat({
        required this.id,
    });

    factory InitialChat.fromJson(String str) => InitialChat.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory InitialChat.fromMap(Map<String, dynamic> json) => InitialChat(
        id: json["_id"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
    };
}
