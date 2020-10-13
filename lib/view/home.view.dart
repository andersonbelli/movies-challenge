import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'components/carousel.component.dart';
import 'favorites.view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => new _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _curIndex = 0;

  final List<Widget> _children = [Carousel(), FavoritesView()];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blueGrey[700],
                    Colors.indigo[800],
                    Colors.blueGrey[900],
                  ])),
          child: SafeArea(
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 25, left: 25),
                    width: double.maxFinite,
                    child: Text(
                      "My Movies",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          letterSpacing: 0.1,
                          color: Color.fromRGBO(248, 248, 255, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          fontFamily: "Piazzolla-Italic",
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              color: Colors.black12,
                              blurRadius: 5,
                            )
                          ]),
                    ),
                  ),
                ),
                Expanded(flex: 6, child: _children[_curIndex]),
              ],
            ),
          ),
        ),
      ),
      extendBody: true,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(248, 248, 255, 1),
          // color: Colors.transparent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(175.0),
              topRight: Radius.circular(175.0)),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: _curIndex,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 35),
          showUnselectedLabels: true,
          // selectedItemColor: Color.fromRGBO(242, 99, 112, 1),
          selectedItemColor: Colors.green[400],
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
              icon: Icon(Icons.home),
              title: Text("Home",
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold)),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Icon(Icons.favorite),
              title: Text("Favorites",
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
