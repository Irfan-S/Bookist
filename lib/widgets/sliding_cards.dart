import 'dart:io';

import 'package:bookist_app/data/book.dart';
import 'package:bookist_app/models/BookModel.dart';
import 'package:bookist_app/views/book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

class SlidingCardsView extends StatefulWidget {
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
    super.initState();
  }


  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.55,
        child: ScopedModelDescendant<BookModel>(
            builder: (BuildContext context, Widget child, BookModel model) {
              return model.bookList.isNotEmpty ? PageView(
                  controller: pageController,
                  children: List.generate(
                      model.bookList.length,
                          (index) =>
                          SlidingCard(
                            currentBook: model.bookList[index],
                            offset: pageOffset - index,
                          ))
              )
                  : Center(child: Text("No books found"),);
            }
        )
    );
  }
}


class SlidingCard extends StatelessWidget {

  final Book currentBook;
  final double offset;

  const SlidingCard({
    Key key,
    @required this.offset,
    @required this.currentBook
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print("Titile $title");
    //double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Card(
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<BookPage>(
                builder: (context) => BookPage(currentBook)),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Image.file(
            File(currentBook.assetName),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.3,
            alignment: Alignment(-offset.abs(), 0),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String title;
  final String author;
  final double offset;

  const CardContent(
      {Key key,
      @required this.title,
      @required this.author,
      @required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(fontSize: 20)),
          SizedBox(height: 8),
          Text(
            author,
            style: TextStyle(color: Colors.grey),
          ),
          Spacer(),
          RaisedButton(
            color: Color(0xFF162A49),
            child: Text('Add to library'),
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
