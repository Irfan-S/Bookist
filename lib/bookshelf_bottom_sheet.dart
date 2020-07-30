//import 'dart:math' as math;
//import 'dart:ui';
//
//import 'package:bookist_app/data/book.dart';
//import 'package:flutter/material.dart';
//
//const double minHeight = 120;
//const double iconStartSize = 44;
//const double iconEndSize = 120;
//const double iconStartMarginTop = 36;
//const double iconEndMarginTop = 80;
//const double iconsVerticalSpacing = 24;
//const double iconsHorizontalSpacing = 16;
//
//class BookshelfSheet extends StatefulWidget {
//  @override
//  _BookshelfSheetState createState() => _BookshelfSheetState();
//}
//
//class _BookshelfSheetState extends State<BookshelfSheet>
//    with SingleTickerProviderStateMixin {
//  AnimationController _controller;
//
//  double get maxHeight => MediaQuery.of(context).size.height;
//
//  double get headerTopMargin =>
//      lerp(20, 20 + MediaQuery.of(context).padding.top);
//
//  double get headerFontSize => lerp(14, 24);
//
//  double get itemBorderRadius => lerp(8, 24);
//
//  double get iconLeftBorderRadius => itemBorderRadius;
//
//  double get iconRightBorderRadius => lerp(8, 0);
//
//  double get iconSize => lerp(iconStartSize, iconEndSize);
//
//  double iconTopMargin(int index) =>
//      lerp(iconStartMarginTop,
//          iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize)) +
//      headerTopMargin;
//
//  double iconLeftMargin(int index) =>
//      lerp(index * (iconsHorizontalSpacing + iconStartSize), 0);
//
//  @override
//  void initState() {
//    super.initState();
//    _controller = AnimationController(
//      vsync: this,
//      duration: Duration(milliseconds: 600),
//    );
//  }
//
//  @override
//  void dispose() {
//    _controller.dispose();
//    super.dispose();
//  }
//
//  double lerp(double min, double max) =>
//      lerpDouble(min, max, _controller.value);
//
//  @override
//  Widget build(BuildContext context) {
//    return AnimatedBuilder(
//      animation: _controller,
//      builder: (context, child) {
//        return Positioned(
//          height: lerp(minHeight, maxHeight),
//          left: 0,
//          right: 0,
//          bottom: 0,
//          child: GestureDetector(
//            onTap: _toggle,
//            onVerticalDragUpdate: _handleDragUpdate,
//            onVerticalDragEnd: _handleDragEnd,
//            child: Container(
//              padding: const EdgeInsets.symmetric(horizontal: 32),
//              decoration: const BoxDecoration(
//                color: Color(0xFF162A49),
//                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
//              ),
//              child: Stack(
//                children: <Widget>[
//                  MenuButton(),
//                  SheetHeader(
//                    fontSize: headerFontSize,
//                    topMargin: headerTopMargin,
//                  ),
//                  for (Book book in _books) _buildFullItem(book),
//                  for (Book book in _books) _buildIcon(book),
//                ],
//              ),
//            ),
//          ),
//        );
//      },
//    );
//  }
//
//  Widget _buildIcon(Book book) {
//    int index = Book.books.indexOf(book);
//    return Positioned(
//      height: iconSize,
//      width: iconSize,
//      top: iconTopMargin(index),
//      left: iconLeftMargin(index),
//      child: ClipRRect(
//        borderRadius: BorderRadius.horizontal(
//          left: Radius.circular(iconLeftBorderRadius),
//          right: Radius.circular(iconRightBorderRadius),
//        ),
//        child: Image.asset(
//          'assets/${book.assetName}',
//          fit: BoxFit.cover,
//          alignment: Alignment(lerp(1, 0), 0),
//        ),
//      ),
//    );
//  }
//
//  Widget _buildFullItem(Book book) {
//    int index = Book.books.indexOf(book);
//    return ExpandedBookItem(
//      topMargin: iconTopMargin(index),
//      leftMargin: iconLeftMargin(index),
//      height: iconSize,
//      isVisible: _controller.status == AnimationStatus.completed,
//      borderRadius: itemBorderRadius,
//      book: book,
//    );
//  }
//
//  void _toggle() {
//    final bool isOpen = _controller.status == AnimationStatus.completed;
//    _controller.fling(velocity: isOpen ? -2 : 2);
//  }
//
//  void _handleDragUpdate(DragUpdateDetails details) {
//    _controller.value -= details.primaryDelta / maxHeight;
//  }
//
//  void _handleDragEnd(DragEndDetails details) {
//    if (_controller.isAnimating ||
//        _controller.status == AnimationStatus.completed) return;
//
//    final double flingVelocity =
//        details.velocity.pixelsPerSecond.dy / maxHeight;
//    if (flingVelocity < 0.0)
//      _controller.fling(velocity: math.max(2.0, -flingVelocity));
//    else if (flingVelocity > 0.0)
//      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
//    else
//      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
//  }
//}
//
//class ExpandedBookItem extends StatelessWidget {
//  final double topMargin;
//  final double leftMargin;
//  final double height;
//  final bool isVisible;
//  final double borderRadius;
//  final Book book;
//
//  const ExpandedBookItem(
//      {Key key,
//      this.topMargin,
//      this.height,
//      this.isVisible,
//      this.borderRadius,
//      this.book,
//      this.leftMargin})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Positioned(
//      top: topMargin,
//      left: leftMargin,
//      right: 0,
//      height: height,
//      child: AnimatedOpacity(
//        opacity: isVisible ? 1 : 0,
//        duration: Duration(milliseconds: 200),
//        child: Container(
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(borderRadius),
//            color: Colors.white,
//          ),
//          padding: EdgeInsets.only(left: height).add(EdgeInsets.all(8)),
//          child: _buildContent(),
//        ),
//      ),
//    );
//  }
//
//  Widget _buildContent() {
//    return Column(
//      children: <Widget>[
//        Text(book.title, style: TextStyle(fontSize: 16)),
//        SizedBox(height: 8),
//        Row(
//          children: <Widget>[
//            Text(
//              book.author.toString(),
//              style: TextStyle(
//                fontWeight: FontWeight.w500,
//                fontSize: 12,
//                color: Colors.grey.shade600,
//              ),
//            ),
//            SizedBox(width: 8),
//            Spacer(),
//            Text(
//              book.publisher,
//              style: TextStyle(
//                fontWeight: FontWeight.w300,
//                fontSize: 12,
//                color: Colors.grey,
//              ),
//            ),
//          ],
//        ),
//        Row(
//          children: <Widget>[
//            Flexible(
//                child: Text(
//              book.description,
//              maxLines: 4,
//              softWrap: true,
//              style: TextStyle(color: Colors.black, fontSize: 13),
//            ))
//          ],
//        )
//      ],
//    );
//  }
//}
//
//class SheetHeader extends StatelessWidget {
//  final double fontSize;
//  final double topMargin;
//
//  const SheetHeader(
//      {Key key, @required this.fontSize, @required this.topMargin})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Positioned(
//      left: 0,
//      right: 32,
//      child: IgnorePointer(
//        child: Container(
//          padding: EdgeInsets.only(top: topMargin, bottom: 12),
//          decoration: const BoxDecoration(
//            color: Color(0xFF162A49),
//          ),
//          child: Text(
//            'Currently Reading',
//            style: TextStyle(
//              color: Colors.white,
//              fontSize: fontSize,
//              fontWeight: FontWeight.w500,
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
////class SheetHeader extends StatelessWidget {
////  final double fontSize;
////  final double topMargin;
////
////  const SheetHeader(
////      {Key key, @required this.fontSize, @required this.topMargin})
////      : super(key: key);
////
////  @override
////  Widget build(BuildContext context) {
////    return Positioned(
////      top: topMargin,
////      child: Text(
////        'Booked Exhibition',
////        style: TextStyle(
////          color: Colors.white,
////          fontSize: fontSize,
////          fontWeight: FontWeight.w500,
////        ),
////      ),
////    );
////  }
////}
//
//class MenuButton extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Positioned(
//      right: 0,
//      bottom: 24,
//      child: Icon(
//        Icons.menu,
//        color: Colors.white,
//        size: 28,
//      ),
//    );
//  }
//}
