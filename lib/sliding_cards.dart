import 'dart:io';

import 'package:bookist_app/data/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'data/book_storage.dart';

class SlidingCardsView extends StatefulWidget {
  final BookStorage bookStorage;

  SlidingCardsView({Key key, @required this.bookStorage}) : super(key: key);

  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset = 0;
  List<Book> _books = [];

  void _getBookList() async {
    try {
      String directory = await widget.bookStorage.localPath;
      print("Directory is $directory");

      List<Book> localBookList = [];
      //Directory(directory).list().listen((event) {print(event.path);});
      Directory(directory).list().listen((event) {
        //print("File name ${event.path}");
        if (event.path.endsWith(".txt")) {
          //print("hit");
          widget.bookStorage.readBook(event.path).then((value) =>
              localBookList.add(value));
        }
      }).onDone(() {
        setState(() {
          if (_books.length <= localBookList.length) {
            _books = localBookList;
          }
        });
      });
    } catch (e) {
      print("Error reading book list");
    }
  }


  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
    _getBookList();
    super.initState();
  }


  @override
  void didUpdateWidget(SlidingCardsView oldWidget) {
    _getBookList();
    super.didUpdateWidget(oldWidget);
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
        child: _books.isNotEmpty ? PageView(
            controller: pageController,
            children: List.generate(
                _books.length,
                    (index) =>
                    SlidingCard(
                      title: _books[index].title,
                      author: _books[index].author.toString(),
                      assetName: _books[index].assetName,
                      offset: pageOffset - index,
                    ))
        )
            : Center(child: Text("No books found"),)
    );
  }
}


class SlidingCard extends StatelessWidget {
  final String title;
  final String author;
  final String assetName;
  final double offset;

  const SlidingCard({
    Key key,
    @required this.title,
    @required this.author,
    @required this.assetName,
    @required this.offset,
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
          print("$title");
        },
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          child: Image.file(
            File(assetName),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.3,
            alignment: Alignment(-offset.abs(), 0),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
//    Column(
//      children: <Widget>[
////            Image.asset(
////              'assets/$assetName',
////              height: MediaQuery.of(context).size.height * 0.3,
////              alignment: Alignment(-offset.abs(), 0),
////              fit: BoxFit.contain,
////            ),
//        ClipRRect(
//          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
//          child: Image.asset(
//            'assets/$assetName',
//            height: MediaQuery.of(context).size.height * 0.3,
//            alignment: Alignment(-offset.abs(), 0),
//            fit: BoxFit.contain,
//          ),
//        ),
//        SizedBox(height: 8),
//        Expanded(
//          child: CardContent(
//            title: title,
//            author: author,
//            offset: gauss,
//          ),
//        ),
//      ],
    );
//  );
//    return Transform.translate(
//      offset: Offset(-32 * gauss * offset.sign, 0),
//      child: Card(
//        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
//        elevation: 8,
//        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
//        child: Column(
//          children: <Widget>[
//            Image.asset(
//              'assets/$assetName',
//              height: MediaQuery.of(context).size.height * 0.3,
//              alignment: Alignment(-offset.abs(), 0),
//              fit: BoxFit.contain,
//            ),
//            ClipRRect(
//              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
//              child: Image.asset(
//                'assets/$assetName',
//                height: MediaQuery.of(context).size.height * 0.3,
//                alignment: Alignment(-offset.abs(), 0),
//                fit: BoxFit.contain,
//              ),
//            ),
//            SizedBox(height: 8),
//            Expanded(
//              child: CardContent(
//                title: title,
//                author: author,
//                offset: gauss,
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
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
