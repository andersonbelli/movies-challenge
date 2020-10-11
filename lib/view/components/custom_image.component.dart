import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String _placeHolder = "lib/assets/images/movie_placeholder.png";

  final String imageUrl;
  final bool isValidImage;

  const CustomImage({Key key, this.imageUrl, this.isValidImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mediaQueryData = MediaQuery.of(context);
    final _screenHeight = _mediaQueryData.size.height - 180;

    return isValidImage != null
        ? isValidImage
            ? Image.network(
                imageUrl,
                errorBuilder: (BuildContext context, Object object,
                    StackTrace stacktrace) {
                  return Image.asset(
                    _placeHolder,
                    height: _screenHeight,
                    fit: BoxFit.fill,
                  );
                },
                height: _screenHeight,
                fit: BoxFit.fill,
              )
            : Image.asset(
                _placeHolder,
                height: _screenHeight,
                fit: BoxFit.fill,
              )
        : Image.asset(
            _placeHolder,
            height: _screenHeight,
            fit: BoxFit.fill,
          );
  }
}
