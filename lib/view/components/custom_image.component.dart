import 'package:flutter/material.dart';
import 'package:movies_challenge/constants/constants.constants.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  final bool isValidImage;

  const CustomImage({Key key, this.imageUrl, this.isValidImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mediaQueryData = MediaQuery.of(context);
    final _screenHeight = _mediaQueryData.size.height;

    return isValidImage != null
        ? isValidImage
            ? Container(
                // color: Colors.black,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment(9, 7),
                  colors: [
                    Colors.black,
                    Colors.grey[600],
                    Colors.black,
                  ],
                )),
                child: Image.network(
                  imageUrl,
                  errorBuilder: (BuildContext context, Object object,
                      StackTrace stacktrace) {
                    return Image.asset(
                      Constants.PLACE_HOLDER_IMAGE,
                      height: _screenHeight,
                      fit: BoxFit.cover,
                    );
                  },
                  height: _screenHeight,
                  fit: BoxFit.fitHeight,
                ),
              )
            : Image.asset(
                Constants.PLACE_HOLDER_IMAGE,
                height: _screenHeight,
                fit: BoxFit.cover,
              )
        : Image.asset(
            Constants.PLACE_HOLDER_IMAGE,
            height: _screenHeight,
            fit: BoxFit.cover,
          );
  }
}
