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
  static const String _movieRate = "vote_average";
  static const String _movieImage = "poster_url";

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

    if (!(movieImage == Constants.PLACE_HOLDER_IMAGE)) {
      try {
        var imageId = await ImageDownloader.downloadImage(movieImage,
            destination: AndroidDestinationType.directoryDownloads);

        var fileName = await ImageDownloader.findName(imageId);
        path = await ImageDownloader.findPath(imageId);
        var size = await ImageDownloader.findByteSize(imageId);
        var mimeType = await ImageDownloader.findMimeType(imageId);

        print("path:   +++++++ $path");
      } catch (error) {
        print(error);
      }
    }

    if (path == null) path = Constants.PLACE_HOLDER_IMAGE;

    return db.insert(_favoritesTable, {
      _movieId: movieId,
      _movieTitle: movieTitle,
      _movieRate: movieRate,
      _movieImage: path,
    });
  }

  Future<int> delete(int movieId) async {
    final Database db = await getDatabase();

    MovieModel movie = await findSaved(movieId);
    if (movie.posterUrl != Constants.PLACE_HOLDER_IMAGE) {
      final dir = Directory(movie.posterUrl);
      dir.deleteSync(recursive: true);
    }

    return db.delete(_favoritesTable, where: "id = $movieId");
  }

  Future<MovieModel> findSaved(int movieId) async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result =
        await db.query(_favoritesTable, where: "id = $movieId");

    print("Result ${result[0].toString()}");

    return MovieModel.fromJson(result[0]);
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
          id: element[_movieId],
          title: element[_movieTitle],
          voteAverage: element[_movieRate],
          posterUrl: element[_movieImage]));
    });

    return favorites.length != 0 ? favorites : null;
  }
}
