import 'package:bookist_app/models/BookModel.dart';
import 'package:bookist_app/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final _bookModel = BookModel();

  @override
  Widget build(BuildContext context) {
    _bookModel.updateBookList();
    return ScopedModel<BookModel>(
        model: _bookModel,
        child: MaterialApp(
          theme: ThemeData(fontFamily: 'SF Pro Display'),
          title: 'Bookist',
          home: HomePage(),
        ));
  }
}
