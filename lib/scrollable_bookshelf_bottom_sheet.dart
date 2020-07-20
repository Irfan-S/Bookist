import 'dart:math';
import 'dart:ui';

import 'package:bookist_app/data/book.dart';
import 'package:flutter/material.dart';

///Notice that by default this class is not used
///Go to [home_page.dart] and replace [ExhibitionBottomSheet] with [ScrollableBookshelfSheet] to use it
class ScrollableBookshelfSheet extends StatefulWidget {
  @override
  _ScrollableBookshelfSheetState createState() =>
      _ScrollableBookshelfSheetState();
}

class _ScrollableBookshelfSheetState extends State<ScrollableBookshelfSheet> {
  double initialPercentage = 0.15;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DraggableScrollableSheet(
        minChildSize: initialPercentage,
        initialChildSize: initialPercentage,
        builder: (context, scrollController) {
          return AnimatedBuilder(
            animation: scrollController,
            builder: (context, child) {
              double percentage = initialPercentage;
              double scaledPercentage = 0;
              if (scrollController.hasClients) {
                percentage = (scrollController.position.viewportDimension) /
                    (MediaQuery.of(context).size.height);
                //print("NS percentage: $percentage");
              } else {
                percentage = 0;
              }
              scaledPercentage =
                  (percentage - initialPercentage) / (0.9 - initialPercentage);
              if (scaledPercentage < 0) {
                scaledPercentage = 0;
              }
//              scaledPercentage =
//                  (percentage - initialPercentage) / ( 0.9- initialPercentage);
              print("Percentage is: $scaledPercentage");
              return Container(
                padding: const EdgeInsets.only(left: 32),
                decoration: const BoxDecoration(
                  color: Color(0xFF162A49),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: percentage >= 0.812 ? 1 : 0,
                      child: ListView.builder(
                        padding: EdgeInsets.only(right: 32, top: 128),
                        controller: scrollController,
                        itemCount: Book.books.length,
                        itemBuilder: (context, index) {
                          Book book = Book.books[index];
                          return MyBooksItem(
                            book: book,
                            percentageCompleted: percentage,
                          );
                        },
                      ),
                    ),
                    ...Book.books.map((event) {
                      int index = Book.books.indexOf(event);
                      int heightPerElement = 120 + 8 + 8;
                      double widthPerElement =
                          45 + percentage * 80 + 8 * (0.812 - percentage);
                      double leftOffset = widthPerElement *
                          (index > 5 ? index + 2 : index) *
                          (1 - scaledPercentage);
                      return Positioned(
                        top: 44.0 +
                            scaledPercentage * (128 - 44) +
                            index * heightPerElement * scaledPercentage,
                        left: leftOffset,
                        right: 32 - leftOffset,
                        child: IgnorePointer(
                          ignoring: true,
                          child: Opacity(
                            opacity: percentage >= 0.812 ? 0 : 1,
                            child: BookAnimationItem(
                              book: event,
                              percentageCompleted: percentage,
                            ),
                          ),
                        ),
                      );
                    }),
                    SheetHeader(
                      fontSize: 14 + percentage * 8,
                      topMargin:
                          16 + percentage * MediaQuery.of(context).padding.top,
                    ),
                    //MenuButton(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BookAnimationItem extends StatelessWidget {
  final Book book;
  final double percentageCompleted;

  const BookAnimationItem({Key key, this.book, this.percentageCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Transform.scale(
          alignment: Alignment.topLeft,
          scale: 1 / 3 + 2.463054 / 3 * percentageCompleted,
          child: SizedBox(
            height: 120,
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(16),
                    right: Radius.circular(16 * (0.812 - percentageCompleted)),
                  ),
                  child: Image.asset(
                    'assets/${book.assetName}',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class MyBooksItem extends StatelessWidget {
  final Book book;
  final double percentageCompleted;

  const MyBooksItem({Key key, this.book, this.percentageCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Transform.scale(
        alignment: Alignment.topLeft,
        scale: 1 / 3 + 2.463054 / 3 * percentageCompleted,
        child: GestureDetector(
            //TODO on tap implemented for both scrolls
            onTap: () {
              print("${book.title}");
            },
            child: SizedBox(
              height: 120,
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(16),
                      right:
                          Radius.circular(16 * (0.812 - percentageCompleted)),
                    ),
                    child: Image.asset(
                      'assets/${book.assetName}',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Opacity(
                      opacity: max(0, percentageCompleted * 2 - 0.7),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(16)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(8),
                        child: _buildContent(),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: <Widget>[
        Text(book.title, style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Row(
          children: <Widget>[
            Text(
              book.author.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(width: 8),
            Spacer(),
            Text(
              book.publisher,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Flexible(
                child: Text(
              book.description,
              maxLines: 4,
              softWrap: true,
              style: TextStyle(color: Colors.black, fontSize: 13),
            ))
          ],
        )
      ],
    );
  }
}

class SheetHeader extends StatelessWidget {
  final double fontSize;
  final double topMargin;

  const SheetHeader(
      {Key key, @required this.fontSize, @required this.topMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 32,
      child: IgnorePointer(
        child: Container(
          padding: EdgeInsets.only(top: topMargin, bottom: 12),
          decoration: const BoxDecoration(
            color: Color(0xFF162A49),
          ),
          child: Text(
            'Your Library',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

//class MenuButton extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Positioned(
//      right: 12,
//      bottom: 24,
//      child: Icon(
//        Icons.menu,
//        color: Colors.white,
//        size: 28,
//      ),
//    );
//  }
//}