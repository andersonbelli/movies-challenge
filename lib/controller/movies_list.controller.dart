import 'package:dio/dio.dart';
import 'package:movies_challenge/constants/constants.constants.dart';
import 'package:movies_challenge/model/movie.model.dart';

class MoviesListController {
  Dio dio = new Dio(BaseOptions(
    followRedirects: false,
    sendTimeout: 5000,
    validateStatus: (status) {
      return status < 500;
    },
  ));

  Future<List<MovieModel>> fetchMovies() async {
    Response response;

    try {
      response = await dio.get(
        "${Constants.BASEURL}${Constants.MOVIESURL}",
      );

      var responseData = response.data;

      print(responseData);

      return parseMovie(responseData);
    } on DioError catch (e) {
      print("Error code: " +
          e.response.statusCode.toString() +
          " - " +
          e.response.statusMessage.toString());

      return null;
    }
  }

  List<MovieModel> parseMovie(List<dynamic> json) {
    final data = MovieListModel.fromJson(json);

    return data.movies;
  }
}
