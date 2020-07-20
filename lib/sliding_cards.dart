import 'dart:math' as math;

import 'package:bookist_app/data/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SlidingCardsView extends StatefulWidget {
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView(
          controller: pageController,
          children: List.generate(
              Book.books.length,
              (index) => SlidingCard(
                    title: Book.books[index].title,
                    author: Book.books[index].author.toString(),
                    assetName: Book.books[index].assetName,
                    offset: pageOffset - index,
                  ))
//          SlidingCard(
//            title: Book.books[0].title,
//            author: Book.books[0].author.toString(),
//            assetName: Book.books[0].assetName,
//            offset: pageOffset,
//          ),
//          SlidingCard(
//            title: Book.books[1].title,
//            author: Book.books[1].author.toString(),
//            assetName: Book.books[1].assetName,
//            offset: pageOffset-1,
//          ),
//        ],
          ),
    );
  }
}

//class SlidingCardsView extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//    return GridView.count(
//      crossAxisCount: 2,
//      crossAxisSpacing: 10.0,
//      shrinkWrap: true,
//      scrollDirection: Axis.vertical,
////      childAspectRatio: (MediaQuery.of(context).size.width * 0.5 / MediaQuery.of(context).size.height * 0.2),
//      mainAxisSpacing: 10.0,
//      children: List.generate(Book.books.length, (index) {
//        return Padding(
//          padding: const EdgeInsets.all(10.0),
//          child: SizedBox(
//      height: MediaQuery.of(context).size.height * 0.55,
//      child: PageView(
//        SlidingCard(title: Book.books[index].title, author: Book.books[index].author.toString(), assetName: Book.books[index].assetName)
//
////            decoration: BoxDecoration(
////              image: DecorationImage(
////                image: NetworkImage('img.png'),
////                fit: BoxFit.cover,
////              ),
////              borderRadius:
////              BorderRadius.all(Radius.circular(20.0),),
////            ),
//          );
//      },),
//    );
//  }
//
//}

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
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
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
          child: Image.asset(
            'assets/$assetName',
            height: MediaQuery.of(context).size.height * 0.3,
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
