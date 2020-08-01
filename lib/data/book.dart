import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

/// Base data class to hold Book object
///
/// Object consists of a [Book.assetName] (references image location in storage], [Book.isbn], [Book.title], [Book.author] ,[Book.description], [Book.publisher]
/// [Book.notes] which holds general notes made by a user, [Book.chapters] which stores chapterwise logs by a user and [Book.complete] to denote the status of a book.

class Book {
  Book({
    this.assetName,
    this.isbn,
    this.title,
    this.author,
    this.description,
    this.publisher,
    this.notes,
    this.chapters,
    this.complete,
  });

  String assetName;
  String isbn;
  String title;
  List<String> author;
  String description;
  String publisher;
  List<String> notes;
  List<String> chapters;
  bool complete;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
      assetName: json["assetName"],
      isbn: json["isbn"],
      title: json["title"],
      author: List<String>.from(json["author"].map((x) => x)),
      description: json["description"],
      publisher: json["publisher"],
      notes: List<String>.from(json["notes"].map((x) => x)),
      chapters: List<String>.from(json["chapters"].map((x) => x)),
      complete: json["complete"]);

  Map<String, dynamic> toJson() => {
        "assetName": assetName,
        "isbn": isbn,
        "title": title,
        "author": List<dynamic>.from(author.map((x) => x)),
        "description": description,
        "publisher": publisher,
        "notes": List<dynamic>.from(notes.map((x) => x)),
        "chapters": List<dynamic>.from(chapters.map((x) => x)),
        "complete": complete
      };

}
