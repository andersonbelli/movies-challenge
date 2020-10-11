import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_challenge/controller/movie_detail.controller.dart';
import 'package:movies_challenge/controller/movies_list.controller.dart';
import 'package:movies_challenge/model/movie.model.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../details.view.dart';
import 'custom_image.component.dart';

class CarouselItem extends StatelessWidget {
  final MovieModel movie;

  CarouselItem({this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(45)),
              child: CustomImage(
                  imageUrl: movie.posterUrl, isValidImage: movie.isImageValid),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                  leading: Container(
                      width: 55,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                          //TODO change item rate color based on value
                          color: Colors.lightBlue,
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  subtitle: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: "release date: ",
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
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
            )
          ]),
    );
  }

  customImage(context, String imageUrl, bool isValidImage) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenHeight = _mediaQueryData.size.height;

    String placeHolder = "lib/assets/images/movie_placeholder.png";

    if (isValidImage == null) isValidImage = false;

    return isValidImage
        ? Image.network(
            imageUrl,
            errorBuilder:
                (BuildContext context, Object object, StackTrace stacktrace) {
              return Image.asset(
                placeHolder,
                height: screenHeight - 180,
                fit: BoxFit.fill,
              );
            },
            height: screenHeight - 180,
            fit: BoxFit.fill,
          )
        : Image.asset(
            placeHolder,
            height: screenHeight - 180,
            fit: BoxFit.fill,
          );
  }
}
