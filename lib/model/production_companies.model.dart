class ProductionCompaniesModel {
  int id;
  String logoUrl;
  String name;
  String originCountry;

  ProductionCompaniesModel({this.id, this.logoUrl, this.name, this.originCountry});

  ProductionCompaniesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoUrl = json['logo_url'];
    name = json['name'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo_url'] = this.logoUrl;
    data['name'] = this.name;
    data['origin_country'] = this.originCountry;
    return data;
  }
}