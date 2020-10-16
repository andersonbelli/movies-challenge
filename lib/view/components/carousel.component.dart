import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_challenge/constants/constants.constants.dart';
import 'package:movies_challenge/controller/movie_detail.controller.dart';
import 'package:movies_challenge/controller/movies_list.controller.dart';
import 'package:movies_challenge/database/dao/favorites.database.dart';
import 'package:movies_challenge/model/movie.model.dart';

import '../details.view.dart';
import 'carousel_item.component.dart';

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final MoviesListController _moviesListController = MoviesListController();

  final MovieDetailController _movieDetailController = MovieDetailController();

  @override
  Widget build(BuildContext context) {
    final _mediaQueryData = MediaQuery.of(context);
    final _screenHeight = _mediaQueryData.size.height;
    final _screenWidth = _mediaQueryData.size.width;

    return FutureBuilder(
      future: _moviesListController.fetchMovies(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return Container(
                child: Center(
                    child: CircularProgressIndicator(
              backgroundColor: Color.fromRGBO(242, 99, 112, 1),
            )));
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Ops, something went wrong :(\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    Icon(Icons.cloud_off, color: Colors.grey, size: 30.0),
                    Text("\n Verify your connection and try again\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                    FlatButton(
                        color: Colors.blue,
                        child: Text("TRY AGAIN",
                            style:
                                TextStyle(fontSize: 12, color: Colors.black)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          setState(() {});
                        })
                  ],
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SafeArea(
                      child: Container(
                        height: _screenHeight - 220,
                        width: _screenWidth - 30,
                        // height: double.maxFinite,
                        child: Swiper(
                          fade: 0.8,
                          loop: true,
                          autoplayDisableOnInteraction: true,
                          autoplayDelay: 6000,
                          viewportFraction: 0.6,
                          scale: 0.1,
                          autoplay: true,
                          itemCount: snapshot.data.length,
                          itemWidth: _screenWidth,
                          itemHeight: _screenHeight,
                          layout: SwiperLayout.STACK,
                          pagination: new SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              margin: new EdgeInsets.only(top: 5),
                              builder: new DotSwiperPaginationBuilder(
                                  // color: Colors.black54,
                                  // color: Color.fromRGBO(242, 99, 112, 0.2),
                                  color: Color.fromRGBO(240,255,255, 0.3),
                                  activeColor: Colors.black87,
                                  size: 10.0,
                                  activeSize: 15.0)),
                          // control: new SwiperControl(),
                          itemBuilder: (BuildContext context, int index) {
                            MovieModel item = snapshot.data[index];
                            return SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: GestureDetector(
                                  onTap: () {
                                    Constants.showLoading(context,
                                        title: "Loading...",
                                        message: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 100),
                                            child: CircularProgressIndicator(
                                              backgroundColor: Color.fromRGBO(
                                                  242, 99, 112, 1),
                                            )),
                                        dismissible: false,
                                        buttonText: "cancel");

                                    _movieDetailController
                                        .fetchMovieDetail(item.id)
                                        .then(
                                      (movieDetails) {
                                        FavoritesDatabase _favoritesDatabase =
                                            new FavoritesDatabase();

                                        _favoritesDatabase
                                            .verifyFavorite(item.id)
                                            .then((isFavorite) {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsView(
                                                          details:
                                                              movieDetails),
                                                  settings: RouteSettings(
                                                      arguments: {
                                                        "isImageValid":
                                                            item.isImageValid,
                                                        "isFavorite": isFavorite
                                                      })));
                                        });
                                      },
                                    ).timeout(Duration(seconds: 5),
                                            onTimeout: () {
                                      Constants.showLoading(context,
                                          title: "Something went wrong",
                                          message: Text("Please, try again",
                                              textAlign: TextAlign.center),
                                          dismissible: true,
                                          buttonText: "ok");
                                    });
                                  },
                                  child: CarouselItem(movie: item)),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            break;
        }
        return Center(child: Text("Nothing to see here 🤔"));
      },
    );
  }
}
