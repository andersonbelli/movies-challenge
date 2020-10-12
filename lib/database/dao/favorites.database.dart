import 'dart:io';

import 'package:movies_challenge/controller/feature/save_file.controller.dart';
import 'package:movies_challenge/model/movie.model.dart';
import 'package:sqflite/sqflite.dart';

import '../main_database.database.dart';

class FavoritesDatabase {
  static const String _favoritesTable = "favorites";
  static const String _id = "table_id";
  static const String _movieId = "id";
  static const String _movieTitle = "title";
  static const String _movieRate = "voteAverage";
  static const String _movieImage = "posterUrl";

  static const String tableSql = "CREATE TABLE $_favoritesTable(" +
      "$_id INTEGER PRIMARY KEY AUTOINCREMENT, " +
      "$_movieId INTEGER, " +
      "$_movieTitle TEXT, " +
      "$_movieRate REAL, " +
      "$_movieImage TEXT);";

  Future<int> save(int movieId, String movieTitle, String movieRate,
      String movieImage) async {
    final Database db = await getDatabase();

    return SaveFile.saveNetworkImage(movieImage).then((imageSavedPath) {
      return db.insert(_favoritesTable, {
        "id": movieId,
        "title": movieTitle,
        "voteAverage": movieRate,
        "posterUrl": imageSavedPath,
      });
    });
  }

  Future<bool> verifyFavorite(int movieId) async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result =
        await db.query(_favoritesTable, columns: ["id"], where: "id = $movieId");

    print("\n\n\nFavorite id result: " + result.toString());
    print("\n\n\nFavorite id result: " + result.length.toString());
    // Favorite id result: [{id: 238}]

    return result.length != 0 ? true : false;
  }

  Future<List<MovieModel>> findAll() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result = await db.query(_favoritesTable);

    print("\n\n\nresulaaaaaaaa: " + result.toString());

    List<MovieModel> favorites = List();

    result.forEach((element) {
      favorites.add(MovieModel(
          id: element["id"],
          title: element["title"],
          voteAverage: element["voteAverage"],
          posterUrl: element["posterUrl"]));
    });

    print("\n\n\nbbbbbbbbbbbr: " + favorites.length.toString());

    return favorites.length != 0 ? favorites : null;
  }
}
