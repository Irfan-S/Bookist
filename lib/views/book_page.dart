import 'dart:io';

import 'package:bookist_app/data/book.dart';
import 'package:bookist_app/models/BookModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:scoped_model/scoped_model.dart';

class BookPage extends StatefulWidget {
  final Book currentBook;

  BookPage(this.currentBook);

  @override
  _BookPageState createState() => _BookPageState(currentBook);
}

class _BookPageState extends State<BookPage> {
  final Book currentBook;

  _BookPageState(this.currentBook);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xFFffffff), Color(0xFFfaf2c4)]),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              centerTitle: true,
              title: Header(currentBook.title),
              backgroundColor: Colors.transparent,
            ),
            body: ScopedModelDescendant<BookModel>(
                builder: (BuildContext context, Widget child, BookModel model) {
              return Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: currentBook.assetName.isEmpty
                          ? Text('No image selected.')
                          : Image.file(
                              File(currentBook.assetName),
                              height: MediaQuery.of(context).size.height * 0.4,
                              fit: BoxFit.fitWidth,
                            ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      currentBook.title,
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      currentBook.author.toString().replaceAll("\\[|\\]", ""),
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ],
                ),
              );
            })));
  }
}

class Header extends StatelessWidget {
  final String bookName;

  Header(this.bookName);

  @override
  Widget build(BuildContext context) {
    return Text(
      bookName,
      style: TextStyle(
        fontSize: 22,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
