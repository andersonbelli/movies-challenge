import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_challenge/controller/movie_detail.controller.dart';
import 'package:movies_challenge/controller/movies_list.controller.dart';
import 'package:movies_challenge/model/movie.model.dart';

import '../details.view.dart';

class CarouselItem extends StatelessWidget {
  final MovieModel movie;

  CarouselItem({this.movie});

  final MoviesListController _moviesListController = MoviesListController();
  final MovieDetailController _movieDetailController = MovieDetailController();

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenHeight = _mediaQueryData.size.height;

    return Stack(
        fit: StackFit.loose,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(45)),
              child: Image.network(
                movie.posterUrl,
                errorBuilder: (BuildContext context, Object object,
                    StackTrace stacktrace) {
                  return Image.asset(
                    "lib/assets/images/movie_placeholder.png",
                    height: screenHeight - 180,
                    fit: BoxFit.fill,
                  );
                },
                height: screenHeight - 180,
                fit: BoxFit.fill,
              )
              // CachedNetworkImage(
              //     imageUrl: movie.posterUrl,
              //     placeholder: (context, url) {
              //       print(url.toString());
              //
              //       return Image.asset(
              //         "lib/assets/images/movie_placeholder.png",
              //         height: screenHeight - 180,
              //         fit: BoxFit.fill,
              //       );
              //     }),
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
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 2,
                              blurRadius: 6),
                        ]),
                    child: Center(
                        child: Text(
                      movie.voteAverage.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ))),
                onTap: () {
                  _movieDetailController.fetchMovieDetail(movie.id).then(
                        (movieDetails) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailsView(details: movieDetails))),
                      );
                },
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
        ]);
  }
}
