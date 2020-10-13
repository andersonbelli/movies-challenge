import 'dart:io';

import 'package:image_downloader/image_downloader.dart';
import 'package:movies_challenge/constants/constants.constants.dart';
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

    var path;

    try {
      var imageId = await ImageDownloader.downloadImage(movieImage);

      var fileName = await ImageDownloader.findName(imageId);
      path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);

      print("fileName:   +++++++ $fileName");
      print("path:   +++++++ $path");
    } catch (error) {
      print(error);
    }

    if (path == null) path = Constants.PLACE_HOLDER_IMAGE;

    print("\n\nsalvo!");

    return db.insert(_favoritesTable, {
      "id": movieId,
      "title": movieTitle,
      "voteAverage": movieRate,
      "posterUrl": path,
    });

    print("----------------------");
  }

  Future<int> delete(int movieId) async {
    final Database db = await getDatabase();

    return db.delete(_favoritesTable, where: "id = $movieId");
  }

  Future<bool> verifyFavorite(int movieId) async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result = await db.query(_favoritesTable,
        columns: ["id"], where: "id = $movieId");

    return result.length != 0 ? true : false;
  }

  Future<List<MovieModel>> findAll() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result = await db.query(_favoritesTable);

    List<MovieModel> favorites = List();

    result.forEach((element) {
      favorites.add(MovieModel(
          id: element["id"],
          title: element["title"],
          voteAverage: element["voteAverage"],
          posterUrl: element["posterUrl"]));
    });

    return favorites.length != 0 ? favorites : null;
  }
}
