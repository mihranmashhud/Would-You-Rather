import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wouldyourather/Models/versus_model.dart';
import 'package:http/http.dart';
import 'dart:convert';

class PromptForQuery extends StatefulWidget {
  const PromptForQuery({Key? key}) : super(key: key);

  @override
  State<PromptForQuery> createState() => _PromptForQueryState();
}

class _PromptForQueryState extends State<PromptForQuery> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final cuisineController = TextEditingController();
  // final mealController = TextEditingController();
  String? _cuisine = "Anything";
  String? _meal = "dinner";

  final List<String> _cuisines = [
    "Anything",
    "African",
    "American",
    "British",
    "Cajun",
    "Caribbean",
    "Chinese",
    "Eastern European",
    "European",
    "French",
    "German",
    "Greek",
    "Indian",
    "Irish",
    "Italian",
    "Japanese",
    "Jewish",
    "Korean",
    "Latin American",
    "Mediterranean",
    "Mexican",
    "Middle Eastern",
    "Nordic",
    "Southern",
    "Spanish",
    "Thai",
    "Vietnamese",
  ];

  final List<String> _meals = [
    "breakfast",
    "lunch",
    "dinner",
  ];

  final double _fontSize = 30;

  // Future<List<Map<String, dynamic>>> getRecipeList(
  //     String cuisine, String meal) async {
  //   Response jsonReponse = await get('');
  //   List<Map<String, dynamic>> response = jsonDecode(jsonReponse.body);
  //   return response;
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Consumer<VersusModel>(
            builder: (context, model, child) => Container(
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("I want ",
                              style: TextStyle(fontSize: _fontSize)),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _cuisine,
                              icon: const Icon(Icons.expand_more),
                              iconSize: 16,
                              onChanged: (String? newValue) {
                                setState(() => {_cuisine = newValue});
                              },
                              items: _cuisines
                                  .map<DropdownMenuItem<String>>((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val,
                                      style: TextStyle(fontSize: _fontSize)),
                                );
                              }).toList(),
                            ),
                          ),
                        ]),
                    const SizedBox(height: 10),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("for ", style: TextStyle(fontSize: _fontSize)),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _meal,
                              icon: const Icon(Icons.expand_more),
                              iconSize: 16,
                              onChanged: (String? newValue) {
                                setState(() => {_meal = newValue});
                              },
                              items: _meals
                                  .map<DropdownMenuItem<String>>((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val,
                                      style: TextStyle(fontSize: _fontSize)),
                                );
                              }).toList(),
                            ),
                          ),
                        ]),
                    const SizedBox(height: 10),
                    Center(
                      child: FloatingActionButton(
                        backgroundColor: Colors.green,
                        // TODO: Turn back into async
                        onPressed: () {
                          // TODO: Add backend api url
                          // final uri = Uri.https('https://foodwisewebapp.azurewebsites.net/', )
                          // Response jsonReponse = await get('https://foodwisewebapp.azurewebsites.net/',body:'');
                          // List<Map<String, dynamic>> response =
                          //     jsonDecode(jsonReponse.body);
                          List<Map<String, dynamic>> response = [
                            {
                              "recipeName": "Tomato Soup",
                              "nutritionScore": "84%",
                              "image":
                                  "https://littlespoonfarm.com/wp-content/uploads/2021/01/homemade-tomato-soup-recipe.jpg",
                              "price": "7",
                              "cookTime": "65 mins",
                              "sourceURL":
                                  "https://littlespoonfarm.com/homemade-tomato-soup-recipe/"
                            },
                            {
                              "recipeName": "Butterscotch Pie",
                              "nutritionScore": "25%",
                              "image":
                                  "https://www.chowhound.com/a/img/resize/8e57209554415076042c31043c6f15d70b692077/2013/11/10733_RecipeImage_620x413_brown_butterscotch_pie.jpg?fit=bounds&width=800",
                              "price": "13",
                              "cookTime": "53 mins",
                              "sourceURL":
                                  "https://www.chowhound.com/recipes/brown-butterscotch-pie-10733"
                            },
                            {
                              "recipeName": "Hawaiian Pizza",
                              "nutritionScore": "59%",
                              "image":
                                  "https://cdn.vox-cdn.com/thumbor/EfQjxLoSgcjB_LnyX2OqM2UHD6w=/0x0:2000x1333/920x613/filters:focal(840x507:1160x827):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/55188531/hawaiian_pizza_sh.0.jpg",
                              "price": "21",
                              "cookTime": "40 mins"
                            },
                            {
                              "recipeName": "Alfredo Pasta",
                              "nutritionScore": "76%",
                              "image":
                                  "https://www.tasteandtellblog.com/wp-content/uploads/2020/01/Alfredo-Pasta-Bacon-tasteandtellblog.com-1-768x512.jpg",
                              "price": "7",
                              "cookTime": "34 mins"
                            },
                          ];
                          model.jsonResponse = response;
                          print(model.jsonResponse);
                          Navigator.of(context).pushNamed("/VersusPage");
                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
