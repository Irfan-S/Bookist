import 'dart:convert';
import 'dart:io';

import 'package:bookist_app/models/BookModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/book.dart';

class NewBookPage extends StatefulWidget {
  @override
  _NewBookPageState createState() => _NewBookPageState();
}

class _NewBookPageState extends State<NewBookPage> {
  File _image;
  String _imgPath;
  final picker = ImagePicker();

  TextEditingController titleController = new TextEditingController();
  TextEditingController authorController = new TextEditingController();
  TextEditingController publisherController = new TextEditingController();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imgPath = pickedFile.path;
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Header(), backgroundColor: Colors.white),
        body: ScopedModelDescendant<BookModel>(
            builder: (BuildContext context, Widget child, BookModel model) {
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                    height: 300,
                    width: 300,
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: _image == null
                          ? Text('No image selected.')
                          : Image.file(_image),
                    )),
              ),
              //TODO on search this should autofill the other dialogs.
              Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                  child: Center(
                      child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 12, left: 12),
                            child: TextField(
                              controller: titleController,
                              maxLines: 2,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Book Title"),
                            ),
                          ))),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Container(
                        padding: EdgeInsets.all(8),
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 12, left: 12),
                              child: TextField(
                                controller: authorController,
                                maxLines: 2,
                                decoration: InputDecoration.collapsed(
                                    hintText: "Author"),
                              ),
                            ))),
                  ),
                  Flexible(
                    child: Container(
                        padding: EdgeInsets.all(8),
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 12, left: 12),
                              child: TextField(
                                maxLines: 2,
                                controller: publisherController,
                                decoration: InputDecoration.collapsed(
                                    hintText: "Publisher"),
                              ),
                            ))),
                  ),
                ],
              ),

              RaisedButton(
                onPressed: () {
                  Book newBook = Book.fromJson(json.decode(
                      '{"assetName":"$_imgPath","isbn": "NA","title": "${titleController.text}","author":["${authorController.text}"],"description":"NA","publisher": "${publisherController.text}","notes": [], "chapters":[],"complete":false}'));
                  model.addNewBook(newBook);
                  Navigator.pop(context);
                },
                color: Color(0xFF162A49),
                child: const Text('Done',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              )
              //Book author card
            ],
          );
        }));
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.library_add, color: Colors.black),
            SizedBox(width: 8),
            Text(
              'New book',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ));
  }
}
