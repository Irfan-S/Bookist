import 'dart:convert';
import 'dart:io';

import 'package:bookist_app/data/book.dart';
import 'package:path_provider/path_provider.dart';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class BookStorage {
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String name, int option) async {
    if (option == 0) {
      return File(name);
    } else {
      final path = await localPath;
      return File('$path/$name.txt');
    }
  }

  Future<Book> readBook(String name) async {
    try {
      final file = await _localFile(name, 0);

      print("Calling read books");
      // Read the file
      String contents = await file.readAsString();

      return bookFromJson(contents);
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }

  Future<File> writeBook(Book book) async {
    final file = await _localFile(book.title, 1);
    // Write the file
    print("Calling write books with ${book.title}");
    return file.writeAsString(bookToJson(book));
  }
}
