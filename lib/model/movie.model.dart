class MovieListModel {
  final List<MovieModel> movies;

  MovieListModel({this.movies});

  factory MovieListModel.fromJson(List<dynamic> json) {
    List<MovieModel> movie = new List<MovieModel>();

    movie = json
        .map<MovieModel>((json) => MovieModel.fromJson(json))
        .cast<MovieModel>()
        .toList();

    return new MovieListModel(movies: movie);
  }
}

class MovieModel {
  int id;
  double voteAverage;
  String title;
  String posterUrl;
  List<String> genres;
  String releaseDate;
  bool isImageValid;

  MovieModel(
      {this.id,
      this.voteAverage,
      this.title,
      this.posterUrl,
      this.genres,
      this.releaseDate,
      this.isImageValid});

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voteAverage = json['vote_average'];
    title = json['title'];
    posterUrl = json['poster_url'];
    if (json['genres'] != null) genres = json['genres'].cast<String>();
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vote_average'] = this.voteAverage;
    data['title'] = this.title;
    data['poster_url'] = this.posterUrl;
    data['genres'] = this.genres;
    data['release_date'] = this.releaseDate;
    return data;
  }
}
