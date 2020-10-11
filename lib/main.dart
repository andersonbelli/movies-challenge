import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/constants.constants.dart';
import 'view/home.view.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF880E4F, Constants.mainColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(
        title: "Title",
      ),
    );
  }
}
