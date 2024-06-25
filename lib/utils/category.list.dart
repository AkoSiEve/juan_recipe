import 'dart:ui';

class Categories {
  final String categoryName;
  final String imageUrl;

  Categories(this.categoryName, this.imageUrl);
}

final List<Categories> category = [
  Categories(
    "All",
    "assets/images/pork.png",
  ),
  Categories(
    "Pork",
    "assets/images/pork.png",
  ),
  Categories(
    "Chicken",
    "assets/images/chicken.png",
  ),
  Categories(
    "Sandwitch",
    "assets/images/burger.png",
  ),
  Categories(
    "Vegetable",
    "assets/images/vegetable.png",
  ),
];
