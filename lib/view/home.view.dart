import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'components/carousel.component.dart';
import 'components/search.component.dart';
import 'details.view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => new _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _curIndex = 0;

  final List<Widget> _children = [Carousel(), DetailsView()];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleSpacing: 40,
        title: SearchField(),
      ),
      body: _children[_curIndex],
      // extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // color: Color.lerp(Colors.deepPurple[800], Colors.transparent, 0.2),
          color: Colors.transparent,
          // borderRadius: BorderRadius.only(
          //     topRight: Radius.circular(55), topLeft: Radius.circular(55)),
          // boxShadow: [
          //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          // ],
        ),
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: _curIndex,
          selectedIconTheme: IconThemeData(size: 35),
          showUnselectedLabels: true,
          // unselectedIconTheme: IconThemeData(color: Colors.white38),
          selectedItemColor: Colors.black87,
          unselectedIconTheme: IconThemeData(color: Colors.black54),
          unselectedLabelStyle: TextStyle(color: Colors.black54),
          type: BottomNavigationBarType.shifting,
          onTap: (index) {
            setState(() {
              _curIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              // backgroundColor: Colors.deepPurple,
              backgroundColor: Colors.transparent,
              icon: Icon(
                Icons.home,
                // size: 25,
              ),
              title: Text("Home", style: TextStyle(color: Colors.black87)),
            ),
            BottomNavigationBarItem(
              // backgroundColor: Colors.deepPurpleAccent,
              backgroundColor: Colors.transparent,
              icon: Icon(Icons.list),
              title:
                  Text("Categories", style: TextStyle(color: Colors.black87)),
            )
          ],
        ),
      ),
    );
  }
}
