// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FilipinoRecipeModel {
  String filipinoRecipe;
  String authorAPi;
  List<Map<String, List<Datum>>> data;

  FilipinoRecipeModel({
    required this.filipinoRecipe,
    required this.authorAPi,
    required this.data,
  });

  factory FilipinoRecipeModel.fromRawJson(String str) =>
      FilipinoRecipeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FilipinoRecipeModel.fromJson(Map<String, dynamic> json) =>
      FilipinoRecipeModel(
        filipinoRecipe: json["filipinoRecipe"],
        authorAPi: json["authorAPi"],
        data: List<Map<String, List<Datum>>>.from(json["data"].map((x) =>
            Map.from(x).map((k, v) => MapEntry<String, List<Datum>>(
                k, List<Datum>.from(v.map((x) => Datum.fromJson(x))))))),
      );

  Map<String, dynamic> toJson() => {
        "filipinoRecipe": filipinoRecipe,
        "authorAPi": authorAPi,
        "data": List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) =>
            MapEntry<String, dynamic>(
                k, List<dynamic>.from(v.map((x) => x.toJson())))))),
      };

  @override
  String toString() =>
      'FilipinoRecipeModel(filipinoRecipe: $filipinoRecipe, authorAPi: $authorAPi, data: $data)';
}

class Datum {
  String categoryName;
  String categoryNameHref;
  String link;
  String linkRef;
  String recipeDescription;
  String recipeImageHref;
  String recipePrepTime;
  String recipeCookTime;
  String recipeTotalTIme;
  RecipeAuthor recipeAuthor;
  List<String> recipeIngredients;
  List<String> recipeInstruction;
  List<String> recipeNutrition;
  String recipeVote;

  Datum({
    required this.categoryName,
    required this.categoryNameHref,
    required this.link,
    required this.linkRef,
    required this.recipeDescription,
    required this.recipeImageHref,
    required this.recipePrepTime,
    required this.recipeCookTime,
    required this.recipeTotalTIme,
    required this.recipeAuthor,
    required this.recipeIngredients,
    required this.recipeInstruction,
    required this.recipeNutrition,
    required this.recipeVote,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        categoryName: json["categoryName"],
        categoryNameHref: json["categoryName-href"],
        link: json["link"],
        linkRef: json["link-ref"],
        recipeDescription: json["recipeDescription"],
        recipeImageHref: json["recipeImage-href"],
        recipePrepTime: json["recipePrepTime"],
        recipeCookTime: json["recipeCookTime"],
        recipeTotalTIme: json["recipeTotalTIme"],
        recipeAuthor: recipeAuthorValues.map[json["recipeAuthor"]]!,
        recipeIngredients:
            List<String>.from(json["recipeIngredients"].map((x) => x)),
        recipeInstruction:
            List<String>.from(json["recipeInstruction"].map((x) => x)),
        recipeNutrition:
            List<String>.from(json["recipeNutrition"].map((x) => x)),
        recipeVote: json["recipeVote"],
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "categoryName-href": categoryNameHref,
        "link": link,
        "link-ref": linkRef,
        "recipeDescription": recipeDescription,
        "recipeImage-href": recipeImageHref,
        "recipePrepTime": recipePrepTime,
        "recipeCookTime": recipeCookTime,
        "recipeTotalTIme": recipeTotalTIme,
        "recipeAuthor": recipeAuthorValues.reverse[recipeAuthor],
        "recipeIngredients":
            List<dynamic>.from(recipeIngredients.map((x) => x)),
        "recipeInstruction":
            List<dynamic>.from(recipeInstruction.map((x) => x)),
        "recipeNutrition": List<dynamic>.from(recipeNutrition.map((x) => x)),
        "recipeVote": recipeVote,
      };

  @override
  String toString() {
    return 'Datum(categoryName: $categoryName, categoryNameHref: $categoryNameHref, link: $link, linkRef: $linkRef, recipeDescription: $recipeDescription, recipeImageHref: $recipeImageHref, recipePrepTime: $recipePrepTime, recipeCookTime: $recipeCookTime, recipeTotalTIme: $recipeTotalTIme, recipeAuthor: $recipeAuthor, recipeIngredients: $recipeIngredients, recipeInstruction: $recipeInstruction, recipeNutrition: $recipeNutrition, recipeVote: $recipeVote)';
  }
}

enum RecipeAuthor { LALAINE_MANALO }

final recipeAuthorValues =
    EnumValues({"Lalaine Manalo": RecipeAuthor.LALAINE_MANALO});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }

  @override
  String toString() => 'EnumValues(map: $map, reverseMap: $reverseMap)';
}
