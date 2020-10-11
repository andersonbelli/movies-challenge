import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_challenge/controller/movie_detail.controller.dart';
import 'package:movies_challenge/controller/movies_list.controller.dart';
import 'package:movies_challenge/model/movie.model.dart';
import 'package:movies_challenge/model/movie_details.model.dart';
import 'package:movies_challenge/view/components/search.component.dart';

import '../details.view.dart';
import 'carousel_item.component.dart';

class Carousel extends StatelessWidget {
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
            return Center(child: CircularProgressIndicator());
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
                        style: TextStyle(color: Colors.black87, fontSize: 16)),
                    Icon(Icons.cloud_off, color: Colors.black54, size: 30.0),
                    Text("\n Verify your connection and try again\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54, fontSize: 14)),
                    FlatButton(
                        color: Colors.black87,
                        child: Text("TRY AGAIN",
                            style: TextStyle(fontSize: 12, color: Colors.blue)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          // TODO try again
                          print("try again");
                        })
                  ],
                ),
              );
            } else {
              return Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: Container(
                          child: SearchField(),
                        ),
                      )),
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: Swiper(
                        fade: 0.8,
                        loop: true,
                        autoplayDisableOnInteraction: true,
                        autoplayDelay: 6000,
                        viewportFraction: 0.4,
                        scale: 0.2,
                        autoplay: true,
                        itemCount: snapshot.data.length,
                        itemWidth: _screenWidth,
                        itemHeight: _screenHeight - 150,
                        layout: SwiperLayout.STACK,
                        pagination: new SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            // margin: new EdgeInsets.only(top: 5),
                            builder: new DotSwiperPaginationBuilder(
                                color: Colors.black54,
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
                                  _showLoading(context,
                                      title: "Loading...",
                                      message: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 100),
                                          child: CircularProgressIndicator()),
                                      dismissible: false,
                                      buttonText: "cancel");

                                  _movieDetailController
                                      .fetchMovieDetail(item.id)
                                      .then(
                                    (movieDetails) {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailsView(
                                                  details: movieDetails),
                                              settings: RouteSettings(
                                                  arguments:
                                                      item.isImageValid)));
                                    },
                                  ).timeout(Duration(seconds: 5),
                                          onTimeout: () {
                                    _showLoading(context,
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
              );
            }
            break;
        }
        return Text("Nothing to see here 🤔");
      },
    );
  }

  _showLoading(BuildContext context,
      {@required String title,
      Widget message = const Text(""),
      bool dismissible = true,
      @required String buttonText}) {
    showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title, textAlign: TextAlign.center),
            content: message,
            actions: [
              FlatButton(
                  child: Text(buttonText),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }
}
