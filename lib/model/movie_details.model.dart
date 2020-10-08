import 'belongs_to_collection.model.dart';
import 'production_companies.model.dart';
import 'production_countries.model.dart';
import 'spoken_languages.model.dart';

class MovieDetailsModel {
  bool adult;
  String backdropUrl;
  BelongsToCollectionModel belongsToCollection;
  int budget;
  List<String> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterUrl;
  List<ProductionCompaniesModel> productionCompanies;
  List<ProductionCountriesModel> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguagesModel> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieDetailsModel(
      {this.adult,
      this.backdropUrl,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterUrl,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropUrl = json['backdrop_url'];
    belongsToCollection = json['belongs_to_collection'] != null
        ? new BelongsToCollectionModel.fromJson(json['belongs_to_collection'])
        : null;
    budget = json['budget'];
    genres = json['genres'].cast<String>();
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterUrl = json['poster_url'];
    if (json['production_companies'] != null) {
      productionCompanies = new List<ProductionCompaniesModel>();
      json['production_companies'].forEach((v) {
        productionCompanies.add(new ProductionCompaniesModel.fromJson(v));
      });
    }
    if (json['production_countries'] != null) {
      productionCountries = new List<ProductionCountriesModel>();
      json['production_countries'].forEach((v) {
        productionCountries.add(new ProductionCountriesModel.fromJson(v));
      });
    }
    releaseDate = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];
    if (json['spoken_languages'] != null) {
      spokenLanguages = new List<SpokenLanguagesModel>();
      json['spoken_languages'].forEach((v) {
        spokenLanguages.add(new SpokenLanguagesModel.fromJson(v));
      });
    }
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_url'] = this.backdropUrl;
    data['belongs_to_collection'] = this.belongsToCollection;
    if (this.belongsToCollection != null)
      data['belongs_to_collection'] = this.belongsToCollection.toJson();
    data['budget'] = this.budget;
    data['genres'] = this.genres;
    data['homepage'] = this.homepage;
    data['id'] = this.id;
    data['imdb_id'] = this.imdbId;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_url'] = this.posterUrl;
    if (this.productionCompanies != null) {
      data['production_companies'] =
          this.productionCompanies.map((v) => v.toJson()).toList();
    }
    if (this.productionCountries != null) {
      data['production_countries'] =
          this.productionCountries.map((v) => v.toJson()).toList();
    }
    data['release_date'] = this.releaseDate;
    data['revenue'] = this.revenue;
    data['runtime'] = this.runtime;
    if (this.spokenLanguages != null) {
      data['spoken_languages'] =
          this.spokenLanguages.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['tagline'] = this.tagline;
    data['title'] = this.title;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    return data;
  }
}
