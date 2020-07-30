import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

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

//  static final List<Book> books = [
//    bookFromJson('{"assetName":"art_of_choosing_book.jpg","isbn": "112","title": "Art Of Choosing","author":["Sheena Iyengar"],"description":" How to choose everything","publisher": "Penguin","notes": [], "chapters":[]}'),
//    bookFromJson('{"assetName":"creativity_book.jpg","isbn": "132","title": "Creativity Rules","author":["Tina Seelig"],"description": "Creativity is innate, you gotta unleash it","publisher": "Penguin","notes": [], "chapters":[]}'),
//    bookFromJson('{"assetName":"shoe_dog.jpg","isbn": "212","title": "Shoe Dog","author":["Phil Knight"],"description": "Nike and how it was started","publisher": "Penguin","notes": [], "chapters":[]}'),
//    bookFromJson('{"assetName":"thinking_book.jpg","isbn": "222","title": "Thinking, Fast and Slow","author":["Daniel Kahneman"],"description": "How to think and how we think","publisher": "Penguin","notes": [], "chapters":[]}'),
//    bookFromJson('{"assetName":"art_of_choosing_book.jpg","isbn": "112","title": "Art Of Choosing","author":["Sheena Iyengar"],"description": "How to choose everything","publisher": "Penguin","notes": [], "chapters":[]}'),
//    bookFromJson('{"assetName":"shoe_dog.jpg","isbn": "222","title": "Shoe Dog","author":["Phil Knight"],"description": "Nike and how it was started","publisher": "Penguin","notes": [], "chapters":[]}'),
//    bookFromJson('{"assetName":"shoe_dog.jpg","isbn": "222","title": "Shoe Dog","author":["Phil Knight"],"description": "Nike and how it was started","publisher": "Penguin","notes": [], "chapters":[]}'),
//  ];
}

//class Book {
//  final String assetName;
//  final String isbn;
//  final String title;
//  final List<String> author;
//  final String description;
//  final String publisher;
//  final List<String> notes;
//  final List<String> chapters;
//
//  Book(this.assetName, this.isbn, this.title, this.author, this.description,
//      this.publisher, this.notes, this.chapters);
//
//  static final List<Book> books = [
//    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
//        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], []),
//    Book('creativity_book.jpg', '132', 'Creativity Rules', ['Tina Seelig'],
//        'Creativity is innate, you gotta unleash it', 'Penguin', [], []),
//    Book('drive_book.jpg', '123', 'Drive', ['Daniel H. Pink'],
//        'What drives us all, and how to drive yourself', 'Giraffe', [], []),
//    Book('shoe_dog.jpg', '222', 'Shoe Dog', ['Phil Knight'],
//        'Nike and how it was started', 'Penguin', [], []),
//    Book(
//        'thinking_book.jpg',
//        '212',
//        'Thinking, Fast and Slow',
//        ['Daniel Kahneman'],
//        'How to think and how we think',
//        'Penguin',
//        [],
//        []),
//    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
//        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], []),
//    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
//        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], []),
//    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
//        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], []),
//    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
//        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], []),
//    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
//        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], []),
//    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
//        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], []),
//    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
//        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], [])
//  ];
//}
