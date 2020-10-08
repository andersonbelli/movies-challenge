import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_challenge/controller/movies_list.controller.dart';
import 'package:movies_challenge/model/movie.model.dart';

import 'carousel_item.component.dart';

class Carousel extends StatelessWidget {
  final MoviesListController _moviesListController = MoviesListController();

  @override
  Widget build(BuildContext context) {
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
              return Swiper(
                fade: 0.8,
                loop: false,
                itemBuilder: (BuildContext context, int index) {
                  var item = snapshot.data[index];

                  return SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 20),
                      child: CarouselItem(movie: item),
                    ),
                  );
                },
                viewportFraction: 0.8,
                scale: 0.9,
                autoplay: true,
                itemCount: snapshot.data.length,
                pagination: new SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    // margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                    margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                    builder: new DotSwiperPaginationBuilder(
                        color: Colors.black54,
                        activeColor: Colors.black87,
                        size: 10.0,
                        activeSize: 15.0)),
                // control: new SwiperControl(),
              );
            }

            break;
        }

        return Text("Nothing to see here 🤔");
      },
    );
  }
}
