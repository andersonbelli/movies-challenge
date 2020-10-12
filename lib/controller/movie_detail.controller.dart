import 'package:dio/dio.dart';
import 'package:movies_challenge/constants/constants.constants.dart';
import 'package:movies_challenge/model/movie_details.model.dart';

class MovieDetailController {
  Dio _dio = new Dio(BaseOptions(
    sendTimeout: 5000,
    validateStatus: (status) {
      return status == 200;
    },
  ));

  Future<MovieDetailsModel> fetchMovieDetail(int id) async {
    try {
      Response response =
          await _dio.get("${Constants.BASE_URL}${Constants.MOVIES_URL}/$id");

      // print("Details data: ${response.data} \n\n");

      var responseData = MovieDetailsModel.fromJson(response.data);

      return responseData;
    } on DioError catch (e) {
      print("Error code: " +
          e.response.statusCode.toString() +
          " - " +
          e.response.statusMessage.toString());

      return null;
    }
  }
}
