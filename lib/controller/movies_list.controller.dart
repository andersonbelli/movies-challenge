import 'package:dio/dio.dart';
import 'package:movies_challenge/constants/constants.constants.dart';
import 'package:movies_challenge/model/movie.model.dart';

// TODO limitar tamanho da lista que vem da requisição (quantidade de itens)

Dio _dio = new Dio(BaseOptions(
  sendTimeout: 5000,
  validateStatus: (status) {
    return status == 200;
  },
));

class MoviesListController {
  Future<List<MovieModel>> fetchMovies() async {
    try {
      Response response =
          await _dio.get("${Constants.BASE_URL}${Constants.MOVIES_URL}");

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

    data.movies.forEach((element) {
      validateImage(element.posterUrl).then((isValidImage) {
        element.isImageValid = isValidImage;
      });
    });

    return data.movies;
  }

  static Future<bool> validateImage(String imageUrl) async {
    try {
      Response response = await _dio.get(imageUrl);
      if (response.data.toString().contains("<h1>File not Found</h1>"))
        return false;

      return true;
    } on DioError catch (e) {
      // print("Error code: " +
      //     e.response.statusCode.toString() +
      //     " - " +
      //     e.response.statusMessage.toString());

      return false;
    }
  }
}
