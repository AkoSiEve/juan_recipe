// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryListModel {
  String version;
  Cuisines cuisines;

  CategoryListModel({
    required this.version,
    required this.cuisines,
  });

  factory CategoryListModel.fromRawJson(String str) =>
      CategoryListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryListModel.fromJson(Map<String, dynamic> json) =>
      CategoryListModel(
        version: json["version"],
        cuisines: Cuisines.fromJson(json["cuisines"]),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "cuisines": cuisines.toJson(),
      };

  @override
  String toString() =>
      'CategoryListModel(version: $version, cuisines: $cuisines)';
}

class Cuisines {
  List<Datum?> data;

  Cuisines({
    required this.data,
  });

  factory Cuisines.fromRawJson(String str) =>
      Cuisines.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cuisines.fromJson(Map<String, dynamic> json) => Cuisines(
        data: List<Datum?>.from(
            json["data"].map((x) => x == null ? null : Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x?.toJson())),
      };

  @override
  String toString() => 'Cuisines(data: $data)';
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

  @override
  String toString() => 'Datum(id: $id, name: $name)';
}
