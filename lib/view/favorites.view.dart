import 'package:flutter/material.dart';
import 'package:movies_challenge/database/dao/favorites.database.dart';
import 'package:movies_challenge/model/movie.model.dart';

class FavoritesView extends StatelessWidget {
  final FavoritesDatabase _favoritesDatabase = new FavoritesDatabase();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _favoritesDatabase.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return CircularProgressIndicator(
                  backgroundColor: Color.fromRGBO(242, 99, 112, 1));
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              print("sn " + snapshot.toString());
              print("snda " + snapshot.data.toString());

              if (snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      print("\n\nindex: " + index.toString());

                      MovieModel item = snapshot.data[index];
                      return Text(item.title);
                    });
              } else {
                return Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: "No favorites movies added.\n\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white)),
                      TextSpan(
                          text: "Add one by clicking in the ",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      WidgetSpan(
                        child: Icon(
                          Icons.favorite_border,
                          size: 18,
                          color: Colors.red,
                        ),
                      ),
                      TextSpan(
                          text: " in the details page.",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ]),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              break;
          }
          return Center(
              child: Text(
            "Nothing to see here 🤔",
            style: TextStyle(color: Colors.white),
          ));
        });
  }
}
