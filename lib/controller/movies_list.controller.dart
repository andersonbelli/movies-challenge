import 'package:dio/dio.dart';
import 'package:movies_challenge/constants/constants.constants.dart';
import 'package:movies_challenge/model/movie.model.dart';

class MoviesListController {
  Dio _dio = new Dio(BaseOptions(
    sendTimeout: 5000,
    validateStatus: (status) {
      return status == 200;
    },
  ));

  Future<List<MovieModel>> fetchMovies() async {
    try {
      Response response =
          await _dio.get("${Constants.BASEURL}${Constants.MOVIESURL}");

      var responseData = response.data;

      return parseMovies(responseData);
    } on DioError catch (e) {
      print("Error code: " +
          e.response.statusCode.toString() +
          " - " +
          e.response.statusMessage.toString());

      return null;
    }
  }

  List<MovieModel> parseMovies(List<dynamic> json) {
    final data = MovieListModel.fromJson(json);

    return data.movies;
  }
}
