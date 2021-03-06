import 'dart:io';

import 'package:bookist_app/data/book.dart';
import 'package:bookist_app/data/book_storage.dart';
import 'package:scoped_model/scoped_model.dart';

class BookModel extends Model {
  List<Book> _bookList = [];

  BookStorage _bookStorage = BookStorage();

  List<Book> get bookList {
    return _bookList;
  }

  void updateBookList() {
    _getBookList();
  }

  void _notifyParent() {
    notifyListeners();
  }

  void addNewBook(Book newBook) {
    _bookStorage.writeBook(newBook);
    _getBookList();
  }

  /// Fetches list of .txt files at [_bookStorage.localPath]
  ///
  /// Data stored in a .txt extension, which is then fetched , read and stored at [_bookList]
  ///
  void _getBookList() async {
    try {
      String directory = await _bookStorage.localPath;
      print("Directory is $directory");
      _bookList.clear();
      //Directory(directory).list().listen((event) {print(event.path);});
      Directory(directory).list().listen((event) {
        //print("File name ${event.path}");
        if (event.path.endsWith(".txt")) {
          print("hit");
          _bookStorage
              .readBook(event.path)
              .then((value) => {_bookList.add(value), _notifyParent()});
        }
      }).onDone(() {
        print("New books: ${_bookList.length}");
      });
    } catch (e) {
      print("Error reading book list");
    }
    notifyListeners();
  }
}
