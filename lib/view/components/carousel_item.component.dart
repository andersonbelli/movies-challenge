import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_challenge/model/movie.model.dart';

import 'custom_image.component.dart';

class CarouselItem extends StatelessWidget {
  final MovieModel movie;

  CarouselItem({this.movie});

  @override
  Widget build(BuildContext context) {
    final _mediaQueryData = MediaQuery.of(context);
    final _screenHeight = _mediaQueryData.size.height;
    final _screenWidth = _mediaQueryData.size.width;

    return Container(
      height: _screenHeight - 245,
      // margin: const EdgeInsets.only(bottom: 4, left: 5, right: 5),
      margin: const EdgeInsets.all(0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Container(
              // color: Colors.indigo,
              height: double.maxFinite,
              width: _screenWidth - 40,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45)),
                child: CustomImage(
                    imageUrl: movie.posterUrl,
                    isValidImage: movie.isImageValid),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: _screenWidth - 40,
              height: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(248, 248, 255, 1),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(2, 2))
                      ],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0)),
                    ),
                    margin: const EdgeInsets.all(0),
                    child: ListTile(
                        leading: Container(
                            width: 55,
                            height: 55,
                            // height: double.maxFinite,
                            decoration: BoxDecoration(
                                //TODO change item rate color based on value
                                // color: Color.fromRGBO(242, 99, 112, 1),
                                color: Colors.green[400],
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 2,
                                      blurRadius: 6),
                                ]),
                            child: Center(
                                child: Text(
                              movie.voteAverage.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                shadows: [
                                  Shadow(
                                      color: Colors.black54,
                                      blurRadius: 5,
                                      offset: Offset(2, 2))
                                ],
                              ),
                            ))),
                        title: Text(
                          movie.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        subtitle: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: "release date: ",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            TextSpan(
                              text: DateFormat("dd/MM/yyyy")
                                  .format(DateTime.parse(movie.releaseDate)),
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
