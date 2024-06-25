// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RecipeModel {
  String version;
  Recipe recipe;

  RecipeModel({
    required this.version,
    required this.recipe,
  });

  factory RecipeModel.fromRawJson(String str) =>
      RecipeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        version: json["version"],
        recipe: Recipe.fromJson(json["recipe"]),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "recipe": recipe.toJson(),
      };

  @override
  String toString() => 'RecipeModel(version: $version, recipe: $recipe)';
}

class Recipe {
  String id;
  Data data;

  Recipe({
    required this.id,
    required this.data,
  });

  factory Recipe.fromRawJson(String str) => Recipe.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": data.toJson(),
      };

  @override
  String toString() => 'Recipe(id: $id, data: $data)';
}

class Data {
  String name;
  String description;
  List<String> time;
  List<String> ingredients;
  List<String> directions;
  List<String> nutritions;
  String rating;
  String category;
  String cuisine;
  String servings;

  Data({
    required this.name,
    required this.description,
    required this.time,
    required this.ingredients,
    required this.directions,
    required this.nutritions,
    required this.rating,
    required this.category,
    required this.cuisine,
    required this.servings,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["Name"],
        description: json["Description"],
        time: List<String>.from(json["Time"].map((x) => x)),
        ingredients: List<String>.from(json["Ingredients"].map((x) => x)),
        directions: List<String>.from(json["Directions"].map((x) => x)),
        nutritions: List<String>.from(json["Nutritions"].map((x) => x)),
        rating: json["Rating"],
        category: json["Category"],
        cuisine: json["Cuisine"],
        servings: json["Servings"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Description": description,
        "Time": List<dynamic>.from(time.map((x) => x)),
        "Ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "Directions": List<dynamic>.from(directions.map((x) => x)),
        "Nutritions": List<dynamic>.from(nutritions.map((x) => x)),
        "Rating": rating,
        "Category": category,
        "Cuisine": cuisine,
        "Servings": servings,
      };

  @override
  String toString() {
    return 'Data(name: $name, description: $description, time: $time, ingredients: $ingredients, directions: $directions, nutritions: $nutritions, rating: $rating, category: $category, cuisine: $cuisine, servings: $servings)';
  }
}

// class RecipeModel {
//   final String version;
//   final String recipe;
//   final String id;
//   final String data;
//   RecipeModel({
//     required this.version,
//     required this.recipe,
//     required this.id,
//     required this.data,
//   });

//   factory RecipeModel.fromJson(dynamic json) {
//     return RecipeModel(
//       version: json['version'] as String,
//       recipe: json['recipe'] as String,
//       id: json['recipe']['id'] as String,
//       data: json['recipe']['data'] as String,
//     );
//   }

//   static List<RecipeModel> recipeFromSnapshot(List snapshot) {
//     return snapshot.map((data) {
//       return RecipeModel.fromJson(data);
//     }).toList();
//   }
// }











// {
//     "version": "v1.0",
//     "recipe": {
//         "id": "317",
//         "data": {
//             "Name": "Pork Adobo Recipe",
//             "Description": "Basic Filipino Prok Adobo with Soy Sauce, Vinegar, and Garlic. This delicious dish is perfect when served over newly cooked white rice.",
//             "Time": ["Prep: 10 minutes minutesCook: 1 hour hourTotal: 1 hour hour 10 minutes minutes", "Prep: 10 minutes minutes", "Cook: 1 hour hour", "Total: 1 hour hour 10 minutes minutes"],
//             "Ingredients": ["2 lbs pork belly", "2 tablespoons garlic", "5  dried bay leaves", "4 tablespoons vinegar", "1/2 cup soy sauce", "1 tablespoon peppercorn", "2 cups water", "  Salt to taste"],
//             "Directions": ["Combine the pork belly, soy sauce, and garlic then marinade for at least 1 hour", "Heat the pot and put-in the marinated pork belly then cook for a few minutes", "Pour remaining marinade including garlic.", "Add water, whole pepper corn, and dried bay leaves then bring to a boil. Simmer for 40 minutes to 1 hour", "Put-in the vinegar and simmer for 12 to 15 minutes", "Add salt to taste", "Serve hot. Share and enjoy!"],
//             "Nutritions": ["Serving: 4g", "Calories: 1211kcal (61%)", "Carbohydrates: 5g (2%)", "Protein: 24g (48%)", "Fat: 120g (185%)", "Saturated Fat: 43g (215%)", "Cholesterol: 163mg (54%)", "Sodium: 1700mg (71%)", "Potassium: 530mg (15%)", "Fiber: 1g (4%)", "Vitamin A: 115IU (2%)", "Vitamin C: 2.5mg (3%)", "Calcium: 50mg (5%)", "Iron: 2.7mg (15%)"],
//             "Rating": "",
//             "Category": "Pork",
//             "Cuisine": "filipino",
//             "Servings": "4"
//         }
//     }
// }
