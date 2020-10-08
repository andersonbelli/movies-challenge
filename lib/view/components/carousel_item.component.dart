import 'package:flutter/material.dart';
import 'package:movies_challenge/controller/movies_list.controller.dart';
import 'package:movies_challenge/model/movie.model.dart';

class CarouselItem extends StatelessWidget {

  final MovieModel movie;

  CarouselItem({this.movie});

  final MoviesListController _moviesListController = MoviesListController();

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
            child: new Image.network(
              movie.posterUrl.toString(),
              fit: BoxFit.fill,
              errorBuilder:
                  (BuildContext context, Object info, StackTrace stackTrace) {
                return Image.asset(
                  "lib/assets/images/movie_placeholder.png",
                  height: screenHeight - 180,
                  fit: BoxFit.fill,
                );
              },
              height: screenHeight - 180,
            ),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ))),
              onTap: () {

                // Navigator.push(context,
                //     MaterialPageRoute(
                //         builder: (context) => DetailsView(details: movie)));
              },
              title: Text(movie.title),
              subtitle: Text(
                movie.releaseDate,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          )
        ]);
  }
}
