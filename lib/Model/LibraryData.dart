import 'dart:convert';

class LibraryModel {
  final String id;
  final String book_title;
  final List<dynamic> access_no;
  final List<String> authors;
  LibraryModel({
    required this.id,
    required this.book_title,
    required this.access_no,
    required this.authors,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'book_title': book_title,
      'access_no':access_no,
      'authors': authors,
    };
  }

  factory LibraryModel.fromMap(Map<String, dynamic> map) {
    return LibraryModel(
      id: map['_id'] ?? '',
      book_title: map['book_title'] ?? '',
      access_no:map['access_no']??[],
      authors:map['authors']??[],
    );
  }

  String toJson() => json.encode(toMap());

  factory LibraryModel.fromJson(String source) => LibraryModel.fromMap(json.decode(source));

  LibraryModel copyWith({
    String? id,
    String? book_title,
    List<dynamic>? access_no,
    List<String>? authors,
  }) {
    return LibraryModel(
      id: id ?? this.id,
      book_title: book_title ?? this.book_title,
      access_no: access_no??this.access_no,
      authors: authors??this.authors
    );
  }
}