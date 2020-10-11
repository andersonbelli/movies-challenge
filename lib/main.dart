import 'package:flutter/material.dart';

import 'view/home.view.dart';

void main() {
  runApp(MyApp());
}

Map<int, Color> mainColor = {
  50: Color.fromRGBO(40, 121, 254, .1),
  100: Color.fromRGBO(40, 121, 254, .2),
  200: Color.fromRGBO(40, 121, 254, .3),
  300: Color.fromRGBO(40, 121, 254, .4),
  400: Color.fromRGBO(40, 121, 254, .5),
  500: Color.fromRGBO(40, 121, 254, .6),
  600: Color.fromRGBO(40, 121, 254, .7),
  700: Color.fromRGBO(40, 121, 254, .8),
  800: Color.fromRGBO(40, 121, 254, .9),
  900: Color.fromRGBO(40, 121, 254, 1),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF880E4F, mainColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(
        title: "Title",
      ),
    );
  }
}
