import 'dart:io';

import 'package:bookist_app/data/book.dart';
import 'package:bookist_app/models/BookModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:scoped_model/scoped_model.dart';

class BookPage extends StatefulWidget {
  final Book currentBook;

  BookPage(this.currentBook);

  @override
  _BookPageState createState() => _BookPageState(currentBook);
}

class _BookPageState extends State<BookPage>
    with SingleTickerProviderStateMixin {
  final Book currentBook;
  Color darkMutedColor;
  Color darkVibrantColor;
  Color lightMutedColor;
  Color lightVibrantColor;
  Color dominantColor;

  //TabController _controller;

  @override
  void initState() {
    super.initState();
    _updatePalettes();
    //_controller = new TabController(length: 3, vsync: this);
  }

  _updatePalettes() async {
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
        FileImage(File(currentBook.assetName)),
        size: Size(200, 200));
    print("Length of colors: ${generator.colors.length}");
    darkMutedColor = generator.darkMutedColor != null
        ? generator.darkMutedColor.color
        : Colors.black45;
    darkVibrantColor = generator.darkVibrantColor != null
        ? generator.darkVibrantColor.color
        : Colors.black;
    lightMutedColor = generator.lightMutedColor != null
        ? generator.lightMutedColor.color
        : Colors.white;
    lightVibrantColor = generator.lightVibrantColor != null
        ? generator.lightVibrantColor.color
        : Colors.grey;
    dominantColor = generator.dominantColor != null
        ? generator.dominantColor.color
        : Colors.blue;
    setState(() {});
  }

  _BookPageState(this.currentBook);

  //TODO

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<BookModel>(
        builder: (BuildContext context, Widget child, BookModel model) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xFFffffff), Color(0xFFfaf2c4)]),
        ),
        child: Scaffold(
            body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    iconTheme: IconThemeData(
                      color: darkMutedColor, //change your color here
                    ),
                    expandedHeight: MediaQuery.of(context).size.height * 0.3,
                    floating: false,
                    pinned: true,
                    backgroundColor: lightMutedColor,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Header(currentBook, darkMutedColor),
                        background: Flex(
                          direction: Axis.vertical,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.file(
                                File(currentBook.assetName),
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                fit: BoxFit.contain,
                              ),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            // Header(currentBook, darkMutedColor)
                          ],
                        ))),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Colors.black,
//                        indicator: RectTabIndicator(
//                            color: Color(0xFF202143), radius: 5),
                        tabs: [
                          Tab(
                            child: Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Your notes"),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Overview"),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("About"),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                Icon(Icons.ac_unit),
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit)
              ],
            ),
          ),
        )),
      );
    });
  }
}

class Header extends StatelessWidget {
  final Book currentBook;
  final Color color;

  Header(this.currentBook, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Text(currentBook.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 24,
              color: color,
              fontWeight: FontWeight.w700,
            ))
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
