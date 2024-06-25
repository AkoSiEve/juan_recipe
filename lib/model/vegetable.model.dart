import 'dart:convert';

class CategoryVegetableModel {
  String version;
  Categories categories;

  CategoryVegetableModel({
    required this.version,
    required this.categories,
  });

  factory CategoryVegetableModel.fromRawJson(String str) =>
      CategoryVegetableModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryVegetableModel.fromJson(Map<String, dynamic> json) =>
      CategoryVegetableModel(
        version: json["version"],
        categories: Categories.fromJson(json["categories"]),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "categories": categories.toJson(),
      };
}

class Categories {
  List<Datum> data;

  Categories({
    required this.data,
  });

  factory Categories.fromRawJson(String str) =>
      Categories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String name;

  Datum({
    required this.id,
    required this.name,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
