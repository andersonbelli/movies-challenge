class BelongsToCollectionModel {
  int id;
  String name;
  String posterUrl;
  String backdropUrl;

  BelongsToCollectionModel({this.id, this.posterUrl, this.name, this.backdropUrl});

  BelongsToCollectionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    posterUrl = json['poster_url'];
    backdropUrl = json['backdrop_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['poster_url'] = this.posterUrl;
    data['backdrop_url'] = this.backdropUrl;
    return data;
  }
}