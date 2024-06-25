import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:juan_recipe/model/category.model.dart';
import 'package:juan_recipe/model/chicken.model.dart';
import 'package:juan_recipe/model/pork.model.dart';
import 'package:juan_recipe/model/recipeFilipinoModel.dart';
import 'package:juan_recipe/model/sandwich.model.dart';
import 'package:juan_recipe/model/vegetable.model.dart';
import 'package:juan_recipe/utils/global.colors.dart';
import 'package:juan_recipe/views/login.view.dart';
import 'package:juan_recipe/views/recipe.details.dart';
import 'package:juan_recipe/views/save.view.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class HomeView extends StatefulWidget {
  final token;
  const HomeView({super.key, required this.token});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late PageController _pageController;

  CategoryListModel? categoryFromAPI;
  CategoryPorkModel? categoryPorkFromAPI;

  String showCatActive = "Rice & Noodles";

  CategoryChickenModel? categoryChickenFromAPI;

  CategorySandwichModel? categorySandwichFromAPI;

  CategoryVegetableModel? categoryVegetableFromAPI;

  FilipinoRecipeModel? filipinoRecipeFromAPI;

  late final String firstName;
  @override
  void initState() {
    super.initState();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    print("this is home");
    print(jwtDecodedToken);
    // userId = jwtDecodedToken['id'];
    firstName = jwtDecodedToken['firstname'];
    // print(userId);

    filipinoRecipe();
    // fetchCategory();
    switch (showCatActive) {
      case "Rice & Noodles":
        // filipinoRecipe();
        break;
      case "Breads & Baked Goods":

        // fetchPork();
        break;
      case "Eggs & Dairy":
        //     fetchChiken();
        break;
      case "Beans & Legumes":
        //     fetchChiken();
        break;
      case "Fish & Seafood":
        //     fetchChiken();
        break;
      case "Soups & Salads":
        //     fetchChiken();
        break;
      case "Fruits & Vegetables":
        //     fetchChiken();
        break;
      case "Meat & Poultry":
        //     fetchChiken();
        break;

      default:
    }

    _pageController = PageController(viewportFraction: 0.30);
  }

  bool _isLoading = true;
  int _isSelectedCat = 0;

  filipinoRecipe() async {
    // String uri = "https://mocki.io/v1/a6fe59ce-98bc-4677-8ac3-852cb8f833b4";
    // String uri = "https://mocki.io/v1/bb9bd9fa-83b1-4642-bb28-febd43eecf2d";
    String uri = "https://mocki.io/v1/154078d1-51de-40fc-b039-d7690523e614";
    http.Response res = await http.get(Uri.parse(uri));
    // print(res.statusCode);
    try {
      if (res.statusCode == 200) {
        // print(res.body);

        filipinoRecipeFromAPI =
            FilipinoRecipeModel.fromJson(json.decode(res.body));
        // recipeFromAPI = RecipeModel.fromJson(json.decode(res.body));
        // data = Data.fromJson(json.decode(res.body));
        _isLoading = false;
        // print(data);
        setState(() {
          // showCatActive = "Pork";
        });
      } else {}
    } catch (e) {
      print("this is error ${e}");
    }
  }

  indexToCategoryHelper(int index) {
    switch (index) {
      case 0:
        return "Rice & Noodles";
      case 1:
        return "Breads & Baked Goods";
      case 2:
        return "Eggs & Dairy";
      case 3:
        return "Beans & Legumes";
      case 4:
        return "Fish & Seafood";
      case 5:
        return "Soups & Salads";
      case 6:
        return "Fruits & Vegetables";
      case 7:
        return "Meat & Poultry";
      default:
        return "qweqwe";
    }
  }

  var _selectedIndexBottom = 0;
  void _onItemTappedBottom(int index) {
    setState(() {
      _selectedIndexBottom = index;
      // _selectedIndexBottom = 0;
      print(_selectedIndexBottom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomSwitcherHelper(_selectedIndexBottom),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              // color: Colors.black.withOpacity(0.1),
              color: Colors.black.withOpacity(1),
              spreadRadius: 0,
              blurRadius: 3,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
                labelTextStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 12.0,
                // color: Colors.red,
                color: Colors.amber,
              ),
            )),
            child: NavigationBar(
              backgroundColor: Colors.white,
              selectedIndex: _selectedIndexBottom,
              onDestinationSelected: _onItemTappedBottom,
              // surfaceTintColor: Colors.red,
              // shadowColor: Colors.red,
              // backgroundColor: Colors.red,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,

              indicatorColor: Colors.transparent,

              destinations: [
                NavigationDestination(
                  selectedIcon: Icon(
                    // size: 30,
                    IconlyBold.home,
                    color: GLobalColors.orangeColor,
                  ),
                  icon: Icon(
                    IconlyLight.home,
                    color: GLobalColors.orangeColor,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  selectedIcon:
                      Icon(IconlyBold.bag, color: GLobalColors.orangeColor),
                  icon: Icon(
                    IconlyLight.bag,
                    color: GLobalColors.orangeColor,
                  ),
                  label: 'Save',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    IconlyBold.more_circle,
                    color: GLobalColors.orangeColor,
                  ),
                  icon: Icon(
                    IconlyLight.more_circle,
                    color: GLobalColors.orangeColor,
                  ),
                  label: 'Option',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final ScrollController autoScroll = ScrollController();
  // // This is what you're looking for!
  void autoScrollCat() {
    // _controller.animateTo(
    //   _controller.position.maxScrollExtent,
    //   duration: Duration(seconds: 2),
    //   curve: Curves.fastOutSlowIn,
    // );
    // _controller.jumpTo(_controller.position.maxScrollExtent);
    autoScroll.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  getSelectedCat(String showCatActive) {
    switch (showCatActive) {
      case "Rice & Noodles":
        return filipinoRecipeFromAPI == null
            ? Text("Failed to load data")
            : recipeFIlipinoRiceAndNoodlescategories(context);
      case "Breads & Baked Goods":
        return filipinoRecipeFromAPI == null
            ? Text("Failed to load data")
            : recipeFIlipinoBreadsAndBakedGoodscategories(context);
      case "Eggs & Dairy":
        return filipinoRecipeFromAPI == null
            ? Text("Failed to load data")
            : recipeFIlipinoEggsAndDairycategories(context);
      case "Beans & Legumes":
        return filipinoRecipeFromAPI == null
            ? Text("Failed to load data")
            : recipeFIlipinoBeansAndLegumescategories(context);
      case "Fish & Seafood":
        return filipinoRecipeFromAPI == null
            ? Text("Failed to load data")
            : recipeFIlipinoFishAndSeafoodcategories(context);
      case "Soups & Salads":
        return filipinoRecipeFromAPI == null
            ? Text("Failed to load data")
            : recipeFIlipinoSoupsAndSaladscategories(context);
      case "Fruits & Vegetables":
        return filipinoRecipeFromAPI == null
            ? Text("Failed to load data")
            : recipeFIlipinoFruitsAndVegetablescategories(context);
      case "Meat & Poultry":
        return filipinoRecipeFromAPI == null
            ? Text("Failed to load data")
            : recipeFIlipinoMeatAndPoultrycategories(context);
      // case 3: return "third";
      // default: return "${showCatActive}th"
    }
  }

  recipeFIlipinoRiceAndNoodlescategories(BuildContext context) {
    return Container(
      height: 407,
      width: double.infinity,
      // color: Colors.red,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: filipinoRecipeFromAPI
            ?.data[0]["Rice & Noodles"]?.length, // total number of items
        // itemCount: categoryFromAPI?.cuisines.data.length,
        controller: autoScroll, // total number of items
        itemBuilder: (context, index) {
          return FadedScaleAnimation(
            child: InkWell(
              onTap: () {
                print(index);
                print(filipinoRecipeFromAPI
                    ?.data[0]['Rice & Noodles']?[index].recipeVote);
                // print(filipinoRecipeFromAPI?.data[0]['Rice & Noodles']?[index].link);
                // print(filipinoRecipeFromAPI?.data[0].length);

                // Get.to(() => RegisterView())
                // Get.to(() => CategoryView(
                //       index: index,
                //     ));
                // Get.to(() => RecipeDetails(
                //       recipeId:
                //           (categoryFromAPI?.cuisines.data[index]?.id)! - 2,
                //     ));
                Get.to(() => RecipeDetails(
                      recipeId: index,
                      recipeCategory: 'Rice & Noodles',
                    ));
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, // color of grid items
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      )
                    ]),
                child: Column(
                  children: [
                    Container(
                      // color: Colors.yellow,
                      // height: 100,
                      // padding: EdgeInsets.only(left: 8),
                      // color: Colors.red,
                      // child: Image.asset("assets/images/bburger.png",
                      //     width: 100, height: 95, fit: BoxFit.fill),
                      child: Image.network(
                          "${filipinoRecipeFromAPI?.data[0]['Rice & Noodles']?[index].recipeImageHref}",
                          width: 100,
                          height: 95,
                          fit: BoxFit.fill),
                    ),
                    FittedBox(
                      child: Text(
                        // "Chicken Burger",
                        "${filipinoRecipeFromAPI?.data[0]['Rice & Noodles']?[index].link}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: GLobalColors.blackColor,
                            fontFamily: 'DM sans'),
                      ),
                    ),
                    Container(
                      child: SmoothStarRating(
                        rating: double.parse(
                            "${filipinoRecipeFromAPI?.data[0]['Rice & Noodles']?[index].recipeVote}"),
                        size: 18,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: false,
                        spacing: 2.0,
                        color: GLobalColors.orangeColor,
                        borderColor: GLobalColors.orangeColor,
                      ),
                      // child: Text(
                      //   "200 gr chicken + cheese  Lettuce + tomato",
                      //   // "200 ",
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     color: GLobalColors.blackColor,
                      //   ),
                      // ),
                    ),
                    Container(
                      width: double.infinity,
                      // color: Colors.pink,
                      child: Row(
                        children: [
                          Container(
                            // color: Colors.blue,
                            width: 133,
                            child: Row(
                              children: [
                                Text(
                                  "Prep : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "DM sans"),
                                ),
                                Text(
                                  "${filipinoRecipeFromAPI?.data[0]['Rice & Noodles']?[index].recipePrepTime.substring(10, 21)}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: SizedBox(width: 100)),
                          Icon(
                            Ionicons.heart_outline,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  recipeFIlipinoBreadsAndBakedGoodscategories(BuildContext context) {
    return Container(
      height: 407,
      width: double.infinity,
      // color: Colors.red,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: filipinoRecipeFromAPI
            ?.data[0]["Breads & Baked Goods"]?.length, // total number of items
        // itemCount: categoryFromAPI?.cuisines.data.length,
        controller: autoScroll, // total number of items
        itemBuilder: (context, index) {
          return FadedScaleAnimation(
            child: InkWell(
              onTap: () {
                print(index);
                // print(filipinoRecipeFromAPI?.data[0]['Rice & Noodles']?[index].link);
                // print(filipinoRecipeFromAPI?.data[0].length);

                // Get.to(() => RegisterView())
                // Get.to(() => CategoryView(
                //       index: index,
                //     ));
                // Get.to(() => RecipeDetails(
                //       recipeId:
                //           (categoryFromAPI?.cuisines.data[index]?.id)! - 2,
                //     ));
                Get.to(() => RecipeDetails(
                      recipeId: index,
                      recipeCategory: 'Breads & Baked Goods',
                    ));
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, // color of grid items
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      )
                    ]),
                child: Column(
                  children: [
                    Container(
                      // color: Colors.yellow,
                      // height: 100,
                      // padding: EdgeInsets.only(left: 8),
                      // color: Colors.red,
                      // child: Image.asset("assets/images/bburger.png",
                      //     width: 100, height: 95, fit: BoxFit.fill),
                      child: Image.network(
                          "${filipinoRecipeFromAPI?.data[0]['Breads & Baked Goods']?[index].recipeImageHref}",
                          width: 100,
                          height: 95,
                          fit: BoxFit.fill),
                    ),
                    FittedBox(
                      child: Text(
                        // "Chicken Burger",
                        "${filipinoRecipeFromAPI?.data[0]['Breads & Baked Goods']?[index].link}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: GLobalColors.blackColor,
                            fontFamily: 'DM sans'),
                      ),
                    ),
                    Container(
                      child: SmoothStarRating(
                        rating: double.parse(
                            "${filipinoRecipeFromAPI?.data[0]['Breads & Baked Goods']?[index].recipeVote}"),
                        size: 18,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: false,
                        spacing: 2.0,
                        color: GLobalColors.orangeColor,
                        borderColor: GLobalColors.orangeColor,
                      ),
                      // child: Text(
                      //   "200 gr chicken + cheese  Lettuce + tomato",
                      //   // "200 ",
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     color: GLobalColors.blackColor,
                      //   ),
                      // ),
                    ),
                    Container(
                      width: double.infinity,
                      // color: Colors.pink,
                      child: Row(
                        children: [
                          Container(
                            // color: Colors.blue,
                            width: 133,
                            child: Row(
                              children: [
                                Text(
                                  "Prep : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "DM sans"),
                                ),
                                Text(
                                  "${filipinoRecipeFromAPI?.data[0]['Breads & Baked Goods']?[index].recipePrepTime.substring(10, 20)}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: SizedBox(width: 100)),
                          Icon(
                            Ionicons.heart_outline,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  recipeFIlipinoEggsAndDairycategories(BuildContext context) {
    return Container(
      height: 407,
      width: double.infinity,
      // color: Colors.red,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: filipinoRecipeFromAPI
            ?.data[0]["Eggs & Dairy"]?.length, // total number of items
        // itemCount: categoryFromAPI?.cuisines.data.length,
        controller: autoScroll, // total number of items
        itemBuilder: (context, index) {
          return FadedScaleAnimation(
            child: InkWell(
              onTap: () {
                print(index);
                // print(filipinoRecipeFromAPI?.data[0]['Rice & Noodles']?[index].link);
                // print(filipinoRecipeFromAPI?.data[0].length);

                // Get.to(() => RegisterView())
                // Get.to(() => CategoryView(
                //       index: index,
                //     ));
                // Get.to(() => RecipeDetails(
                //       recipeId:
                //           (categoryFromAPI?.cuisines.data[index]?.id)! - 2,
                //     ));
                Get.to(() => RecipeDetails(
                      recipeId: index,
                      recipeCategory: 'Eggs & Dairy',
                    ));
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, // color of grid items
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      )
                    ]),
                child: Column(
                  children: [
                    Container(
                      // color: Colors.yellow,
                      // height: 100,
                      // padding: EdgeInsets.only(left: 8),
                      // color: Colors.red,
                      // child: Image.asset("assets/images/bburger.png",
                      //     width: 100, height: 95, fit: BoxFit.fill),
                      child: Image.network(
                          "${filipinoRecipeFromAPI?.data[0]['Eggs & Dairy']?[index].recipeImageHref}",
                          width: 100,
                          height: 95,
                          fit: BoxFit.fill),
                    ),
                    FittedBox(
                      child: Text(
                        // "Chicken Burger",
                        "${filipinoRecipeFromAPI?.data[0]['Eggs & Dairy']?[index].link}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: GLobalColors.blackColor,
                            fontFamily: 'DM sans'),
                      ),
                    ),
                    Container(
                      child: SmoothStarRating(
                        rating: double.parse(
                            "${filipinoRecipeFromAPI?.data[0]['Eggs & Dairy']?[index].recipeVote}"),
                        size: 18,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: false,
                        spacing: 2.0,
                        color: GLobalColors.orangeColor,
                        borderColor: GLobalColors.orangeColor,
                      ),
                      // child: Text(
                      //   "200 gr chicken + cheese  Lettuce + tomato",
                      //   // "200 ",
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     color: GLobalColors.blackColor,
                      //   ),
                      // ),
                    ),
                    Container(
                      width: double.infinity,
                      // color: Colors.pink,
                      child: Row(
                        children: [
                          Container(
                            // color: Colors.blue,
                            width: 133,
                            child: Row(
                              children: [
                                Text(
                                  "Prep : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "DM sans"),
                                ),
                                Text(
                                  "${filipinoRecipeFromAPI?.data[0]['Eggs & Dairy']?[index].recipePrepTime.substring(10, 20)}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: SizedBox(width: 100)),
                          Icon(
                            Ionicons.heart_outline,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  recipeFIlipinoBeansAndLegumescategories(BuildContext context) {
    return Container(
      height: 407,
      width: double.infinity,
      // color: Colors.red,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: filipinoRecipeFromAPI
            ?.data[0]["Beans & Legumes"]?.length, // total number of items
        // itemCount: categoryFromAPI?.cuisines.data.length,
        controller: autoScroll, // total number of items
        itemBuilder: (context, index) {
          return FadedScaleAnimation(
            child: InkWell(
              onTap: () {
                print(index);
                // print(filipinoRecipeFromAPI?.data[0]['Rice & Noodles']?[index].link);
                // print(filipinoRecipeFromAPI?.data[0].length);

                // Get.to(() => RegisterView())
                // Get.to(() => CategoryView(
                //       index: index,
                //     ));
                // Get.to(() => RecipeDetails(
                //       recipeId:
                //           (categoryFromAPI?.cuisines.data[index]?.id)! - 2,
                //     ));
                Get.to(() => RecipeDetails(
                      recipeId: index,
                      recipeCategory: 'Beans & Legumes',
                    ));
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, // color of grid items
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      )
                    ]),
                child: Column(
                  children: [
                    Container(
                      // color: Colors.yellow,
                      // height: 100,
                      // padding: EdgeInsets.only(left: 8),
                      // color: Colors.red,
                      // child: Image.asset("assets/images/bburger.png",
                      //     width: 100, height: 95, fit: BoxFit.fill),
                      child: Image.network(
                          "${filipinoRecipeFromAPI?.data[0]['Beans & Legumes']?[index].recipeImageHref}",
                          width: 100,
                          height: 95,
                          fit: BoxFit.fill),
                    ),
                    FittedBox(
                      child: Text(
                        // "Chicken Burger",
                        "${filipinoRecipeFromAPI?.data[0]['Beans & Legumes']?[index].link}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: GLobalColors.blackColor,
                            fontFamily: 'DM sans'),
                      ),
                    ),
                    Container(
                      child: SmoothStarRating(
                        rating: double.parse(
                            "${filipinoRecipeFromAPI?.data[0]['Beans & Legumes']?[index].recipeVote}"),
                        size: 18,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: false,
                        spacing: 2.0,
                        color: GLobalColors.orangeColor,
                        borderColor: GLobalColors.orangeColor,
                      ),
                      // child: Text(
                      //   "200 gr chicken + cheese  Lettuce + tomato",
                      //   // "200 ",
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     color: GLobalColors.blackColor,
                      //   ),
                      // ),
                    ),
                    Container(
                      width: double.infinity,
                      // color: Colors.pink,
                      child: Row(
                        children: [
                          Container(
                            // color: Colors.blue,
                            width: 133,
                            child: Row(
                              children: [
                                Text(
                                  "Prep : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "DM sans"),
                                ),
                                Text(
                                  "${filipinoRecipeFromAPI?.data[0]['Beans & Legumes']?[index].recipePrepTime.substring(10, 20)}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: SizedBox(width: 100)),
                          Icon(
                            Ionicons.heart_outline,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  recipeFIlipinoFishAndSeafoodcategories(BuildContext context) {
    return Container(
      height: 407,
      width: double.infinity,
      // color: Colors.red,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: filipinoRecipeFromAPI
            ?.data[0]["Fish & Seafood"]?.length, // total number of items
        // itemCount: categoryFromAPI?.cuisines.data.length,
        controller: autoScroll, // total number of items
        itemBuilder: (context, index) {
          return FadedScaleAnimation(
            child: InkWell(
              onTap: () {
                print(index);
                // print(filipinoRecipeFromAPI?.data[0]['Rice & Noodles']?[index].link);
                // print(filipinoRecipeFromAPI?.data[0].length);

                // Get.to(() => RegisterView())
                // Get.to(() => CategoryView(
                //       index: index,
                //     ));
                // Get.to(() => RecipeDetails(
                //       recipeId:
                //           (categoryFromAPI?.cuisines.data[index]?.id)! - 2,
                //     ));
                Get.to(() => RecipeDetails(
                      recipeId: index,
                      recipeCategory: 'Fish & Seafood',
                    ));
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, // color of grid items
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      )
                    ]),
                child: Column(
                  children: [
                    Container(
                      // color: Colors.yellow,
                      // height: 100,
                      // padding: EdgeInsets.only(left: 8),
                      // color: Colors.red,
                      // child: Image.asset("assets/images/bburger.png",
                      //     width: 100, height: 95, fit: BoxFit.fill),
                      child: Image.network(
                          "${filipinoRecipeFromAPI?.data[0]['Fish & Seafood']?[index].recipeImageHref}",
                          width: 100,
                          height: 95,
                          fit: BoxFit.fill),
                    ),
                    FittedBox(
                      child: Text(
                        // "Chicken Burger",
                        "${filipinoRecipeFromAPI?.data[0]['Fish & Seafood']?[index].link}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: GLobalColors.blackColor,
                            fontFamily: 'DM sans'),
                      ),
                    ),
                    Container(
                      child: SmoothStarRating(
                        rating: double.parse(
                            "${filipinoRecipeFromAPI?.data[0]['Fish & Seafood']?[index].recipeVote}"),
                        size: 18,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: false,
                        spacing: 2.0,
                        color: GLobalColors.orangeColor,
                        borderColor: GLobalColors.orangeColor,
                      ),
                      // child: Text(
                      //   "200 gr chicken + cheese  Lettuce + tomato",
                      //   // "200 ",
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     color: GLobalColors.blackColor,
                      //   ),
                      // ),
                    ),
                    Container(
                      width: double.infinity,
                      // color: Colors.pink,
                      child: Row(
                        children: [
                          Container(
                            // color: Colors.blue,
                            width: 133,
                            child: Row(
                              children: [
                                Text(
                                  "Prep : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "DM sans"),
                                ),
                                Text(
                                  "${filipinoRecipeFromAPI?.data[0]['Fish & Seafood']?[index].recipePrepTime.substring(10, 20)}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: SizedBox(width: 100)),
                          Icon(
                            Ionicons.heart_outline,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  recipeFIlipinoSoupsAndSaladscategories(BuildContext context) {
    return Container(
      height: 407,
      width: double.infinity,
      // color: Colors.red,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: filipinoRecipeFromAPI
            ?.data[0]["Soups & Salads"]?.length, // total number of items
        // itemCount: categoryFromAPI?.cuisines.data.length,
        controller: autoScroll, // total number of items
        itemBuilder: (context, index) {
          return FadedScaleAnimation(
            child: InkWell(
              onTap: () {
                print(index);
                // print(filipinoRecipeFromAPI?.data[0]['Rice & Noodles']?[index].link);
                // print(filipinoRecipeFromAPI?.data[0].length);

                // Get.to(() => RegisterView())
                // Get.to(() => CategoryView(
                //       index: index,
                //     ));
                // Get.to(() => RecipeDetails(
                //       recipeId:
                //           (categoryFromAPI?.cuisines.data[index]?.id)! - 2,
                //     ));
                Get.to(() => RecipeDetails(
                      recipeId: index,
                      recipeCategory: 'Soups & Salads',
                    ));
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, // color of grid items
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      )
                    ]),
                child: Column(
                  children: [
                    Container(
                      // color: Colors.yellow,
                      // height: 100,
                      // padding: EdgeInsets.only(left: 8),
                      // color: Colors.red,
                      // child: Image.asset("assets/images/bburger.png",
                      //     width: 100, height: 95, fit: BoxFit.fill),
                      child: Image.network(
                          "${filipinoRecipeFromAPI?.data[0]['Soups & Salads']?[index].recipeImageHref}",
                          width: 100,
                          height: 95,
                          fit: BoxFit.fill),
                    ),
                    FittedBox(
                      child: Text(
                        // "Chicken Burger",
                        "${filipinoRecipeFromAPI?.data[0]['Soups & Salads']?[index].link}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: GLobalColors.blackColor,
                            fontFamily: 'DM sans'),
                      ),
                    ),
                    Container(
                      child: SmoothStarRating(
                        rating: double.parse(
                            "${filipinoRecipeFromAPI?.data[0]['Soups & Salads']?[index].recipeVote}"),
                        size: 18,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: false,
                        spacing: 2.0,
                        color: GLobalColors.orangeColor,
                        borderColor: GLobalColors.orangeColor,
                      ),
                      // child: Text(
                      //   "200 gr chicken + cheese  Lettuce + tomato",
                      //   // "200 ",
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     color: GLobalColors.blackColor,
                      //   ),
                      // ),
                    ),
                    Container(
                      width: double.infinity,
                      // color: Colors.pink,
                      child: Row(
                        children: [
                          Container(
                            // color: Colors.blue,
                            width: 133,
                            child: Row(
                              children: [
                                Text(
                                  "Prep : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "DM sans"),
                                ),
                                Text(
                                  "${filipinoRecipeFromAPI?.data[0]['Soups & Salads']?[index].recipePrepTime.substring(10, 20)}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: SizedBox(width: 100)),
                          Icon(
                            Ionicons.heart_outline,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  recipeFIlipinoFruitsAndVegetablescategories(BuildContext context) {
    return Container(
      height: 407,
      width: double.infinity,
      // color: Colors.red,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: filipinoRecipeFromAPI
            ?.data[0]["Fruits & Vegetables"]?.length, // total number of items
        // itemCount: categoryFromAPI?.cuisines.data.length,
        controller: autoScroll, // total number of items
        itemBuilder: (context, index) {
          return FadedScaleAnimation(
            child: InkWell(
              onTap: () {
                print(index);
                // print(filipinoRecipeFromAPI?.data[0]['Rice & Noodles']?[index].link);
                // print(filipinoRecipeFromAPI?.data[0].length);

                // Get.to(() => RegisterView())
                // Get.to(() => CategoryView(
                //       index: index,
                //     ));
                // Get.to(() => RecipeDetails(
                //       recipeId:
                //           (categoryFromAPI?.cuisines.data[index]?.id)! - 2,
                //     ));
                Get.to(() => RecipeDetails(
                      recipeId: index,
                      recipeCategory: 'Fruits & Vegetables',
                    ));
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, // color of grid items
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      )
                    ]),
                child: Column(
                  children: [
                    Container(
                      // color: Colors.yellow,
                      // height: 100,
                      // padding: EdgeInsets.only(left: 8),
                      // color: Colors.red,
                      // child: Image.asset("assets/images/bburger.png",
                      //     width: 100, height: 95, fit: BoxFit.fill),
                      child: Image.network(
                          "${filipinoRecipeFromAPI?.data[0]['Fruits & Vegetables']?[index].recipeImageHref}",
                          width: 100,
                          height: 95,
                          fit: BoxFit.fill),
                    ),
                    FittedBox(
                      child: Text(
                        // "Chicken Burger",
                        "${filipinoRecipeFromAPI?.data[0]['Fruits & Vegetables']?[index].link}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: GLobalColors.blackColor,
                            fontFamily: 'DM sans'),
                      ),
                    ),
                    Container(
                      child: SmoothStarRating(
                        rating: double.parse(
                            "${filipinoRecipeFromAPI?.data[0]['Fruits & Vegetables']?[index].recipeVote}"),
                        size: 18,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: false,
                        spacing: 2.0,
                        color: GLobalColors.orangeColor,
                        borderColor: GLobalColors.orangeColor,
                      ),
                      // child: Text(
                      //   "200 gr chicken + cheese  Lettuce + tomato",
                      //   // "200 ",
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     color: GLobalColors.blackColor,
                      //   ),
                      // ),
                    ),
                    Container(
                      width: double.infinity,
                      // color: Colors.pink,
                      child: Row(
                        children: [
                          Container(
                            // color: Colors.blue,
                            width: 133,
                            child: Row(
                              children: [
                                Text(
                                  "Prep : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "DM sans"),
                                ),
                                Text(
                                  "${filipinoRecipeFromAPI?.data[0]['Fruits & Vegetables']?[index].recipePrepTime.substring(10, 20)}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: SizedBox(width: 100)),
                          Icon(
                            Ionicons.heart_outline,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  recipeFIlipinoMeatAndPoultrycategories(BuildContext context) {
    return Container(
      height: 407,
      width: double.infinity,
      // color: Colors.red,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: filipinoRecipeFromAPI
            ?.data[0]["Meat & Poultry"]?.length, // total number of items
        // itemCount: categoryFromAPI?.cuisines.data.length,
        controller: autoScroll, // total number of items
        itemBuilder: (context, index) {
          return FadedScaleAnimation(
            child: InkWell(
              onTap: () {
                print(index);
                // print(filipinoRecipeFromAPI?.data[0]['Rice & Noodles']?[index].link);
                // print(filipinoRecipeFromAPI?.data[0].length);

                // Get.to(() => RegisterView())
                // Get.to(() => CategoryView(
                //       index: index,
                //     ));
                // Get.to(() => RecipeDetails(
                //       recipeId:
                //           (categoryFromAPI?.cuisines.data[index]?.id)! - 2,
                //     ));
                Get.to(() => RecipeDetails(
                      recipeId: index,
                      recipeCategory: 'Meat & Poultry',
                    ));
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, // color of grid items
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      )
                    ]),
                child: Column(
                  children: [
                    Container(
                      // color: Colors.yellow,
                      // height: 100,
                      // padding: EdgeInsets.only(left: 8),
                      // color: Colors.red,
                      // child: Image.asset("assets/images/bburger.png",
                      //     width: 100, height: 95, fit: BoxFit.fill),
                      child: Image.network(
                          "${filipinoRecipeFromAPI?.data[0]['Meat & Poultry']?[index].recipeImageHref}",
                          width: 100,
                          height: 95,
                          fit: BoxFit.fill),
                    ),
                    FittedBox(
                      child: Text(
                        // "Chicken Burger",
                        "${filipinoRecipeFromAPI?.data[0]['Meat & Poultry']?[index].link}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: GLobalColors.blackColor,
                            fontFamily: 'DM sans'),
                      ),
                    ),
                    Container(
                      child: SmoothStarRating(
                        rating: double.parse(
                            "${filipinoRecipeFromAPI?.data[0]['Meat & Poultry']?[index].recipeVote}"),
                        size: 18,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: false,
                        spacing: 2.0,
                        color: GLobalColors.orangeColor,
                        borderColor: GLobalColors.orangeColor,
                      ),
                      // child: Text(
                      //   "200 gr chicken + cheese  Lettuce + tomato",
                      //   // "200 ",
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     color: GLobalColors.blackColor,
                      //   ),
                      // ),
                    ),
                    Container(
                      width: double.infinity,
                      // color: Colors.pink,
                      child: Row(
                        children: [
                          Container(
                            // color: Colors.blue,
                            width: 133,
                            child: Row(
                              children: [
                                Text(
                                  "Prep : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "DM sans"),
                                ),
                                Text(
                                  "${filipinoRecipeFromAPI?.data[0]['Meat & Poultry']?[index].recipePrepTime.substring(10, 20)}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: SizedBox(width: 100)),
                          Icon(
                            Ionicons.heart_outline,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  HomeScreen() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: Colors.red,
              width: double.infinity,
              height: 290,
              child: Column(
                children: [
                  Container(
                    // color: Colors.green,
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    height: 200,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text("Good Day!, Juan"),
                              Container(
                                height: 60,
                                // color: Colors.cyan,
                                child: Row(
                                  children: [
                                    Text(
                                      "Kamusta! ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: GLobalColors.blackColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    AnimatedTextKit(
                                      // repeatForever: true,
                                      animatedTexts: [
                                        TyperAnimatedText(
                                            speed: Duration(milliseconds: 300),
                                            // 'Jerome',
                                            "${firstName}",
                                            textStyle: TextStyle(
                                                fontSize: 18,
                                                color: GLobalColors.orangeColor,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 252,
                                  // color: Colors.red,
                                  child: Text(
                                    // "Find Your Own \nFilipino Food",
                                    "Halina't Kumain \nSa Luto ni Juan",
                                    style: TextStyle(
                                        color: GLobalColors.blackColor,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(3.0, 3.0),
                                            // blurRadius: 1.0,
                                            color: Colors.black12,
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Text("icon nofif"),
                        // Icon(
                        //   Icons.favorite,
                        //   color: Colors.pink,
                        //   size: 24.0,
                        // )
                        Image.network(
                          'https://i.pinimg.com/564x/ea/05/48/ea05484227d5789931972408ca585771.jpg',
                          // color: Colors.red,
                          height: 135,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    // color: Colors.red,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              // print(value);
                              // searchCat(value);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Ionicons.search,
                                color: GLobalColors.blackColor,
                                size: 25,
                              ),
                              prefixIconColor: Colors.black87,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: GLobalColors.orangeColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: GLobalColors.greyColor),
                              ),
                              hintText: 'Search ',
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                              // color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: GLobalColors.orangeColor)),
                          child: Icon(
                            // Ionicons.options_outline,
                            IconlyLight.filter,
                            color: GLobalColors.orangeColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // color: Colors.blue,
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                        color: GLobalColors.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  // CATEGORY SELECTION
                  Container(
                    height: 40,
                    child: ListView.builder(
                      shrinkWrap: true,
                      // itemCount: category.length,
                      itemCount: filipinoRecipeFromAPI?.data[0].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            InkWell(
                              onTap: () {
                                print("cat cat ${index}");
                                switch (index) {
                                  case 0:
                                    // showCatActive = category[index].categoryName;
                                    showCatActive = "Rice & Noodles";
                                    _isSelectedCat = index;
                                    filipinoRecipe();
                                    autoScrollCat();
                                    break;
                                  case 1:
                                    showCatActive = "Breads & Baked Goods";
                                    _isSelectedCat = index;
                                    filipinoRecipe();
                                    autoScrollCat();
                                    break;
                                  case 2:
                                    showCatActive = "Eggs & Dairy";
                                    _isSelectedCat = index;
                                    filipinoRecipe();
                                    autoScrollCat();
                                    break;
                                  case 3:
                                    showCatActive = "Beans & Legumes";
                                    _isSelectedCat = index;
                                    filipinoRecipe();
                                    autoScrollCat();
                                    break;
                                  case 4:
                                    showCatActive = "Fish & Seafood";
                                    _isSelectedCat = index;
                                    filipinoRecipe();
                                    autoScrollCat();
                                    break;
                                  case 5:
                                    showCatActive = "Soups & Salads";
                                    _isSelectedCat = index;
                                    filipinoRecipe();
                                    autoScrollCat();
                                    break;
                                  case 6:
                                    showCatActive = "Fruits & Vegetables";
                                    _isSelectedCat = index;
                                    filipinoRecipe();
                                    autoScrollCat();
                                    break;
                                  case 7:
                                    showCatActive = "Meat & Poultry";
                                    _isSelectedCat = index;
                                    filipinoRecipe();
                                    autoScrollCat();
                                    break;
                                  //   case 3:
                                  //     showCatActive = "Sandwich";
                                  //     fetchSandwich();
                                  //     autoScrollCat();
                                  //   case 4:
                                  //     showCatActive = "Vegetable";
                                  //     fetchVegetable();
                                  //     autoScrollCat();
                                  //     break;
                                  //   // default:
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 123,
                                // padding: EdgeInsets.symmetric(horizontal: 30),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color: GLobalColors.orangeColor,
                                    color: _isSelectedCat == index
                                        ? GLobalColors.orangeColor
                                        : Colors.white,
                                    border: Border.all(
                                        color: GLobalColors.orangeColor)),
                                child: Row(
                                  children: [
                                    // Container(
                                    //   padding: EdgeInsets.only(left: 8),
                                    //   // color: Colors.red,
                                    //   child: Image.asset(
                                    //       category[index].imageUrl),
                                    // ),
                                    // SizedBox(width: 16),
                                    SizedBox(width: 1),
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10),
                                        // alignment: Alignment.,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: AutoSizeText(
                                            // category[index].categoryName,
                                            // "qweqwe",
                                            "${filipinoRecipeFromAPI?.data[0][indexToCategoryHelper(index)]?[0].categoryName}",
                                            style: TextStyle(
                                              color: _isSelectedCat == index
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            // categories(context),
            // _isLoading
            //     ? Center(
            //         child: CircularProgressIndicator(
            //             valueColor: AlwaysStoppedAnimation<Color>(
            //                 GLobalColors.orangeColor)))
            //     : categoryFromAPI == null
            //         ? Text("Failed to load data")
            //         : showCatActive == "All"
            //             ? categories(context)
            //             : categoriesPork(context),
            // _isLoading
            //     ? Center(
            //         child: CircularProgressIndicator(
            //             valueColor: AlwaysStoppedAnimation<Color>(
            //                 GLobalColors.orangeColor)))
            //     : getSelectedCat(showCatActive),
            // categories(context),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            GLobalColors.orangeColor)))
                : getSelectedCat(showCatActive)
          ],
        ),
      ),
    );
  }

  SaveScrenn() {
    return SaveView();
  }

  OptionScreen() {
    return Center(
        child: InkWell(
      onTap: () {
        logOut();
      },
      child: Text("option"),
    ));
  }

  bottomSwitcherHelper(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return SaveScrenn();
      case 2:
        return OptionScreen();
    }
  }

  logOut() async {
    print("logout me");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    print("token already remove me");
    Get.to(LoginView());
  }
}
