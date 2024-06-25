// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:juan_recipe/model/recipeFilipinoModel.dart';
import 'package:juan_recipe/utils/global.colors.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

// https://www.youtube.com/watch?v=iZh9Tdhi6MA
// https://github.com/karimheiba/food-app/blob/master/lib/view/screen/product_item_screen.dart

class RecipeDetails extends StatefulWidget {
  const RecipeDetails({
    Key? key,
    required this.recipeId,
    required this.recipeCategory,
  }) : super(key: key);
  final int recipeId;
  final String recipeCategory;
  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  bool _isLoading = true;
  // RecipeModel? recipeFromAPI;
  FilipinoRecipeModel? recipeFilipinoFromAPI;

  late int recipeIndex;

  late String? recipeCategory;

  @override
  void initState() {
    super.initState();
    recipeIndex = widget.recipeId;
    recipeCategory = widget.recipeCategory;
    // fetchRecipeDetail();
    recipeFilipinoDetail();
  }

  @override
  // fetchRecipeDetail() async {
  //   try {
  //     var recipeId = widget.recipeId;
  //     // String uri =
  //     //     "https://all-in-one-recipe-api.p.rapidapi.com/details/${recipeId}";
  //     // http.Response res = await http.get(
  //     //   Uri.parse(uri),
  //     //   headers: {
  //     //     "X-Rapidapi-Key":
  //     //         "f958a976a8mshbe3858adf70320dp1e0f12jsnc8f5013814c9",
  //     //     "X-Rapidapi-Host": "all-in-one-recipe-api.p.rapidapi.com",
  //     //     "Host": "all-in-one-recipe-api.p.rapidapi.com"
  //     //   },
  //     // );
  //     String uri = "https://mocki.io/v1/66b4d8bb-ba33-448e-830a-a0a592c270af";
  //     http.Response res = await http.get(Uri.parse(uri));
  //     // print(res.statusCode);
  //     if (res.statusCode == 200) {
  //       // print(res.body);

  //       recipeFromAPI = RecipeModel.fromJson(json.decode(res.body));
  //       // recipeFromAPI = RecipeModel.fromJson(json.decode(res.body));
  //       // data = Data.fromJson(json.decode(res.body));
  //       _isLoading = false;
  //       // print(data);
  //       setState(() {});
  //     } else {}
  //   } catch (e) {
  //     print("this is error ${e}");
  //   }
  // }

  recipeFilipinoDetail() async {
    try {
      // String uri =
      //     "https://all-in-one-recipe-api.p.rapidapi.com/details/${recipeId}";
      // http.Response res = await http.get(
      //   Uri.parse(uri),
      //   headers: {
      //     "X-Rapidapi-Key":
      //         "f958a976a8mshbe3858adf70320dp1e0f12jsnc8f5013814c9",
      //     "X-Rapidapi-Host": "all-in-one-recipe-api.p.rapidapi.com",
      //     "Host": "all-in-one-recipe-api.p.rapidapi.com"
      //   },
      // );
      String uri = "https://mocki.io/v1/154078d1-51de-40fc-b039-d7690523e614";
      http.Response res = await http.get(Uri.parse(uri));
      // print(res.statusCode);
      if (res.statusCode == 200) {
        // print(res.body);
        recipeFilipinoFromAPI =
            FilipinoRecipeModel.fromJson(json.decode(res.body));
        // recipeFromAPI = RecipeModel.fromJson(json.decode(res.body));
        // data = Data.fromJson(json.decode(res.body));
        _isLoading = false;
        // print(data);
        setState(() {});
      } else {}
    } catch (e) {
      print("this is error ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        GLobalColors.orangeColor)),
              )
            : recipeFilipinoFromAPI == null
                ? Text("Failed to load data")
                : Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        // height: 40,
                        child: Image.network(
                            "${recipeFilipinoFromAPI?.data[0][recipeCategory]?[recipeIndex].recipeImageHref}"),
                      ),
                      buttonArrow(context),
                      scroll(),
                    ],
                  ),
      ),
    );
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          // Navigator.pop(context);
          Get.back();
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: BackdropFilter(
            // filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.amber,
              ),
            ),
          ),
        ),
      ),
    );
  }

  scroll() {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 35,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    // "${recipeFromAPI?.recipe.data.name.toString()}",
                    "${recipeFilipinoFromAPI?.data[0][recipeCategory]?[recipeIndex].link}",
                    style: TextStyle(
                        color: GLobalColors.blackColor,
                        fontFamily: 'DM sans',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    // style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          // "Food .60 min asd",
                          "${recipeFilipinoFromAPI?.data[0][recipeCategory]?[recipeIndex].recipeTotalTIme}",
                          // style: Theme.of(context)
                          //     .textTheme
                          //     .bodyText2!
                          //     .copyWith(color: SecondaryText),
                        ),
                      ),
                      Container(
                          child: SmoothStarRating(
                        rating: double.parse(
                            "${recipeFilipinoFromAPI?.data[0][recipeCategory]?[recipeIndex].recipeVote}"),
                        size: 18,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: false,
                        spacing: 2.0,
                        color: GLobalColors.orangeColor,
                        borderColor: GLobalColors.orangeColor,
                      ))
                    ],
                  ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // Row(
                  //   children: [
                  //     InkWell(
                  //       // onTap: () {
                  //       //   Navigator.push(
                  //       //       context,
                  //       //       MaterialPageRoute(
                  //       //         builder: (context) =>
                  //       //             ProfileTap(showFollowBottomInProfile: true),
                  //       //       ));
                  //       // },
                  //       child: const CircleAvatar(
                  //         radius: 25,
                  //         backgroundImage:
                  //             AssetImage("assets/images/burger.png"),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 5,
                  //     ),
                  //     Text(
                  //       "Elena Shelby",
                  //       // style: Theme.of(context)
                  //       //     .textTheme
                  //       //     .headline3!
                  //       //     .copyWith(color: mainText),
                  //     ),
                  //     const Spacer(),
                  //     const CircleAvatar(
                  //       radius: 25,
                  //       // backgroundColor: primary,
                  //       child: Icon(
                  //         IconlyLight.heart,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 5,
                  //     ),
                  //     Text(
                  //       "273 Likes",
                  //       // style: Theme.of(context)
                  //       //     .textTheme
                  //       //     .headline3!
                  //       //     .copyWith(color: mainText),
                  //     ),
                  //   ],
                  // ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text("Description",
                      style: TextStyle(
                          color: GLobalColors.blackColor,
                          fontFamily: 'DM sans',
                          fontSize: 18,
                          fontWeight: FontWeight.bold)
                      // style: Theme.of(context).textTheme.headline1,
                      ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Text("${recipeFromAPI?.recipe.data.description.toString()}"
                  Text(
                      "${recipeFilipinoFromAPI?.data[0][recipeCategory]?[recipeIndex].recipeDescription}"
                      // 'Your recipe has been uploaded, you can see it on your profile. Your recipe has been uploaded, you can see it on your',
                      // style: Theme.of(context)
                      //     .textTheme
                      //     .bodyText2!
                      //     .copyWith(color: SecondaryText),
                      ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text("Ingredients",
                      style: TextStyle(
                          color: GLobalColors.blackColor,
                          fontFamily: 'DM sans',
                          fontSize: 18,
                          fontWeight: FontWeight.bold)
                      // style: Theme.of(context).textTheme.headline1,
                      ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,

                    // itemCount: recipeFromAPI?.recipe.data.ingredients.length,
                    itemCount: recipeFilipinoFromAPI
                        ?.data[0][recipeCategory]?[recipeIndex]
                        .recipeIngredients
                        .length,
                    // itemCount: 30,
                    itemBuilder: (context, index) =>
                        ingredients(context, index),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text("Directions",
                      style: TextStyle(
                          color: GLobalColors.blackColor,
                          fontFamily: 'DM sans',
                          fontSize: 18,
                          fontWeight: FontWeight.bold)
                      // style: Theme.of(context).textTheme.headline1,
                      ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // itemCount: recipeFromAPI?.recipe.data.directions.length,
                    itemCount: recipeFilipinoFromAPI
                        ?.data[0][recipeCategory]?[recipeIndex]
                        .recipeInstruction
                        .length,
                    // itemBuilder: (context, index) => steps(context, index),
                    itemBuilder: (context, index) => directions(context, index),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ingredients(BuildContext context, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const CircleAvatar(
            foregroundColor: Colors.orange,
            radius: 10,
            backgroundColor: Color(0xFFE3FFF8),
            child: Icon(
              Icons.done,
              size: 15,
              // color: primary,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SizedBox(
              child: Text(
                // "${recipeFromAPI?.recipe.data.ingredients[index].toString()}",
                "${recipeFilipinoFromAPI?.data[0][recipeCategory]?[recipeIndex].recipeIngredients[index]}",
                // style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  directions(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            // backgroundColor: mainText,
            backgroundColor: GLobalColors.orangeColor,
            radius: 12,
            child: Text(
              "${index + 1}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Column(
            children: [
              SizedBox(
                width: 270,
                child: Text(
                    // "${recipeFromAPI?.recipe.data.directions[index].toString()}"
                    "${recipeFilipinoFromAPI?.data[0][recipeCategory]?[recipeIndex].recipeInstruction[index]}"
                    // "Your recipe has been uploaded, you can see it on your profile. Your recipe has been uploaded, you can see it on your",
                    // maxLines: 3,
                    // style: Theme.of(context)
                    //     .textTheme
                    //     .bodyText2!
                    //     .copyWith(color: mainText),
                    ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Image.asset(
              //   "assets/images/Food Picture.png",
              //   height: 155,
              //   width: 270,
              // )
            ],
          )
        ],
      ),
    );
  }
}
