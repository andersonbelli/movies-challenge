import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Constants {
  static final String BASE_URL =
      "https://desafio-mobile.nyc3.digitaloceanspaces.com/";
  static final String MOVIES_URL = "movies";
  static final String PLACE_HOLDER_IMAGE =
      "lib/assets/images/movie_placeholder.png";

  static Future requestStorage() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    print(statuses[Permission.storage]);
  }

  static showLoading(BuildContext context,
      {@required String title,
      Widget message = const Text(""),
      bool dismissible = true,
      @required String buttonText}) {
    showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87),
            ),
            content: message,
            actions: [
              buttonText != null
                  ? FlatButton(
                      child: Text(
                        buttonText,
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                  : Container(width: 0.0, height: 0.0)
            ],
          );
        });
  }

  static Map<int, Color> mainColor = {
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

  static Map<int, Color> customWhite = {
    50: Color.fromRGBO(248, 248, 255, .1),
    100: Color.fromRGBO(248, 248, 255, .2),
    200: Color.fromRGBO(248, 248, 255, .3),
    300: Color.fromRGBO(248, 248, 255, .4),
    400: Color.fromRGBO(248, 248, 255, .5),
    500: Color.fromRGBO(248, 248, 255, .6),
    600: Color.fromRGBO(248, 248, 255, .7),
    700: Color.fromRGBO(248, 248, 255, .8),
    800: Color.fromRGBO(248, 248, 255, .9),
    900: Color.fromRGBO(248, 248, 255, 1)
  };
}
