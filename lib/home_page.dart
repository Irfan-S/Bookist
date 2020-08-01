import 'package:bookist_app/add_new_book.dart';
import 'package:bookist_app/models/BookModel.dart';
import 'package:bookist_app/scrollable_bookshelf_bottom_sheet.dart';
import 'package:bookist_app/sliding_cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
  bool isInit = true;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<BookModel>(
        builder: (BuildContext context, Widget child, BookModel model) {
      return DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                title: Header(),
                backgroundColor: Colors.white,
                elevation: 0,
                bottom: TabBar(
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.black,
                    indicator:
                        RectTabIndicator(color: Color(0xFFFF5A1D), radius: 5),
                    tabs: [
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Reading"),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Search"),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Profile"),
                          ),
                        ),
                      ),
                    ]),
              ),
              body: Scaffold(
                backgroundColor: Colors.white,
                body: TabBarView(
                  children: [
                    Stack(
                      children: <Widget>[
                        SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 8),
                              //Header(),
                              SizedBox(height: 40),
                              SizedBox(height: 8),
                              SlidingCardsView(),
                            ],
                          ),
                        ),
                        ScrollableBookshelfSheet()
                        //, //use this or ScrollableExhibitionSheet//
                      ],
                    ),
                    Icon(Icons.directions_car),
                    Icon(Icons.directions_transit)
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<NewBookPage>(
                          builder: (context) => NewBookPage()),
                    );
                    // Add your onPressed code here!
                  },
                  child: Icon(
                    Icons.add,
                    color: Color(0xFF162A49),
                  ),
                  backgroundColor: Colors.white,
                ),
              )));
    });
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.library_books, color: Colors.black),
            SizedBox(width: 8),
            Text(
              'Bookist',
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

class RectTabIndicator extends Decoration {
  final BoxPainter _painter;

  RectTabIndicator({@required Color color, @required double radius})
      : _painter = _RectPainter(color, radius);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _RectPainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _RectPainter(Color color, this.radius)
      : _paint = Paint()
    ..color = color
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size.width / 2.5, cfg.size.height - radius - 10);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            circleOffset & Size(20, 6), Radius.circular(10)),
        _paint);
//    canvas.drawRRect(circleOffset & Size(20,6), _paint);
    //canvas.drawCircle(circleOffset, radius, _paint);
  }
}
