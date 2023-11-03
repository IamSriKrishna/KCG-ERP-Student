import 'dart:convert';

class Post {
  final String id;
  final String name;
  final String dp;
  final List<String> image_url;
  final List<String> likes;
  final String description;
  final String title;
  final String link;
  final DateTime createdAt; 

  Post({
    required this.id,
    required this.name,
    required this.dp,
    required this.image_url,
    required this.likes,
    required this.description,
    required this.title,
    required this.createdAt,
    required this.link,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id:map['_id']??'',
      name: map['name']?? '',
      dp: map['dp']?? '',
      image_url: List<String>.from(map['image_url']),
      likes: List<String>.from(map['likes']),
      description: map['description']?? '',
      title: map['title']?? '',
      createdAt: DateTime.parse(map['createdAt']),
      link: map['link'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'dp': dp,
      'image_url': image_url,
      'likes': likes,
      'description': description,
      'title': title,
      'link': link,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  
  String toJson() => json.encode(toMap());
  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  Post copyWith({
    String? id,
    String? name,
    List<String>? image,
    String? title,
    List<String>? likes,
    String? dp,
    String? description,
    String?link,
    DateTime? createdAt, 
  }) {
    return Post(
      id: id ?? this.id,
      name: name?? this.name, 
      dp: dp?? this.dp,
      image_url: image ?? this.image_url, 
      likes: likes?? this.likes, 
      description: description?? this.description, 
      title: title?? this.title, 
      createdAt: createdAt?? this.createdAt, 
      link: link?? this.link
    );
  }
}
