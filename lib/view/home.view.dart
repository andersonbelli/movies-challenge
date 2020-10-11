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

  final List<Widget> _children = [Carousel()];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 255, 1),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   centerTitle: true,
      //   titleSpacing: 40,
      //   title: SearchField(),
      // ),
      body: SafeArea(
        child: Container(
          child: _children[_curIndex],
        ),
      ),
      // extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: _curIndex,
          selectedIconTheme: IconThemeData(size: 35),
          showUnselectedLabels: true,
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
              backgroundColor: Colors.transparent,
              icon: Icon(
                Icons.home,
              ),
              title: Text("Home", style: TextStyle(color: Colors.black87)),
            ),
            BottomNavigationBarItem(
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
